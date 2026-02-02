#!/bin/bash

# Version 2;

function Main {
FILENAME="$1";
DESTINATION="$2";
NEWFILENAME="$3";

if ! ValidateInputs "$FILENAME" "$DESTINATION" "$NEWFILENAME" ; then
    exit 1;
fi

CopyFiles "$FILENAME" "$DESTINATION" "$NEWFILENAME";

}

function CopyFiles {
    FILENAME="$1";
    DESTINATION="$2";
    NEWFILENAME="$3";

    if [ -z "$NEWFILENAME" ]; then
        NEWFILENAME="$FILENAME";
    fi
    cp "$FILENAME" "$DESTINATION/$NEWFILENAME";
}

function ValidateInputs {
    FILENAME="$1";
    DESTINATION="$2";
    NEWFILENAME="$3";
    # Check to see if the file passes all tests
    if ! ValidateFile "$FILENAME"; then
        return 1;
    fi
    # Check to see if the directory passes all tests
    if ! ValidateDirectory "$DESTINATION"; then
        return 1;
    fi
    # Check to see if the move is safe 
    if ! ValidateLocation "$FILENAME" "$DESTINATION" "$NEWFILENAME"; then
        return 1;
    fi
    # If all pass then return true
    return 0;
}

function ValidateFile {
    FILENAME="$1";
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
function ValidateDirectory {
    DIRECTORY="$1";
    # Check if directory name was provided 
    if [ -z "$DIRECTORY" ]; then
        echo "ERROR: no directory provided.";
        return 1;
    fi
    # Check if directory exists 
    if [ ! -d "$DIRECTORY" ]; then
        echo "ERROR: directory '$DIRECTORY' does not exist.";
        return 1;
    fi
    # Check if user has read permissions
    if [ ! -w "$DIRECTORY" ]; then
        echo "ERROR: You do not have write permissions for '$DIRECTORY'.";
        return 1;
    fi
    return 0;
}
function ValidateLocation {
    FILENAME="$1";
    DESTINATION="$2";
    NEWFILENAME="$3";

    # Check if new file name exists
    if [ -z "$NEWFILENAME" ]; then
        NEWFILENAME="$FILENAME";
    fi
    # Check if there is a file with that name in that location
    if [ -e "$DESTINATION/$NEWFILENAME" ]; then
        echo "There is already a file with that name in that location";
        return 1;
    fi
    return 0;
}

Main "$1" "$2" "$3"
