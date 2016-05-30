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
if [ ! -d "$(ul getUlRoot -q)" ]; then
	mkdir "$(ul getUlRoot -q)"
fi

# create properties
if [ ! -f "$(ul getPropertiesFile -q)" ]; then
	touch "$(ul getPropertiesFile -q)"
fi

# create confs
if [ ! -d "$(ul getConfsDir -q)" ]; then
	mkdir "$(ul getConfsDir -q)"
fi

# create servers
if [ ! -d "$(ul getServersDir -q)" ]; then
	mkdir "$(ul getServersDir -q)"
fi

# create confs/default
ul createDefaultConf

# load confs/default
ul loadConf default
