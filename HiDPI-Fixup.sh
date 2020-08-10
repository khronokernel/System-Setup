#!/usr/bin/env bash

echo -e "\033[0;31m Starting HiDPI script \033[0m"

sudo -v

## Allow custom HiDPI resolution
echo -e "\033[0;32m Patching windowserver preferences \033[0m"
sudo defaults write /Library/Preferences/com.apple.windowserver.plist DisplayResolutionEnabled -bool true

## Create folders
echo -e "\033[0;32m Creating Display Override folders \033[0m"
cd /
cd Library
sudo rmdir Displays
sudo mkdir Displays
cd Displays
sudo mkdir Contents
cd Contents
sudo mkdir Resources
cd Resources
sudo mkdir Overrides
cd Overrides
sudo mkdir DisplayVendorID-30e4
cd /

## Copy over HiDPI plist
echo -e "\033[0;32m Moving HiDPI plist to correct location \033[0m"
sudo cp ~/System-Setup/HiDPI-Fixup/DisplayProductID-4a5.plist /Library/Displays/Contents/Resources/Overrides/DisplayVendorID-30e4/DisplayProductID-4a5

## Reboot

echo -e "\033[0;32m Finished running the script, would you like to reboot? \033[0m"
read -p "Reboot (y/n)?" CONT
if [ "$CONT" = "y" ]; then
  sudo reboot
else
  exit
fi
