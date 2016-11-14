#!/bin/bash
user=$(whoami | sed 's/.*[\/\\]//')
if [ $user = "root" ]; then
  user=$( who am i 2> /dev/null | awk '{print $1}')
fi
USER_HOME=$(eval echo ~$user)

# check for source files
if [ -e $USER_HOME/.bashrc ]; then
  SOURCE_FILE="$USER_HOME/.bashrc"
elif [ -e $USER_HOME/.bash_profile ]; then
  SOURCE_FILE="$USER_HOME/.bash_profile"
fi

PATH_TO_UPDATE_ALL=$(cd $(dirname $0) && pwd)/$(basename $0)
while [ -h $PATH_TO_UPDATE_ALL ]; do
  PATH_TO_UPDATE_ALL=$(dirname "$PATH_TO_UPDATE_ALL")/$(ls -ld -- "$PATH_TO_UPDATE_ALL" | awk '{print $11}')
done

export PATH_TO_UPDATE_ALL=$( dirname "$PATH_TO_UPDATE_ALL" )
export ROOT_FOR_PACKAGE_MANAGERS="$USER_HOME/.config/updateall"

ADDED=""
for LINE in " # added for updateall" "export ROOT_FOR_PACKAGE_MANAGERS=\"$ROOT_FOR_PACKAGE_MANAGERS\"" "export PATH_TO_UPDATE_ALL=\"$PATH_TO_UPDATE_ALL\"" "PATH=\$PATH:\$PATH_TO_UPDATE_ALL/bin"; do
    grep -F "$LINE" $SOURCE_FILE > /dev/null
    if [ $? != 0 ]; then
        printf "\n$LINE" >> $SOURCE_FILE
        ADDED="yes"
    fi
done

if [ "$ADDED" != "" ]; then
    printf "\n" >> $SOURCE_FILE
fi

$PATH_TO_UPDATE_ALL/bin/add-package-managers