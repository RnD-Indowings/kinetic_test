#!/bin/bash

previous_pid=""

while true; do
    # Store the currently running gnome-terminal process before launching a new one
    previous_pid=$(pgrep -n gnome-terminal)

    # Open a new terminal
    gnome-terminal &
    
    # Wait for 2 seconds to ensure the new terminal is running
    sleep 2

    # Kill the previous terminal, ensuring we don't kill the new one
    if [ ! -z "$previous_pid" ]; then
        kill "$previous_pid" 2>/dev/null
    fi

    # Wait 60 seconds before launching the next terminal
    sleep 60
done
