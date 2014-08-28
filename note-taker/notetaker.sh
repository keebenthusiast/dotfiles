#!/bin/bash

# Directories of where the notes will be going.

NOTE_DIR1=$HOME/dir1/notes # edit as needed
NOTE_DIR2=$HOME/dir2/notes #
NOTE_DIR3=$HOME/dir3/notes #
CURRENT_DATE=$(date +"%m-%d-%Y") # Allows me to save the note with the current date.

EDITOR=emacs
#EDITOR=nano

if [ $# -eq 0 ]; then
    cd $NOTE_DIR1 # Change to the Directory where the notes will be going.
    $EDITOR notes$CURRENT_DATE # starts a text editor called notes<insert date here>
    exit 0
fi
#nano notes$CURRENT_DATE
#$EDITOR notes$CURRENT_DATE

if [[ $1 == "-3" || $1 == "--dir3" ]]; then
    cd $NOTE_DIR3
    $EDITOR notes$CURRENT_DATE
    exit 0
fi
