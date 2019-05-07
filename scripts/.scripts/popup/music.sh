#!/bin/sh
cd $(dirname $0)

[ -z "$SCREEN" ] && SCREEN=$($HOME/.scripts/activescreen.sh)
if [ ! -z "$(xrandr | grep "$SCREEN" | grep "primary")" ]; then
  screenxoffset=$(xrandr | grep "$SCREEN" | cut -d' ' -f4 | grep -oP '(?<=\+)\d+(?=\+)')
  screenyoffset=$(xrandr | grep "$SCREEN" | cut -d' ' -f4 | grep -oP '(?<=\+)\d+$')
else
  screenxoffset=$(xrandr | grep "$SCREEN" | cut -d' ' -f3 | grep -oP '(?<=\+)\d+(?=\+)')
  screenyoffset=$(xrandr | grep "$SCREEN" | cut -d' ' -f3 | grep -oP '(?<=\+)\d+$')
fi
left=$(bc <<< "50 + $screenxoffset")
top=$(bc <<< "130 + $screenyoffset")

destroypopup() {
  pkill -f "n30f.*bg-player\.png"
  pkill -f "n30f.*albumart\.png"
  killall -q lemonbar
  pkill -f "^sh.*music\.sh"
}

drawpopup() {
  status=$(playerctl status 2>/dev/null)
  if [ -z "$status" ]; then
    exit 1
  fi

  artist=$(echo $(playerctl metadata xesam:artist) | awk '{if (length($0) > 40) {print substr($0, 0, 41)"..."} else print $0}')
  track=$(echo $(playerctl metadata xesam:title) | awk '{if (length($0) > 40) {print substr($0, 0, 41)"..."} else print $0}')
  album=$(echo $(playerctl metadata xesam:album) | awk '{if (length($0) > 40) {print substr($0, 0, 41)"..."} else print $0}')
  

  if [ "$status" == "Playing" ]; then
    playglyph=""
  else
    playglyph=""
  fi
  playbutton="%{A:~/.scripts/popup/music.sh pause:}$playglyph%{A}"
  nextbutton="%{A:~/.scripts/popup/music.sh next:}%{A}"
  prevbutton="%{A:~/.scripts/popup/music.sh prev:}%{A}"
  controltext="$prevbutton    $playbutton    $nextbutton"

  volume=$(pamixer --get-volume)
  volumebar="Vol: $volume $(~/.scripts/progress $volume)"

  WIDTH=284 HEIGHT=284 ../getalbumart

  n30f -x "$left" -y "$top" ~/.scripts/popup/bg-player.png&
  sleep 0.1
  n30f -x $(bc <<< "$left + 13") -y $(bc <<< "$top + 13") /tmp/albumart.png&

  DURATION="unlimited" BG="#00000000" OVERLAY="true" GEOMETRY="860x48+$(bc <<< "$left + 312")+$(bc <<< "$top + 20")" ./popup.sh "%{c}$artist"&
  DURATION="unlimited" BG="#00000000" OVERLAY="true" GEOMETRY="860x48+$(bc <<< "$left + 312")+$(bc <<< "$top + 68")" ./popup.sh "%{c}$track"&
  DURATION="unlimited" BG="#00000000" OVERLAY="true" GEOMETRY="860x48+$(bc <<< "$left + 312")+$(bc <<< "$top + 116")" ./popup.sh "%{c}$album"&

  DURATION="unlimited" BG="#00000000" OVERLAY="true" GEOMETRY="860x48+$(bc <<< "$left + 312")+$(bc <<< "$top + 180")" ./popup.sh "%{c}$controltext"&
  DURATION="unlimited" BG="#00000000" OVERLAY="true" GEOMETRY="860x48+$(bc <<< "$left + 312")+$(bc <<< "$top + 232")" ./popup.sh "%{c}$volumebar"&
  sleep 4.9
  destroypopup
}

if [ "$1" == "pause" ]; then
  playerctl play-pause
elif [ "$1" == "next" ]; then
  playerctl next
elif [ "$1" == "prev" ]; then
  playerctl previous
fi

sleep 0.1

if [ -z $(pgrep -f "n30f.*bg-player\.png") ]; then
  drawpopup
else
  destroypopup
  drawpopup
fi
