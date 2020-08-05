#!/usr/bin/env bash

echo -e "\033[0;31m Starting Xcode script \033[0m"

sudo -v

# Install Xcode tools to save ourselves a headache later

echo -e "\033[0;31m Installing Xcode tools \033[0m"

xcode-select --install
