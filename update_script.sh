#!/bin/bash

# Update and upgrade packages
sudo apt update -y
sudo apt upgrade -y

# Check if a reboot is required
if [ -f /var/run/reboot-required ]; then
    sudo reboot
fi

# chmob 744 update_script.sh
# sudo crontab -e
# 0 0 * * * /path/to/update_script.sh
