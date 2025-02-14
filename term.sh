#!/bin/bash

previous_pid=""

while true; do
    # Launch a new GNOME terminal
    gnome-terminal &

    # Wait 2 seconds to ensure the new terminal has started
    sleep 2

    # Get the most recently opened terminal's PID
    new_pid=$(pgrep -n gnome-terminal)

    # Kill the previous terminal only after the new one is running
    if [[ ! -z "$previous_pid" && "$previous_pid" != "$new_pid" ]]; then
        kill "$previous_pid" 2>/dev/null
    fi

    # Store the new terminal's PID for the next iteration
    previous_pid=$new_pid

    # Wait for 60 seconds before repeating
    sleep 60
done
