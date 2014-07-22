#!/bin/bash

# This program syncs the eclipse workspace between the computers within my network

CreateEWORKSPACE="export EWORKSPACE=" # Create a Global Variable called EWORKSPACE
CreateDESTINATION="export DESTINATION=" # Create a Global Variable called DESTINATION
ENVIRONMENT=/etc/environment # Where the Global Variables will be written to.

# Below will execute if no options are passed

[ $# -eq 0 ] && {

echo "Usage: $0 [ options ]"
echo 
echo "options: "
echo "-u, --upload        upload to destination"
echo "-d, --download      download from destination"
echo "-nd                 use temporary destination"

exit 0;

}

# Checks to see if Global Variable EWORKSPACE exists, if not, you will be asked to define the directory of it.

if [ ! -n "$EWORKSPACE" ]; then
    echo "Eclipse Workspace directory is not defined"
    read -p "Define directory of your current Eclipse Workspace: " defineEWORKSPACE
    sudo echo "$CreateEWORKSPACE$defineEWORKSPACE" >> "$ENVIRONMENT"
fi

# Checks to see if Global Variable DESTINATION exists, if not, you will be asked to define the directory of it.

if [ ! -n "$DESTINATION" ]; then
    echo "destination not found.";
    read -p "Define directory of the destination: " defineDESTINATION
    sudo echo "$CreateDESTINATION$defineDESTINATION" >> "$ENVIRONMENT"
fi

# Makes a hidden folder for the workspaces to merge

if [ ! -d "$DESTINATION/.EWorkspace" ]; then
	cd $DESTINATION
	mkdir .EWorkspace
fi

# if option -u, --upload, or -U are used, it will upload data to the server

if [[ $1 == "-u" || $1 == "--upload" || $1 == "-U" ]]; then
    echo "Syncing..."

    \cp -fR $EWORKSPACE/* $DESTINATION/.EWorkspace

    if [[ $? -eq 0 ]]; then
	echo "Successfully Synced."
    else
	echo "There was an error while syncing."
    fi
fi

# if option -d, --download, or -D are used, it will download data from the server

if [[ $1 == "-d" || $1 == "-D" || $1 == "--download" ]]; then
    echo "Downloading..."

    \cp -fR $DESTINATION/.EWorkspace/* $EWORKSPACE

    if [[ $? -eq 0 ]]; then
	echo "Successfully downloaded."
    else
	echo "There was an error while downloading."
    fi
fi

# if option -nd, -Nd, -nD, or -ND are used, you can use a different server for the upload

if [[ $1 == "-nd" || $1 == "-Nd" || $1 == "-nD" || $1 == "-ND" ]]; then
    read -p "Define directory of temporary destination: " newDEST
    cd newDEST
    mkdir .Eworkspace
    \cp -fR $EWORKSPACE/* $newDEST/.Eworkspace

    if [[ $? -eq 0 ]]; then
	echo "Successfully uploaded to $newDEST"
    else
	echo "There was an error while uploading to $newDEST"
    fi
fi

exit
