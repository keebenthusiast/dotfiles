#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

DBUS=dbus-launch
session=${1:i3}

case $session in
    i3  ) exec $DBUS i3 
	;;
    dwm ) exec $DBUS dwm 
	;;
    *   ) echo "invalid WM or DE, executing Default" && exec $DBUS i3 
	;;
esac

#exec dbus-launch i3
#exec dbus-launch dwm
