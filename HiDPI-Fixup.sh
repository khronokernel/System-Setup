#!/usr/bin/env bash

echo -e "\033[0;31m Starting HiDPI script \033[0m"

sudo -v

## Create folders
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

cp /System-Fixup/Display-Fixup/DisplayProductID-4a5.plist /Library/Displays/Contents/Resources/Overrides/DisplayVendorID-30e4/DisplayProductID-4a5
