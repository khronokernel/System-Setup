#!/usr/bin/env bash

echo -e "\033[0;31m Starting HiDPI script \033[0m"

sudo -v

## Allow custom HiDPI resolution
echo -e "\033[0;32m Patching windowserver preferences \033[0m"
defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool YES
defaults delete /Library/Preferences/com.apple.windowserver DisplayResolutionDisabled

## Create folders
echo -e "\033[0;32m Creating Display Override folders \033[0m"
mkdir Displays
cd /Displays
mkdir Contents
cd /Contents
mkdir Resources
cd /Resources
mkdir Overrides
cd /Overrides
mkdir DisplayVendorID-30e4
cd

## Copy over HiDPI plist
echo -e "\033[0;32m Moving HiDPI plist to correct location \033[0m"
cp /System-Fixup/Display-Fixup/DisplayProductID-4a5.plist /Library/Displays/Contents/Resources/Overrides/DisplayVendorID-30e4/DisplayProductID-4a5

## Reboot

echo "Finished running the script, would you loke to reboot?"
select yn in "Yes" "No"
case $yn in
    Yes ) shutdown -r now;;
    No ) exit;;
esac
