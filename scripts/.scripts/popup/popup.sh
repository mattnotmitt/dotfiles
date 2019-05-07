#!/bin/sh

[ -z $DURATION ] && DURATION=3

# define geometry
[ -z "$SCREEN" ] && SCREEN=$($HOME/.scripts/activescreen.sh)

if [ ! -z "$(xrandr | grep "$SCREEN" | grep "primary")" ]; then
  screenxoffset=$(xrandr | grep "$SCREEN" | cut -d' ' -f4 | grep -oP '(?<=\+)\d+(?=\+)')
  screenyoffset=$(xrandr | grep "$SCREEN" | cut -d' ' -f4 | grep -oP '(?<=\+)\d+$')
else
  screenxoffset=$(xrandr | grep "$SCREEN" | cut -d' ' -f3 | grep -oP '(?<=\+)\d+(?=\+)')
  screenyoffset=$(xrandr | grep "$SCREEN" | cut -d' ' -f3 | grep -oP '(?<=\+)\d+$')
fi

[ -z "$XOFFSET" ] && XOFFSET=20
[ -z "$YOFFSET" ] && YOFFSET=20

[ -z "$WIDTH" ] && WIDTH=800
[ -z "$HEIGHT" ] && HEIGHT=120

barx=$(bc <<< "$XOFFSET + $screenxoffset")
bary=$(bc <<< "$YOFFSET + $screenyoffset")
barw="$WIDTH"
barh="$HEIGHT"

[ -z $GEOMETRY ] && GEOMETRY="${barw}x${barh}+${barx}+${bary}"

[ -z $BG ] && BG='#cc282c34'
[ -z $FG ] && FG='#ffabb2bf'

# font used
bar_font="OperatorMonoLigNerdFont-8"
icon_font='-wuncon-siji-medium-r-normal--11-100-*-*-*-*-iso10646-*'


[ ! -z $OVERLAY ] && NAME="panel_overlay"

baropt="-d -g ${GEOMETRY} -F ${FG} -B${BG} -f ${bar_font} -f ${icon_font}"

[ ! -z $NAME ] && baropt="$baropt -n $NAME"

if [ "$DURATION" == "unlimited" ]; then
  echo "$@" | lemonbar ${baropt} -p | sh
else
  (echo "%{c}$@"; sleep ${DURATION}) | lemonbar ${baropt} | sh
fi
