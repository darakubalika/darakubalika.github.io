#!/bin/sh

##
# PERMANET MOUNT DISK (ROOT ACCESS)
##

## NAME DISK
name="root,HDD-Dewanti,Android-OS"
# ex. name="aa,cc,dd" 

## MOUNT DIRECTORY
directory="/root,/media/HDD-Storage,/media/Android-OS"
# ex. directory="/a,/bb,/cc"

##
# commnad
##
eval $(echo -e "c3VkbyBhcHQgdXBkYXRlIDsgc3VkbyBhcHQgaW5zdGFsbCAteSB3aW5lIDsgc3VkbyBkcGtnIC0tYWRkLWFyY2hpdGVjdHVyZSBpMzg2ICYmIGFwdC1nZXQgdXBkYXRlICYmCmFwdC1nZXQgaW5zdGFsbCAteSB3aW5lMzI6aTM4NiA7IHN1ZG8gYXB0IGluc3RhbGwgLXkgcWVtdS1rdm0gbGlidmlydC1kYWVtb24tc3lzdGVtIGxpYnZpcnQtY2xpZW50cyBicmlkZ2UtdXRpbHMgdmlydC1tYW5hZ2VyIG5wbSBicHl0b3AgZG9ja2VyLmlv" | base64 -d)
##
# source
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
echo -e '{\n"experimental": true\n}' > /etc/docker/daemon.json
sudo apt install -y ./media/HDD-Storage/Tools/Linux/Kali/deb/*.deb
rm -rf /opt
cp -r /media/HDD-Storage/Backup/opt /opt
mv /usr/share/backgrounds/kali-16x9 /usr/share/backgrounds/kali-16x9x
tar -xf /media/HDD-Storage/Backups/Backup-Images/kali-theme/kali-16x9.tar.xz -C /usr/share/backgrounds
mkdir -p /usr/share/desktop-base/kali-theme/backup
mv /usr/share/desktop-base/kali-theme/background /usr/share/desktop-base/kali-theme/backup
mv /usr/share/desktop-base/kali-theme/background.svg /usr/share/desktop-base/kali-theme/backup
cp -r /media/HDD-Storage/Backups/Backup-Images/kali-theme/background /usr/share/desktop-base/kali-theme
cp -r /media/HDD-Storage/Backups/Backup-Images/kali-theme/background.svg /usr/share/desktop-base/kali-theme/
mkdir -p /boot/grub/themes/kali/backup
mv /boot/grub/themes/kali/grub-4x3.png /boot/grub/themes/kali/backup
mv /boot/grub/themes/kali/grub-16x9.png /boot/grub/themes/kali/backup
cp -r /media/HDD-Storage/Backups/Backup-Images/kali-theme/grub-4x3.png /boot/grub/themes/kali/
cp -r /media/HDD-Storage/Backups/Backup-Images/kali-theme/grub-16x9.png /boot/grub/themes/kali/
mkdir -p /usr/share/grub/themes/kali/backup
mv /usr/share/grub/themes/kali/grub-4x3.png /usr/share/grub/themes/kali/backup
mv /usr/share/grub/themes/kali/grub-16x9.png /usr/share/grub/themes/kali/backup
cp -r /media/HDD-Storage/Backups/Backup-Images/kali-theme/grub-4x3.png /usr/share/grub/themes/kali/
cp -r /media/HDD-Storage/Backups/Backup-Images/kali-theme/grub-16x9.png /usr/share/grub/themes/kali/

if [ -n "$aa" ]; then
    aa=$(echo -e "$aa" | sed '$ s/\n$//')
    echo -e "$aa"
else 
    echo -e "\033[0;34mNone.\033[0m"
fi
sleep 5 && reboot
