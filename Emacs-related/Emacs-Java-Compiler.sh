#!/bin/bash

# Bash script written to compile java in Emacs

if [[ "$1" == "-h" || "$1" == "-H" || "$1" == "--help" || "$1" == "--Help" ]]; then
    echo "Usage: emacsjavac [ options ]"
    echo 
    echo "options: "
    echo "-x                  compile javax program."
    echo "-h, --help          you are here."
    echo "-a, --all-files     compile all files in directory."
    echo "-ax, --allx-files   compile all javax files in directory"
    exit
fi

if [[ "$1" == "-x" || "$1" == "-X" ]]; then
    [ -f "$(basename $2 .class)" ] && rm $(basename $2 .java).class
    echo "Compiling $2 ... "
    javac $2
    echo "Executing Java Swing program ... "
    java $(basename $2 .java) 
    exit 0
fi

if [[ "$1" == "-a" || "$1" == "-A" || "$1" == "--all-files" ]]; then
    [ -f "$(basename $2 .class)" ] && rm $(basename $2 .java).class
    
    for file in *java
    do
	echo "Compiling $file ... "
	javac $file
    done

    echo "-----------OUTPUT-----------"
    java $(basename $2 .java)
    exit
fi

if [[ "$1" == "-ax" || "$1" == "-AX" || "$1" == "--allx-files" ]]; then
    [ -f "$(basename $2 .class)" ] && rm $(basename $2 .java).class
    
    for file in *java
    do
	echo "Compiling $file ... "
	javac $file
    done

    echo "Executing Java Swing program ... "
    java $(basename $2 .java)
    exit
fi

[ -f "$(basename $1 .class)" ] && rm $(basename $1 .class)

echo "Compiling $1 ... "
javac $1

echo "-----------OUTPUT-----------"
java $(basename $1 .java)
