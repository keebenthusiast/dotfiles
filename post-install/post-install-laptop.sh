#!/bin/bash

# A very simple post-install script to get everything up and running.
# Primarily designed for my laptop running arch.


# check if the user is root
if [ "$( id -u )" != 0 ]; then
    echo "Script needs to be run as root."
    exit 1
fi

EDITOR=emacs # change to favorite text editor
SERVERIP=127.0.0.1 # change to server's proper IP
MNTPT=/hdd1 # change to appropriate nfs share location
BACKUPLOC=/.backups-system-files/`hostname` # change as needed!
LOGIND=/etc/systemd/logind.conf

# start network manager
echo "starting NetworkManager"
systemctl enable NetworkManager

# edit logind file to fix suspend issue with xfce4-power-manager
$EDITOR $LOGIND -nw

# install a couple programs from the AUR with packer
echo "Installing a couple programs from the AUR"
packer -S pnmixer compton xfce4-volumed ld-lsb

# mount the server and copy everything to the following directories.
echo "mounting server.. "
mount -t nfs4 $SERVERIP:$MNTPT /mnt

echo "copying data to $HOME"
cp -r /mnt$BACKUPLOC$HOME $HOME

echo "copying data to /etc"
cp /mnt$BACKUPLOC/etc /etc

echo "copying data to /usr"
cp -r /mnt$BACKUPLOC/usr /usr

echo "Process is complete!"

read -p "reboot now? y/n: " exitR
if [ "$exitR" = "y" ]; then
    reboot
fi