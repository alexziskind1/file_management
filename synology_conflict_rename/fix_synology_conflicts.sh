#!/usr/bin/env bash
#
# Usage:
#   ./fix_synology_conflicts.sh /path/to/folder
#
# Description:
#   1) Finds all files whose names contain:
#      "_MacBook-Pro.fios-router.home_<stuff>_Conflict"
#   2) Removes any zero-byte original that has the same final name
#   3) Renames the conflict file to restore the original name
#
# Requirements:
#   - Must run in Bash (not sh).
#   - Tested on macOS's default Bash (3.2).
#   - No extra packages needed.

# 1. Check argument
if [[ -z "$1" || ! -d "$1" ]]; then
  echo "Usage: $0 /path/to/folder"
  exit 1
fi

TARGET_DIR="$1"

# 2. Find conflict files in TARGET_DIR (null-delimited)
find "$TARGET_DIR" -type f -name "*_MacBook-Pro.fios-router.home_*_Conflict*" -print0 |
while IFS= read -r -d '' conflict_file; do

  conflict_dir="$(dirname "$conflict_file")"
  conflict_base="$(basename "$conflict_file")"

  # 3. Use Bash regex to see if conflict_base has:
  #    a) some prefix => (.*)
  #    b) "_MacBook-Pro.fios-router.home_"
  #    c) anything up to "_Conflict"
  #    d) capture the final extension => (\.[^.]+)
  #
  #    e.g. "foo_MacBook-Pro.fios-router.home_bar_Conflict.mp4"
  #          => prefix=foo, extension=.mp4
  if [[ "$conflict_base" =~ ^(.*)_MacBook-Pro\.fios-router\.home_.*_Conflict(\.[^.]+)$ ]]; then
    prefix="${BASH_REMATCH[1]}"
    extension="${BASH_REMATCH[2]}"

    original_name="${prefix}${extension}"
    original_path="${conflict_dir}/${original_name}"

    # If there's a zero-byte original, remove it
    if [[ -f "$original_path" && ! -s "$original_path" ]]; then
      echo "Removing zero-byte original: $original_path"
      rm "$original_path"
    fi

    echo "Renaming conflict file:"
    echo "  From: $conflict_file"
    echo "  To:   $original_path"
    mv "$conflict_file" "$original_path"

  else
    echo "Skipping (no conflict pattern found): $conflict_file"
  fi

done

echo "Done processing conflict files."