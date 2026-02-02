#!/bin/bash
if [ -z "$1" ]; then 
    echo "Please enter the name of the file you would like to check."
    read FILENAME;
else 
    FILENAME="$1"
fi

if [ -z "$FILENAME" ]; then
    echo "ERROR: No file provided.";
else 
    if [ -e "$FILENAME" ]; then
        if [ -r "$FILENAME" ]; then
            echo "You can Read";
        else
            echo "You cannot Read";
        fi
        if [ -w "$FILENAME" ]; then
            echo "You can Write";
        else
            echo "You cannot Write";
        fi
        if [ -x "$FILENAME" ]; then
            echo "You can eXecute";
        else
            echo "You cannot eXecute";
        fi
    else
        echo "ERROR: file '$FILENAME' does not exist."
    fi
fi
