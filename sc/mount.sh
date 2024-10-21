#!/bin/sh

##
# PERMANET MOUNT DISK (ROOT ACCESS)
##

## NAME DISK
echo -e "\033[1;34mex. Disk Name: wkwk, pp, HDD\033[0m"
read -p "Disk Name: " name
## MOUNT DIRECTORY
echo -e "\033[1;34mex. Mount Directory: /mnt, /media/pp, /HDD\033[0m"
read -p "Mount Directory: " directory
echo -e ""

##
# Source
##
IFS=','
name_array=($name)
directory_array=($directory)
aa=""
for i in "${!name_array[@]}"; do
    wkwk="${name_array[$i]}"
    hehe="${directory_array[$i]}"
    device=$(lsblk -o NAME,LABEL | awk -v label="$wkwk" '{if (NR!=1 && $2 == label) print "/dev/"$1}' | sed 's/─//gI;s/├//gI;s/└//gI')
    if [ -n "$device" ]; then
    	mkdir -p $hehe
    	echo "# $wkwk" >> /etc/fstab
        echo -e "$(blkid $device | awk '{print $3}') $hehe" $(blkid $device | awk '{print $5}' | sed 's/=/ /gI' | awk '{print $2 " defaults 0 0"}') | sed 's/"//gI;s/ /  /gI' >> /etc/fstab
    else
        aa+="\033[1;35m*\033[0mThe \033[1;34m$wkwk\033[0m label was not found, and the \033[1;34m$hehe\033[0m directory was not executed\n"
    fi
done
echo -e "\033[1;30mStatus:\033[0m\n\033[0;34mDone.\033[0m\nThe disk is already mounted in the destination directory, it is recommended to restart the device\n\n\033[1;30mErrors:\033[0m"
systemctl daemon-reload
mount -a
if [ -n "$aa" ]; then
    aa=$(echo -e "$aa" | sed '$ s/\n$//')
    echo -e "$aa"
    else 
    echo -e "\033[0;34mNone.\033[0m"
fi
