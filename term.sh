#!/bin/bash

previous_pid=""

while true; do
    # Open a new terminal and capture its PID
    gnome-terminal &
    new_terminal_pid=$!

    # Wait 2 seconds to ensure the new terminal has started
    sleep 2

    # Kill the previous terminal only if it exists
    if [[ ! -z "$previous_pid" ]]; then
        kill "$previous_pid" 2>/dev/null
    fi

    # Store the new terminal's PID for the next iteration
    previous_pid=$new_terminal_pid

    # Wait for 60 seconds before repeating
    sleep 60
done
