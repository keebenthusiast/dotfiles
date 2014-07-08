#if [[ $1 == "-rp" || $1 == "--ratpoison" ]] # If ratpoison is selected, it goes there instead.
#    exec dbus-launch ratpoison
#fi

exec dbus-launch i3 # Default WM

#exec dbus-launch ratpoison

#xcompmgr -c &

#compton --vsync opengl

compton --config <$HOME/.config/compton.conf> -b
