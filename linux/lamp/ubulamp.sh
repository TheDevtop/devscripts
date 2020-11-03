#!/bin/bash

# Program: Transform Ubuntu Desktop into Ubuntu LAMP Server
# Version: 0.2
# Authors: Thijs Haker

# Print motd
clear ; cat << EOL
_  _ ___  _  _ _    ____ _  _ ___  
|  | |__] |  | |    |__| |\/| |__] 
|__| |__] |__| |___ |  | |  | |    
                                   
EOL

# Check if root/sudo
if [ $EUID -ne 0 ]; then
    printf "Error: You need to run as root/sudo!\n"
    exit 1
fi

# Print notice
echo "Please update your system beforehand!" ; sleep 2

# Package configuration
apt purge ubuntu-desktop ubuntu-gnome-desktop gnome-shell -y
apt autoremove -y
apt install apache2 mysql-server php libapache2-mod-php php-mysql -y

# Done and exit
clear ; echo "Done: Please reboot your computer!"
exit 0
