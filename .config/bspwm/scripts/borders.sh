#!/bin/sh
# Enable double borders
# Dependencies: chwb2 from wmutils/opt
#
# Yes, this is stolen from gk.

outer='0x1e1e2e' # outer
inner1='0xcba6f7' # focused
inner2='0xfab387' # normal

trap 'bspc config border_width 0; kill -9 -$$' INT TERM

targets() {
 	case $1 in
		focused) bspc query -N -n .local.focused.\!fullscreen;;
		normal)  bspc query -N -n .local.\!focused.\!fullscreen
	esac | grep -iv "$v"
}

get_hex () {
  local originalHex=$1
  echo $originalHex | sed 's/0x/#/g'
}

bspc config border_width 18
bspc config normal_border_color "$(get_hex $outer)"
bspc config focused_border_color "$(get_hex $outer)"

draw() { chwb2 -I "$inner" -O "$outer" -i "4" -o "9" $* |:; }

# initial draw, and then subscribe to events
{ echo; bspc subscribe node_geometry node_focus; } |
 	while read -r _; do
		[ "$v" ] || v='abcdefg'
		inner=$inner1 draw "$(targets focused)"
		inner=$inner2 draw "$(targets normal)"
    done
