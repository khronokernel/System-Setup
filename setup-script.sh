#!/usr/bin/env bash

echo -e "\033[0;31m Starting setup script \033[0m"

sudo -v

# Check for Homebrew, install if we don't have it

if test ! $(which brew); then
    echo -e "\033[0;31m Installing homebrew...\033[0m"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew recipes
echo -e "\033[0;32m Updating homebrew...\033[0m"
brew update
brew tap homebrew/cask-drivers

# Install some packages

PACKAGES=(
    node
    yarn
    bash
    python
    python3
    composer
    java
)

echo -e "\033[0;31m Installing packages...\033[0m"
#brew install ${PACKAGES[@]} Removing due to issues if one app failed

brew install java
brew install composer
brew install python3
brew install python
brew install bash
brew install yarn
brew install node
brew install wget
brew install jq

echo -e "\033[0;32m Cleaning up...\033[0m"
brew cleanup

echo -e "\033[0;31m Installing cask...\033[0m"

CASKS=(
    adoptopenjdk
    balenaetcher
    beyond-compare
    coolterm
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
    logitech-options # From cask-drivers
    maciasl # From Acidanthera
    minecraft
    monitorcontrol
    #padbury-clock
    qbittorrent
    steam
    textmate
    typora
    vanilla
    virtualbox
    visual-studio-code
)

echo -e "\033[0;32m Installing cask apps...\033[0m"
#brew cask install ${CASKS[@]} Removing due to issues if one app failed

brew cask install beyond-compare
brew cask install balenaetcher
brew cask install adoptopenjdk
brew cask install coolterm
brew cask install discord
brew cask install element
brew cask install firefox
brew cask install ghidra
brew cask install google
brew cask install github
brew cask install -chrome
brew cask install hex-fiend
brew cask install idafree
brew cask install istat-menus
brew cask install keka
brew cask install logitech-options
brew cask install maciasl
brew cask install minecraft
brew cask install monitorcontrol
brew cask install qbittorrent
brew cask install steam
brew cask install textmate
brew cask install typora
brew cask install vanilla
brew cask install virtualbox
brew cask install visual-studio-code


echo -e "\033[0;31m Installing MAS...\033[0m"
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
	
echo -e "\033[0;32m Installing MAS apps...\033[0m"
#mas install ${MASS[@]} Removing due to issues if one app failed

mas install 808809998
mas install 441258766
mas install 409201541
mas install 409183694
mas install 409203825
mas install 408981434
mas install 425424353


echo -e "\033[0;31m Installing other macOS apps...\033[0m"

echo -e "\033[0;32m Installing IOReg\033[0m"
git clone https://github.com/khronokernel/IORegistryClone
cd IORegistryClone
unzip ioreg-302.zip
mv IORegistryExplorer.app /Applications/IORegistryExplorer.app
cd

echo -e "\033[0;31m Installing useful scripts\033[0m"

# Add tools to path

## gfxutil
echo -e "\033[0;32m Installing gfxutil\033[0m"
git clone https://github.com/acidanthera/gfxutil
cd gfxutil
chmod +x gfxutil
sudo cp gfxutil /usr/local/bin
cd

## iASL
echo -e "\033[0;32m Adding iASL to path\033[0m"
chmod +x /Applications/maciASL.app/Contents/MacOS/iasl-stable
sudo cp /Applications/maciASL.app/Contents/MacOS/iasl-stable /usr/local/bin

# CorpNewt's scripts:

## MountEFI
echo -e "\033[0;32m Installing MountEFI\033[0m"
git clone https://github.com/corpnewt/MountEFI
cd MountEFI
chmod +x MountEFI.command
cd

## OCConfigCompare
echo -e "\033[0;32m Installing MountEFI\033[0m"
git clone https://github.com/corpnewt/OCConfigCompare
cd OCConfigCompare
chmod +x OCConfigCompare.command
cd

## icontool
echo -e "\033[0;32m Installing icontool\033[0m"
git clone https://github.com/corpnewt/icontool
cd icontool
chmod +x icontool
cd

## ProperTree

### Due to issues with Big Sur and Python, I've added a few paths

KERNEL=$(uname -r)
if [ $KERNEL > 19.9.9 ];then
	echo -e "\033[0;32m Detected 11.0 or newer OS, Installing pre-built ProperTree \033[0m"
	cd ~/System-Setup/ProperTree-GOOD
	unzip ProperTree-11.zip
	mv ProperTree.app /Applications/ProperTree.app
	cd
else
	echo -e "\033[0;32m Detected 10.15 or older OS, Installing ProperTree from source\033[0m"
	git clone https://github.com/corpnewt/ProperTree
	cd ProperTree
	chmod +x ProperTree.command
	cd Scripts
	python3 buildapp.command
	cd ..
	mv ProperTree.app /Applications/ProperTree.app
	cd
fi

# Misc system fixes

echo -e "\033[0;31m Setting misc preferences...\033[0m"

## Fix the Dock

echo -e "\033[0;32m Setting Dock preferences...\033[0m"
sudo cp ~/System-Setup/Dock-Settings/com.apple.dock.plist ~/Library/Preferences/com.apple.dock.plist
killall Dock


## Fix trackpad settings

echo -e "\033[0;32m Setting trackpad preferences...\033[0m"

defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

## Fix Energy Saver settings 

echo -e "\033[0;32m Setting Energy Saver preferences...\033[0m"

sudo -i
pmset powernap 0
pmset womp 0
pmset sleep 15

## Fix Finder

echo -e "\033[0;32m Setting Finder preferences...\033[0m"

defaults write com.apple.finder _FXSortFoldersFirst -bool YES
killall Finder
