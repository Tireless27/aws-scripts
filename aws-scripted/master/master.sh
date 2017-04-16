#!/bin/bash

# One script for everything

echo $'\n\n*********************************************\n SETUP AWS SERVICES & APPLICATIONS\n*********************************************\n'

# Check Directory first
where=$(pwd)
where="${where: -12}"
if test "$where" = "aws-scripted"; then
	echo "running from correct directory"
else
	echo "must be run from aws directory with ./master/master.sh"
	exit
fi

