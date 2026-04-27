#!/bin/bash

# Set source and destination folders
SOURCE_FOLDER="$1"
DESTINATION_FOLDER="$2"

# Check if both arguments are provided
if [ -z "$SOURCE_FOLDER" ] || [ -z "$DESTINATION_FOLDER" ]; then
  echo "Usage: $0 <source_folder> <destination_folder>"
  exit 1
fi

# Ensure ffprobe is installed
if ! command -v ffprobe &> /dev/null; then
  echo "ffprobe could not be found. Please install ffmpeg."
  exit 1
fi

# Loop through all mp3 files in the source folder
find "$SOURCE_FOLDER" -type f -name "*.mp3" | while read -r FILE; do
  # Extract artist and album metadata using ffprobe
  ARTIST=$(ffprobe -v quiet -show_entries format_tags=artist \
            -of default=noprint_wrappers=1:nokey=1 "$FILE")
  ALBUM=$(ffprobe -v quiet -show_entries format_tags=album \
            -of default=noprint_wrappers=1:nokey=1 "$FILE")

  # Handle missing metadata gracefully
  ARTIST=${ARTIST:-"Unknown Artist"}
  ALBUM=${ALBUM:-"Unknown Album"}

  # Create destination folder for artist and album
  TARGET_FOLDER="$DESTINATION_FOLDER/$ARTIST/$ALBUM"
  mkdir -p "$TARGET_FOLDER"

  # Copy the mp3 file to the target folder
  cp "$FILE" "$TARGET_FOLDER"
  echo "Copied '$FILE' to '$TARGET_FOLDER'"
done

echo "Music files organized successfully!"