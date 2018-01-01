#!/usr/bin/env bash

# This script installs {zsh,tmux,vim,nvim} together with the specified plugins and configuration files  on a macOS or Ubuntu Linux system. 

DOTFILES=${HOME}/.dotfiles

# Check what system we're running on.
if [ "$(uname)" == "Darwin" ]; then
  echo "Detected operating system: macOS"

  # Check if homebrew is installed and install it if needed.
  if [ ! -f "$(which brew)" ]; then
    echo "Installing homebrew ..."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  echo "Installing packages ..."
  brew install wget git python python3 cmake vim neovim tmux zsh
  brew cask install iterm2 macvim
  # Check if dotfiles dir already exists.
  if [[ -d "${DOTFILES}" ]]; then
    read -p "Directory ${DOTFILES} already exists, but is required to continue. Overwrite? [y/N] " -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      echo
      rm -rf ${DOTFILES}
    else
      echo -e "\nInstallation aborted." >&2
      exit 1
    fi
  fi
  
  # Clone into dotfiles repo.
  git clone https://github.com/christian-titze/dtfls ${DOTFILES}
  
  # Symlink all configuration files.
  ln -isv ${DOTFILES}/zsh/.zshrc ${HOME}/.zshrc
  
  # Make zsh the default shell.
  if [ ! -f "$(cat /etc/shells | grep '/usr/local/bin/zsh' | tail -1)" ]; then
    sudo sh -c "echo $(which zsh) >> /etc/shells"
  fi
  echo "Please enter your password to make zsh your default shell."
  chsh -s $(which zsh)
  
  echo "zsh setup complete. Please restart your terminal emulator to see changes."
fi

if [ "$(uname)" == "Linux" ]; then
  echo "Detected operating system: Linux"
  if [ -f /etc/os-release ]; then
    . /etc/os-release
    echo "Detected Linux distribution: $NAME $VERSION_ID"
    if [ "$NAME" == "Ubuntu" ]; then
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
      sudo apt-get install -y wget curl gawk cmake git zsh tmux vim neovim

      # Check if dotfiles dir already exists.
      if [[ -d "${DOTFILES}" ]]; then
        read -p "Directory ${DOTFILES} already exists, but is required to continue. Overwrite? [y/N] " -n 1 -r
        if [[ $REPLY =~ ^[Yy]$ ]]; then
          echo
          rm -rf ${DOTFILES}
        else
          echo -e "\nInstallation aborted." >&2
          exit 1
        fi
      fi

      # Clone into dotfiles repo.
      git clone https://github.com/christian-titze/dtfls ${DOTFILES}

      # Symlink all configuration files.
      ln -isv ${DOTFILES}/zsh/.zshrc ${HOME}/.zshrc

      # Make zsh the default shell.
      echo "Please enter your password to make zsh your default shell."
      chsh -s $(which zsh)

      echo "zsh setup complete. Please log out or reboot your machine now."

    else
      echo "FAIL: Your Linux distribution is not supported. Installation aborted." >&2
    fi
  else
    echo -e "FAIL: Could not determine Linux distribution. Installation aborted." >&2
  fi
fi
