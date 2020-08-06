#!/usr/bin/env bash

echo -e "\033[0;31m Starting setup script \033[0m"

sudo -v

# Check for Homebrew, install if we don't have it

if test ! $(which brew); then
    echo "\033[0;31m Installing homebrew...\033[0m"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew recipes
echo "\033[0;32m Updating homebrew...\033[0m"
brew update

# Install some packages

PACKAGES=(
    node
    yarn
    bash
    python
    python3
)

echo "\033[0;31m Installing packages...\033[0m"
brew install ${PACKAGES[@]}

echo "\033[0;32m Cleaning up...\033[0m"
brew cleanup

echo "\033[0;31m Installing cask...\033[0m"
brew install caskroom/cask/brew-cask

CASKS=(
    adoptopenjdk
    balenaetcher
    discord
    element # Previously Riot
    firefox
    ghidra
    github
    google-chrome
    #hackintool
    hex-fiend
    idafree
    istat-menus
    keka
    logitech-options
    maciasl # From Acidanthera
    minecraft
    monitorcontrol
    padbury-clock
    qbittorrent
    steam
    textmate
    typora
    vanilla
    virtualbox
)

echo "\033[0;32m Installing cask apps...\033[0m"
brew cask install ${CASKS[@]}

echo "\033[0;31m Installing MAS...\033[0m"
brew install mas

MASS=(
    808809998 # Xcode
    441258766 # Magnet
    409201541 # Pages
    409183694 # Keynote
    409203825 # Numbers
    408981434 # iMovie
    425424353 # Unarchiver
)
	
echo "\033[0;32m Installing MAS apps...\033[0m"
brew mas install ${MASS[@]}

echo "\033[0;31m Installing other macOS apps...\033[0m"

echo "\033[0;32m Installing IOReg\033[0m"
git clone https://github.com/khronokernel/IORegistryClone
cd IORegistryClone
unzip ioreg-302.zip
mv IORegistryExplorer.app /Applications/
cd

echo "\033[0;31m Installing useful scripts\033[0m"

# CorpNewt's scripts:

## MountEFI
echo "\033[0;32m Installing MountEFI\033[0m"
git clone https://github.com/corpnewt/MountEFI
cd MountEFI
chmod +x MountEFI.command
cd

## OCConfigCompare
echo "\033[0;32m Installing MountEFI\033[0m"
git clone https://github.com/corpnewt/OCConfigCompare
cd OCConfigCompare
chmod +x OCConfigCompare.command
cd

## icontool
echo "\033[0;32m Installing icontool\033[0m"
git clone https://github.com/corpnewt/icontool
cd icontool
chmod +x icontool
cd

## ProperTree

### Due to issues with Big Sur and Python, I've added a few paths

base_ver=11.0
ver=$(sw_vers | grep ProductVersion | cut -d':' -f2 | tr -d ' ')
if [ $(echo -e $base_ver"\n"$ver | sort -V | tail -1) == "$base_ver" ]
then 
	echo "\033[0;32m Detected 10.15 or older OS\033[0m"
	echo "\033[0;32m Installing ProperTree from source\033[0m"
	git clone https://github.com/corpnewt/ProperTree
	cd ProperTree
	chmod +x ProperTree.command
	cd Scripts
	python3 buildapp.command
	cd ..
	mv ProperTree.app /Applications/
	cd
else 
	echo "\033[0;32m Detected 11.0 or newer OS\033[0m"
	echo "\033[0;32m Installing ProperTree from source\033[0m"
	cd ProperTree-GOOD
	unzip ProperTree(11).zip
	mv ProperTree(11).app /Applications/
	cd
fi

# Misc system fixes

## Fix the Dock

cd Dock-Settings
cp com.apple.dock.plist ~/Library/Preferences/
killall Dock


## Fix trackpad settings

echo "\033[0;31m Setting trackpad preferences...\033[0m"

defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
