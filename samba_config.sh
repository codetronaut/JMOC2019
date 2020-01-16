#!/bin/bash

name =  $(whoami)

sudo aptitude install samba
sudo ufw allow samba 

sudo rm /etc/samba/samba.conf 
sudo mkdir /home/Drop
sudo chown $name /home/Drop

sudo wget :'download url for samba.conf' --output-document=/etc/samba/smb.conf
sudo sed -i "s/USER_NAME_HERE/$name/g" /etc/samba/samba.conf
sudo sed -i "s/SERVER_HOSTNAME_HERE/$HOSTNAME/g" /etc/samba/smb.conf

sudo reboot
