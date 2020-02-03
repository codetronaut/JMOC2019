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
 "

}

function samba_config()
{
	echo "Samba configuring..."
	    if [ -z "$1" ];
then
echo "         Follow this given below"
echo "./aio-script.sh PATH_TO_SHARED_DIRECTORY PERMISSIONS"
exit
fi


if [ -z "$2" ];
then 
echo "pass the permissions for the directory as the second parameter for sharing"
exit 0
fi

not_installed=$(dpkg -s samba 2>&1 | grep "install ok installed") #stderr redirects to stdout
if [ -z "$not_installed" ];
then
echo "installing samba..."
    
    if [ -f /etc/os-release ];
    then
        sudo apt install samba 
    elif [ -f /etc/redhat-release ];
    then
        sudo yum install samba
    else
        echo "This script is only for debian and fedora based distros!"
    fi


fi

echo "
[public]
comment = Shared Folder
path = $1
public  = yes
writable = yes
create mask = 0$2
force user =  nobody
force group = nogroup
guest ok = yes
security = SHARE
" | sudo tee -a /etc/samba/smb.conf



sudo /etc/init.d/smbd restart  #restart samba daemon service

sudo chmod -R $2 $1 #permission giving to shared directory

}

function Update(){
	echo "Updating..."
if [ -f /etc/os-release ];
    then
        sudo apt update && sudo apt upgrade -y
elif [ -f /etc/redhat-release ];
    then
        sudo yum update && sudo yum upgrade -y
    
 fi
}

function monitoring(){
	echo "Monitoring..."
if [ -f /etc/os-release ];
    then
        not_installed=$(dpkg -s htop 2>&1 | grep "install ok installed")
        if [ -z "$not_installed" ]; 
        then 
        sudo apt install htop
	htop
        else
        htop
        fi
elif [ -f /etc/redhat-release ];
    then
        not_installed=$(yum list installed 2>&1 | grep "htop")
        if [ -z "$not_installed" ]; 
        then
        sudo yum install htop
	htop
        else 
        htop
        fi
   
fi
}

# function mount_unmount()
# {
# 	echo "Mounting and unmounting..."
# }


if [ "$1" == "" ] 
    then echo "Enter parameters. use $ bash [script] --help."
else 
if [ "$1" != "" ]; then
    PARAM=`echo $1 | awk -F= '{print $1}'`
    VALUE=`echo $1 | awk -F= '{print $2}'`
    case $PARAM in
        -h | --help)
            help
            exit
            ;;
        -1) samba_config $2 $3 ;exit ;; 
	-2) Update exit ;; 
	-3) monitoring exit ;; 
# 	-4) mount_unmount exit ;; 

        *)
            echo "ERROR: unknown parameter \"$PARAM\""
            usage
            exit 1
            ;;
    esac
fi

fi


