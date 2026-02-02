#!/bin/bash
TestCases() {
    # Check if arguments were provided
    if [ -z "$1" ] || [ -z "$2" ]; then 
        echo "ERROR: Improper usage please give the following arguments"
        echo "Arg1: File you would like to copy."
        echo "Arg2: Destination you would like to copy to."
        echo "Arg3: [OPTIONAL] The new file name for the copied file."
        return 1;
    fi
    if ! CheckFile "$1"; then
        return 1; 
    fi
    if ! CheckDirectory "$2"; then
        return 1; 
    fi
    if [ -z "$3" ]; then
        if [ -e "$2/$1" ]; then
            echo "There is already a file with that name in that location";
            return 1
        fi
    else 
        if [ -e "$2/$3" ]; then
            echo "There is already a file with that name in that location";
            return 1
        fi
    fi
    return 0;
}

CheckFile() {
    # Check if file name was provided 
    if [ -z "$1" ]; then
        echo "ERROR: no file provided.";
        return 1;
    fi
    # Check if file exists 
    if [ ! -e "$1" ]; then
        echo "ERROR: file '$1' does not exist.";
        return 1;
    fi
    # Check if user has read permissions
    if [ ! -r "$1" ]; then
        echo "ERROR: You do not have read permissions.";
        return 1;
    fi
    return 0;
}
CheckDirectory() {
    # Check if file name was provided 
    if [ -z "$1" ]; then
        echo "ERROR: no directory provided.";
        return 1;
    fi
    # Check if file exists 
    if [ ! -d "$1" ]; then
        echo "ERROR: directory '$1' does not exist.";
        return 1;
    fi
    # Check if user has read permissions
    if [ ! -w "$1" ]; then
        echo "ERROR: You do not have write permissions for '$1'.";
        return 1;
    fi
    return 0;
}


# all tests passed
if TestCases "$1" "$2" "$3"; then
    if [ -z "$3" ]; then
        cp "$1" "$2"
    else
        cp "$1" "$2/$3";
    fi
fi
