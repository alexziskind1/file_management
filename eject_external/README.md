# Eject All External Drives on Mac

This guide provides instructions on creating a script for macOS that ejects all external drives. The script will be executable by double-clicking.

## Step 1: Create the Shell Script

1. **Open Terminal**: Find Terminal in your `/Applications/Utilities` folder.
2. **Create a New File**: Type `nano eject_all.sh` in Terminal and press Enter to open the nano text editor with a new file named `eject_all.sh`.
3. **Insert the Script**: Copy and paste the following script into nano:

    ```bash
    #!/bin/bash
    
    # This script ejects all external drives
    
    osascript -e 'tell application "Finder" to eject (every disk whose ejectable is true)'
    ```

4. **Save and Exit**: Press `Ctrl + O`, then Enter to save the file. Press `Ctrl + X` to exit nano.

## Step 2: Make the Script Executable

1. Ensure you are in the same directory as your script. Use the `cd` command to navigate if necessary.
2. Type `chmod +x eject_all.sh` in Terminal and press Enter to make your script executable.

## Step 3: Create an AppleScript Wrapper for Double-Click Execution

1. **Open Script Editor**: Located in your `/Applications/Utilities` folder.
2. **Create a New Script**: Copy and paste the following AppleScript into the Script Editor:

    ```applescript
    do shell script "bash /path/to/eject_all.sh"
    ```

    Replace `/path/to/eject_all.sh` with the actual path to your shell script.

3. **Save as an Application**: Go to `File` > `Save`, choose a location and a name for your script. Change the `File Format` to `Application` for double-click execution.

## Step 4: Double-Click to Run

Double-click the AppleScript application you created to run the shell script, ejecting all external drives.

## Additional Notes:

- Make sure the path in the AppleScript correctly points to your shell script.
- This script ejects all ejectable volumes. Adjust the script if you have specific requirements.
- Test the script with non-critical data to ensure it works as expected.

By following these steps, you will have a double-clickable application on your Mac that ejects all external drives when executed.