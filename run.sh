#!/bin/bash
############################################
### Terminator Tabbed by DaddyBigFish
# Requires: xdotool, terminator
sudo apt install xdotool terminator -y
###########################################

# Path to the temporary file
TMP_FILE="/tmp/tab_number"
PYTHON_SCRIPT="/path/to/your_script.py"  # Change this to your script's path

# Initialize or read the current tab number
if [ ! -f "$TMP_FILE" ]; then
    echo 0 > "$TMP_FILE"
fi

terminator & disown
sleep 1
uuid=$(remotinator get_terminals | grep uuid)
export TERMINATOR_UUID=$uuid

# Define the titles
declare -a TITLES=("nmap" "curl" "ffuf" "arjun" "nc")

while true; do
    WID=$(xdotool search --onlyvisible --class terminator | head -n 1)
    # Read the current tab number
    TAB_NUMBER=$(cat "$TMP_FILE")

    # Check if all tab titles have been set
    if [ "$TAB_NUMBER" -ge "${#TITLES[@]}" ]; then
        WID=$(xdotool search --onlyvisible --class terminator | head -n 1)
        xdotool windowactivate --sync $WID key "ctrl+Page_Down"
        remotinator set_tab_title -t "home"
        echo "All tab titles have been set. Exiting."
        rm "$TMP_FILE"  # Clean up the tmp file
        exit 0
    fi

    # Create a new tab
    echo "Creating a new tab."
    remotinator new_tab

    # Set the tab title based on the current number
    TITLE="${TITLES[$TAB_NUMBER]}"
    echo "Setting tab title to: $TITLE"
    remotinator set_tab_title -t "$TITLE"

    # Run the Python script in the first tab
    if [ "$TAB_NUMBER" -eq 0 ]; then
        echo "Running Python script in the first tab..."
        remotinator send_command "python3 $PYTHON_SCRIPT"
    fi

    # Increment the number and update the temporary file
    NEW_TAB_NUMBER=$((TAB_NUMBER + 1))
    echo "$NEW_TAB_NUMBER" > "$TMP_FILE"
done
