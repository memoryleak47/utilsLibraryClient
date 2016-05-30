#!/bin/bash

. $(dirname $(readlink -f $0))/funcs.sh

# whereToInstall?
echo "Where do you want to install the ulClient? Default: ~/.ul"
read whereToInstall
if [ -z $whereToInstall ]; then
	whereToInstall=$HOME/.ul
fi
eval "echo $whereToInstall > $HOME/.ulroot"

# create UlRoot
if [ ! -d $(getUlRoot -q) ]; then
	mkdir $(getUlRoot -q)
fi

# create properties
if [ ! -f $(getPropertiesFile -q) ]; then
	touch $(getPropertiesFile -q)
fi

# linked?
echo "Do you want to link .bashrc/.vimrc to the loaded configuration? [yes/no] Default: yes"
read linked
if [ -z $linked ]; then
	linked="yes"
fi
setProperty linked $linked

# link
# TODO
