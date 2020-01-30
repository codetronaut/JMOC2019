#!/bin/bash


# $1 = /home/your_user/shared_dir   i.e $PATH
# $2 = permissions
#

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

not_installed = $(dpkg -s samba 2>&1 | grep "samba not installed") #stderr redirects to stdout
if [ -n "$not_installed"];
then
echo "installing samba..."
    #use cat /etc/os-release(for debian) or cat /etc/redhat-release(for  fedora)
    if [ -f /etc/os-release];
    then
        sudo aptitude install samba 
    elif [ -f /etc/redhat-release];
    then
        sudo yum install samba
    else
        echo "This script is only for debian and fedora based distroos!"
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



sudo /etc/init.d/smbd restart  #restart service

sudo chmod -R $2 $2 #permission giving to shared directory

echo "For accessing the shared from windows:"
echo "\\\\$(ifconfig eth0 | sed -n 's/.*dr:\(.*\)\s Bc.*/\1/p')"

