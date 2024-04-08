#!/bin/bash

# Check if the correct number of arguments are passed (expecting 3 arguments)
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <directory> <old_string> <new_string>"
    exit 1
fi

# Assign arguments to variables for better readability
DIRECTORY=$1
OLD_STRING=$2
NEW_STRING=$3

# Loop through all files in the directory that contain the old string in their names.
find "$DIRECTORY" -type f -name "*${OLD_STRING}*" | while read file; do
    # Extract the filename from the path
    filename=$(basename "$file")
    
    # Replace the old string with the new string in the filename
    newfilename=$(echo "$filename" | sed "s/$OLD_STRING/$NEW_STRING/g")
    
    # Move (rename) the file to the new filename
    mv "$file" "${file%/*}/$newfilename"
    
    echo "Renamed '$filename' to '$newfilename'"
done

echo "All applicable files have been renamed."
