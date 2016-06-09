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
ulroot="$(ul getUlRoot -q)"
if [ ! -d "$ulroot" ]; then
	mkdir "$ulroot"
fi

# create properties
propsfile="$ulroot/properties"
if [ ! -f "$propsfile" ]; then
	touch "$propsfile"
fi

# create confs
if [ ! -d "$ulroot/confs" ]; then
	mkdir "$ulroot/confs"
fi

# create servers
if [ ! -d "$ulroot/servers" ]; then
	mkdir "$ulroot/servers"
fi

# create confs/default
ul createDefaultConf

# load confs/default
ul loadConf default
