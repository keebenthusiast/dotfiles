#!/bin/bash

# Directories of where the notes will be going.

NOTE_DIR1=$HOME/documents/Computer-Science/CS-13/Notes/ # Computer Science note Directory
NOTE_DIR2=$HOME/documents/1C/notes/ # English note Directory
NOTE_DIR3=$HOME/documents/Bio11/notes/
CURRENT_DATE=$(date +"%m-%d-%Y") # Allows me to save the note with the current date.

EDITOR=emacs -nw
#EDITOR=nano

if [ $# -eq 0 ]; then
    cd $NOTE_DIR1 # Change to the Directory where the notes will be going.
    emacs notes$CURRENT_DATE # starts a text editor called notes<insert date here>
    exit 0
fi
#nano notes$CURRENT_DATE
#$EDITOR notes$CURRENT_DATE

if [[ $1 == "-b" || $1 == "-B" || $1 == "--biology" ]]; then
    cd $NOTE_DIR3
    emacs notes$CURRENT_DATE
    exit 0
fi
