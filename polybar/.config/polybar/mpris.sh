#!/bin/bash

# Specifying the icon(s) in the script
# This allows us to change its appearance conditionally
icon=""

player_status=$(playerctl status 2> /dev/null)
if [[ $? -eq 0 ]]; then
    metadata="$(playerctl metadata title 2> /dev/null| awk '{if (length($0) > 30) {print substr($0, 0, 31)"…"} else print $0}') - $(playerctl metadata artist 2> /dev/null | awk '{if (length($0) > 30) {print substr($0, 0, 31)"…"} else print $0}')"
fi

# Foreground color formatting tags are optional
if [[ $player_status = "Playing" ]]; then
    echo " $metadata  "       # Orange when playing
elif [[ $player_status = "Paused" ]]; then
    echo " $metadata  "
else
    echo "​"                 # Greyed out icon when stopped
fi
