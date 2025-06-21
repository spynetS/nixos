#!/bin/sh
ln -s $(pwd)/home-manager $HOME/.config/home-manager

FILE_TO_BACKUP="/etc/nixos/configuration.nix"  # Change this to the file you want to back up
BACKUP_LOCATION="/etc/nixos/configuration--backup.nix"  # Change this to your desired backup location
SYMLINK_TARGET="$HOME/.config/nixos/configuration.nix"  # Change this to the target of the symlink

# Check if the file exists
if [ -e "$FILE_TO_BACKUP" ]; then
    # Prompt the user for confirmation
    read -p "The file '$FILE_TO_BACKUP' exists. Do you want to back it up and create a symlink? (y/n): " choice

    if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
        # Create a backup of the file
        sudo cp "$FILE_TO_BACKUP" "$BACKUP_LOCATION"
        echo "Backup created at '$BACKUP_LOCATION'."

        # Remove the original file
        sudo rm "$FILE_TO_BACKUP"
        echo "Removed '$FILE_TO_BACKUP'."

        # Create the symbolic link
        sudo ln "$SYMLINK_TARGET" "$FILE_TO_BACKUP"
        echo "Created symlink '$FILE_TO_BACKUP' -> '$SYMLINK_TARGET'."
    else
        echo "Operation canceled. No changes made."
    fi
else
    echo "The file '$FILE_TO_BACKUP' does not exist."
fi
