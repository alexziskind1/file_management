
# File Renamer Script

This shell script is designed to rename files in a specified directory by replacing a specified substring in filenames with a new substring. It's useful for batch renaming operations where consistent changes to file names are needed.

## Requirements

- A Unix-like operating system (Linux, macOS)
- Bash shell

## Installation

1. Download the script to your local machine.
2. Make the script executable by running the following command:

```bash
chmod +x rename_files.sh
```

Replace `rename_files.sh` with the name of the script file if you have named it differently.

## Usage

To use the script, you'll need to provide three arguments: the path to the directory containing the files you want to rename, the substring you want to replace, and the new substring you want to insert. 

```bash
./rename_files.sh <directory> <old_string> <new_string>
```

### Examples

- To rename all files in the current directory, replacing "oldterm" with "newterm":

```bash
./rename_files.sh . oldterm newterm
```

- To rename files in `/path/to/directory`, replacing "2019" with "2020":

```bash
./rename_files.sh /path/to/directory 2019 2020
```

## Features

- Supports renaming files in any specified directory.
- Uses `find` and `sed` for efficient processing.
- Safe for filenames with spaces and special characters.
- Provides clear
