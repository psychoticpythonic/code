#!/bin/bash

# Define the path to the Dunst configuration file
config_file="/home/notroot/.config/dunstrc"

# Get the initial checksum of the config file
previous_checksum=$(md5sum "$config_file" | awk '{print $1}')

# Run indefinitely
while true; do
    # Sleep for a certain interval (e.g., 5 seconds)
    sleep 5

    # Get the current checksum of the config file
    current_checksum=$(md5sum "$config_file" | awk '{print $1}')

    # Compare the current and previous checksums
    if [ "$current_checksum" != "$previous_checksum" ]; then
        # If the checksums are different, the file has been modified
        # Restart the D-Bus service
#        sudo systemctl restart dbus.service
#	sleep 2        
        # Run notify-send
        notify-send "Dunst Config Updated" "The Dunst configuration file has been modified."

        # Update the previous checksum to the current checksum
        previous_checksum="$current_checksum"
    fi
done
