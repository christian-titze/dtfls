#!/usr/bin/env bash

# This script installs {zsh,tmux,vim,nvim} together with the specified plugins and configuration files  on a macOS or Ubuntu Linux system. 

DOTFILES=${HOME}/.dotfiles

# Check what system we're running on.
if [ "$(uname)" == "Darwin" ]; then
  echo "Detected operating system: macOS"
fi

if [ "$(uname)" == "Linux" ]; then
  echo "Detected operating system: Linux"
  if [ -f /etc/os-release ]; then
    . /etc/os-release
    echo "Detected Linux distribution: $NAME $VERSION_ID"
    if [ "$NAME" == "Ubuntu" ]; then
      echo "Installing packages ..."
      # Python dependencies for neovim.
      sudo apt-get install python-dev python-pip python3-dev python3-pip

      # Add stable neovim PPA.
      sudo apt-get install software-properties-common
      sudo add-apt-repository ppa:neovim-ppa/stable
      sudo apt-get update

      # Install packages.
      sudo apt-get install wget curl cmake git zsh tmux vim neovim

      # Clone into dotfiles repo.
      # TODO check if .dotfiles dir exists and is empty first
      git clone https://github.com/christian-titze/dtfls ${DOTFILES}

      # Symlink all configuration files.
      ln -isv ${DOTFILES}/zsh/zshrc ${HOME}/.zshrc

      # Install zplug the official way.
      curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh

      # Run zsh and install plugins with zplug.

      # Make zsh the default shell.
      chsh -s $(which zsh)

    else
      echo "FAIL: Your Linux distribution is not supported. Installation aborted." >&2
    fi
  else
    echo -e "FAIL: Could not determine Linux distribution. Installation aborted." >&2
  fi
fi
