#!/bin/bash

# Function to recursively find files and directories with leading or trailing whitespace in their names
find_whitespace() {
    local dir="$1"
    # Find all files and directories in the given directory
    find "$dir" -depth | while IFS= read -r path; do
        # Extract the basename of the path
        name=$(basename "$path")
        # Check if the name has leading or trailing whitespace
        if [[ "$name" =~ ^[[:space:]]+ ]] || [[ "$name" =~ [[:space:]]+$ ]]; then
            echo "Whitespace in: $path"
        fi
    done
}

# Check if a directory was provided as an argument
if [[ -z "$1" ]]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# Call the function with the provided directory
find_whitespace "$1"