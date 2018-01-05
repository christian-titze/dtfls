#!/usr/bin/env bash

# Check if homebrew is installed and install it if needed.
if [ ! -f "$(which brew)" ]; then
  echo "Installing homebrew ..."
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Install packages.
echo "Installing packages ..."
brew install git wget python python3 cmake zsh vim neovim tmux reattach-to-user-namespace # Absolute minimum, do not remove any of these packages!
brew install tree # Nice-to-have packages.
brew cask install iterm2 macvim # Essential graphical applications.
brew cask install google-chrome # Nice-to-have graphical applications.

# Make zsh the default shell.
if [ ! -f "$(cat /etc/shells | grep '/usr/local/bin/zsh' | tail -1)" ]; then
  sudo sh -c "echo $(which zsh) >> /etc/shells"
fi
echo "Please enter your password to make zsh your default shell."
chsh -s $(which zsh)

echo "Setup complete. Please restart your terminal emulator to see changes."
