#!/bin/bash

# You can call this script like this:
# $./volume.sh up
# $./volume.sh down
# $./volume.sh mute

function get_volume {
    amixer get Master -M | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1
}

function is_mute {
    amixer get Master | grep '%' | grep -oE '[^ ]+$' | grep off > /dev/null
}

function send_notification {
    volume=`get_volume`
    echo $volume
    # Make the bar with the special character ─ (it's not dash -)
    # https://en.wikipedia.org/wiki/Box-drawing_character
    case $volume in
	    0)
		    dunstify -a volume -t 8000 -r 2593 -u normal "" "  $volume%"
		;;
	    *)
    		bar=$(echo $(seq -s "─" $((1+($volume / 5))))$(seq -s " " $((21-($volume / 5)))) | sed 's/[0-9]//g')
    		# Send the notification
    		dunstify -a volume -t 8000 -r 2593 -u normal "" "  $bar $(printf "%02d" $volume)%"
		;;
    esac
}

case $1 in
    up)
	# Set the volume on (if it was muted)
	amixer set Master on > /dev/null
	# Up the volume (+ 5%)
	amixer sset Master 1%+ -M > /dev/null
	send_notification
	;;
    down)
	amixer set Master on > /dev/null
	amixer sset Master 1%- -M > /dev/null
	send_notification
	;;
    mute)
    	# Toggle mute
	amixer set Master 1+ toggle > /dev/null
	if is_mute ; then
	    dunstify -a volume -t 8000 -r 2593 -u normal ""
	else
	    send_notification
	fi
	;;
esac
