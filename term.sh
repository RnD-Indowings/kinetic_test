#!/bin/bash

previous_pid=""

while true; do
    # Open a new terminal
    gnome-terminal &
    
    # Wait for 2 seconds to ensure the new terminal is launched
    sleep 2

    # Get the PID of the most recently opened GNOME terminal
    new_pid=$(pgrep -n gnome-terminal)

    # Kill the previous terminal **after** the new one has opened
    if [ ! -z "$previous_pid" ]; then
        kill "$previous_pid" 2>/dev/null
    fi

    # Store the new terminal's PID for the next iteration
    previous_pid=$new_pid

    # Wait for 60 seconds before repeating
    sleep 60
done
