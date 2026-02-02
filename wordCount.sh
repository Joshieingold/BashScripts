#!/bin/bash

if [ -z "$1" ]; then 
    echo "Please enter the name of the file you would like to check."
    read FILENAME;
else 
    FILENAME="$1"
fi

FileCheck() {
    # Check if file name was provided 
    if [ -z "$FILENAME" ]; then
        echo "ERROR: no file provided.";
        return 1;
    fi
    # Check if file exists 
    if [ ! -e "$FILENAME" ]; then
        echo "ERROR: file '$FILENAME' does not exist.";
        return 1;
    fi
    # Check if user has read permissions
    if [ ! -r "$FILENAME" ]; then
        echo "ERROR: You do not have read permissions.";
        return 1;
    fi
    return 0;
}


# all tests passed
if FileCheck; then
    cat $FILENAME | wc -m
fi





