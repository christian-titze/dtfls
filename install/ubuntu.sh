#!/usr/bin/env bash

echo "Installing packages ..."

# Check if neovim PPA is already in sources.
NVIMPPA="neovim-ppa/stable"
grep -h "^deb.*$NVIMPPA" /etc/apt/sources.list.d/* > /dev/null 2>&1
if [ $? -ne 0 ]; then
  # Add stable neovim PPA.
  sudo apt-get install software-properties-common
  sudo add-apt-repository -y ppa:$NVIMPPA
  sudo apt-get update
else
  echo "ppa:$NVIMPPA is already installed."
fi

# Python dependencies for neovim.
sudo apt-get install -y python-dev python-pip python3-dev python3-pip

# Install packages.
sudo apt-get install -y wget curl gawk cmake git zsh vim neovim tmux xsel # Absolute minimum, do not remove any of these packages!
sudo apt-get install -y build-essential tree # Nice-to-have packages.

# Make zsh the default shell.
echo "Please enter your password to make zsh your default shell."
chsh -s $(which zsh)

echo "Setup complete. Please log out or reboot your machine now."
