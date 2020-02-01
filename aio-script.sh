#!/bin/bash

function help()
{
    echo "All-in-one-script"
    echo "NAME
       AIO-script - All In One Script
SYNOPSIS
       bash [aio-script] [options]
OPTIONS 
 		-1      Setting up samba server     
		-2	Updates the system packages	
		-3	Running in system monitoring mode	
		-4	Mounting and Unmounting plugged in devices 
 "

}

function samba_config()
{
	echo "Samba configuring..."
}

function Update(){
	echo "Updating..."
}
function monitoring(){
	echo "Monitoring..."
}
function mount_unmount()
{
	echo "Mounting and unmounting..."
}
if [ "$1" == "" ] 
    then echo "Enter parameters. use $ bash [script] --help."
else 
while [ "$1" != "" ]; do
    PARAM=`echo $1 | awk -F= '{print $1}'`
    VALUE=`echo $1 | awk -F= '{print $2}'`
    case $PARAM in
        -h | --help)
            help
            exit
            ;;
        -1) samba_config exit ;; 
	-2) Update exit ;; 
	-3) monitoring exit ;; 
	-4) mount_unmount exit ;; 

        *)
            echo "ERROR: unknown parameter \"$PARAM\""
            usage
            exit 1
            ;;
    esac
    shift
done

fi


