#!/bin/bash

previous_pid=""

while true; do
    # Find the PID of the last opened gnome-terminal before launching a new one
    previous_pid=$(ps -eo pid,cmd --sort=start_time | grep "gnome-terminal" | grep -v "grep" | awk 'END{print $1}')

    # Open a new GNOME terminal
    gnome-terminal &

    # Wait 2 seconds to ensure the new terminal starts
    sleep 2

    # Kill the previous terminal **only if it exists**
    if [[ ! -z "$previous_pid" ]]; then
        kill "$previous_pid" 2>/dev/null
    fi

    # Wait 60 seconds before repeating
    sleep 60
done
