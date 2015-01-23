#!/bin/bash

###########################################################################################
##
## This script utilizes git to sync eclipse workspaces
##
## TO DO:
## 
## - eliminate need for the 2 different workspace directories 
## - let usage occur when incorrect parameter is passed
##
##
##
##
##
##
##
###########################################################################################

[[ $# -eq 0 ]] && { # execute this if no parameters are passed

echo "Usage: $0 [ options ]"
echo 
echo "options: "
echo "-s,  --sync              sync client to host"
echo "-p,  --pull              retrieve data from host"
echo "-nd, --new-destination   retrieve data to temporary destination"

exit 0;

}

# The snippet below executes when either -s or --sync are entered
# it first copies everything from the client to the repository
# git then adds, commits, and finally pushes changes to repository

if [[ $1 == "-s" || $1 == "--sync" ]]; then
    echo "Syncing..."

    #\cp -fR $EWORKSPACE/* $ESYNCREPO

    cd $ESYNCREPO
    git add * # add everything potentially added to the repo
    git commit -a # create a commit so the host can house the data.
    git push # then finally, push the data ( requires login )
    
    if [[ $? -eq 0 ]]; then
	echo "Successfully Synced."
    else
	echo "There was an error while syncing."
    fi
fi

# The following snippet executes when -u or --update is entered
# changes to repository, git pulls the repository, then copies over to 
# the client's workspace.

if [[ $1 == "-u" || $1 == "--update" ]]; then
    echo "Updating..."

    cd $ESYNCREPO
    git pull # Pull everything from the host

    #\cp -fR $ESYNCREPO/* $EWORKSPACE

    if [[ $? -eq 0 ]]; then
	echo "Successfully Updated."
    else
	echo "There was an error while updating."
    fi
fi
