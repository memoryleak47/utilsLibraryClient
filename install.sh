#!/bin/bash

[ $(eval sudo cp $(dirname $(readlink -f $0))/ul /usr/bin/) ] && exit 1

# whereToInstall?
echo "Where do you want to install the ulClient? Default: ~/.ul"
read whereToInstall
if [ -z $whereToInstall ]; then
	whereToInstall=$HOME/.ul
fi
eval "echo $whereToInstall > $HOME/.ulroot"

# create UlRoot
if [ ! -d $(ul getUlRoot -q) ]; then
	mkdir $(ul getUlRoot -q)
fi

# create properties
if [ ! -f $(ul getPropertiesFile -q) ]; then
	touch $(ul getPropertiesFile -q)
fi

# linked?
echo "Do you want to link .bashrc/.vimrc to the loaded configuration? [yes/no] Default: yes"
read linked
if [ -z $linked ]; then
	linked="yes"
fi
ul setProperty linked $linked

# link
# TODO
