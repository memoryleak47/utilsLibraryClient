#!/bin/bash

[ $(eval sudo cp $(dirname $(readlink -f $0))/ulc /usr/bin/) ] && exit 1

# whereToInstall?
echo "Where do you want to install the ulClient? Default: ~/.ul"
read whereToInstall
if [ -z $whereToInstall ]; then
	whereToInstall=$HOME/.ul
fi
eval "echo $whereToInstall > $HOME/.ulroot"

# create UlRoot
ulroot="$(ulc getUlRoot -q)"
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

# create local
if [ ! -d "$ulroot/local" ]; then
	mkdir "$ulroot/local"
fi

# kerneldeep?
echo "Do you want to allow utilsLibrary to substitute your .bashrc-file? (yes/no) (It will be saved in $whereToInstall/local/bashrc)"
read kerneldeep
if [ "$kerneldeep" == "yes" ]; then
	cp "$HOME/.bashrc" "$ulroot/local/bashrc"
	tee $HOME/.bashrc << 'EOF' > /dev/null
#!/bin/bash

# If you search your old .bashrc-file: It should be in <ulroot>/local/bashrc
path="$(ulc getUlRoot)/confs/loaded/ulres/bashrc"
if [ -f "$path" ]; then
	. "$path"
fi
EOF
else
	kerneldeep="no"
fi
ulc setProperty kerneldeep "$kerneldeep"

# create confs/default
ulc createDefaultConf

# load confs/default
ulc loadConf default
