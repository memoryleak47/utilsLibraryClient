#!/bin/bash

function getUlRoot()
{
	x=$(cat $HOME/.ulroot)
	[ ! $1 == "-q" ] && [ ! -f $HOME/.ulroot ] && echo "ulroot unset" && exit
	[ ! $1 == "-q" ] && [ ! -d $x ] && echo "ulroot directory not found" && exit
	echo $x
}

function getPropertiesFile()
{
	propsfile=$(getUlRoot)/properties
	[ ! "$1" == "-q" ] && [ ! -f $propsfile ] && echo "propsfile not found unset" && exit
	echo $propsfile
}

function setProperty() # property, value
{
	propsfile=$(getUlRoot)/properties
	if [ ! $(sed "s/$1=*/$1=$2/g" -i $propsfile) ]; then
		echo "$1=$2" >> $propsfile
	fi
}

function getProperty() # property
{
	propsfile=$(getPropertiesFile)
	grep "$1=" $propsfile | sed 's/$1=//g'
}
