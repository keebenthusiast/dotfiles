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

# To make this possible, Copy the following file

# cp /etc/X11/xinit/xserverrc ~/.xserverrc 

#then use either of the following commands:

# xinit $WMorDE
# startx ~/.xinitrc $WMorDE

case $session in
    i3|i3wm ) exec $DBUS i3 
	;;
    dwm|DWM ) exec $DBUS dwm 
	;;
    *       ) exec $DBUS $1
	;;
esac
