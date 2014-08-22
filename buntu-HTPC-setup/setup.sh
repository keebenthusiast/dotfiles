#!/bin/bash

# Script installs all the needed libs to make an HTPC running a *buntu.
# To be run as root.

# check if the user is root
if [ "$( id -u )" != 0 ]; then 
	echo "Script needs to be run as root."
  	exit 1
fi

# start by installing vlc
echo "Installing vlc..."
apt-get install vlc

# install dvd libs: libdvdcss2, libdvdread4, libdvdnav4 for example
echo "Installing required libs to play DVDs..."
apt-get install libdvdread4 libdvdnav4

# for some reason libdvdcss2 has no installation candidate,
# so the deb will need to be downloaded and installed.

case $(uname -m) in
   "x86_64") echo "downloading amd64 file ..." 
	wget http://download.videolan.org/pub/debian/stable/libdvdcss2_1.2.13-0_amd64.deb
	;;
   "i*86") echo "downloading i386 file ..." 
	wget http://download.videolan.org/pub/debian/stable/libdvdcss2_1.2.13-0_i386.deb
	;;
   *) echo "invalid or unknown architecture" 
	exit
	;;
esac

dpkg -i libdvdcss2*.deb

# install libdvdcss
/usr/share/doc/libdvdread4/install-css.sh

# Install Ubuntu Restricted Extras ( Optional )
#apt-get install ubuntu-restricted-extras

# asks the user if they want to install bluray libs as well or no.
read -p "Complete, install bluray libs as well? y/n: " SiyNo

if [[ "$SiyNo" = "n" || "$SiyNo" = "N" ]]; then
	echo "Operation Completed!"
	exit
else
	# Install bluray libs: libaacs0, libbluray-bdj, libbluray1
	apt-get install libaacs0 libbluray1 libbluray-bdj

	# make initial aacs key
	cd $HOME
	mkdir -p $HOME/.config/aacs
	cd $HOME/.config/accs
	wget http://vlc-bluray.whoknowsmy.name/files/KEYDB.cfg
	cd $HOME
fi

# command for mounting bluray ISO(s)
#sudo mount -o loop -t udf DirectoryofBluray.iso /media/cdrom

echo "Operation Completed! Enjoy."
exit
