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
	    if [ -z "$1"];
then
echo "         Follow this given below"
echo "./samba_conf_self.sh PATH_TO_SHARED_DIRECTORY PERMISSIONS"
fi


if [ -z "$2"];
then 
echo "pass the permissions for the directory as the second parameter for sharing"
exit 0
fi

not_installed=$(dpkg -s samba 2>&1 | grep "samba not installed") #stderr redirects to stdout
if [ -n $not_installed ];
then
echo "installing samba..."
    
    if [ -f /etc/os-release ];
    then
        sudo aptitude install samba 
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
create mast = 0$2
force user =  nobody
force group = nogroup
guest ok = yes
security = SHARE
" | sudo tee -a /etc/samba/smb.conf



sudo /etc/init.d/smbd restart  #restart samba daemon service

sudo chmod -R $2 $2 #permission giving to shared directory

#user gets message
echo "For accessing the shared from windows:"
echo "\\\\$(ifconfig eth0 | sed -n 's/.*dr:\(.*\)\s Bc.*/\1/p')"

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
        if [ -n $not_installed ]; 
        then 
        sudo apt install htop
	htop
        else
        htop
        fi
elif [ -f /etc/redhat-release ];
    then
        not_installed=$(yum list installed 2>&1 | grep "htop")
        if [ -n $not_installed ]; 
        then
        sudo yum install htop
	htop
        else 
        htop
        fi
   
fi
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


