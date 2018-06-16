export TERM="xterm-256color"
export CLICOLOR=1 # Make output of tools like `ls` colored on macOS.

# Settings for zsh history.
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=1000
export SAVEHIST=$HISTSIZE
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.

# Minimal command prompt.
if [[ -z "$SSH_CLIENT" ]]; then
  # Local connection.
  export PROMPT='%~ %# '
else
  # SSH connection.
  export PROMPT='%M:%~ %# '
fi

# Emacs keybindings.
bindkey -e

# Use Neovim as "preferred editor"
export VISUAL=nvim

# Aliases.
alias reload="source $HOME/.zshrc"
alias la='ls -A'
alias ll='ls -alF'
alias vi='nvim'
alias vim='nvim'
alias vimdiff='nvim -d'

# Install zplug if it is not installed already.
if [[ ! -d "$HOME/.zplug" ]]; then
  git clone https://github.com/zplug/zplug "$HOME/.zplug"
  source "$HOME/.zplug/init.zsh" && zplug update --self
fi

source "$HOME/.zplug/init.zsh"

zplug "mafredri/zsh-async"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"
zplug "chriskempson/base16-shell"
zplug "zsh-users/zsh-history-substring-search", defer:2 # MUST BE LOADED AFTER zsh-syntax-highlighting!

# Install packages that have not been installed yet
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  else
    echo
  fi
fi

zplug load

# Make the up and down arrow keys work with zsh-history-substring-search.
if zplug check zsh-users/zsh-history-substring-search; then
  # macOS
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
  # Linux
  bindkey '\eOA' history-substring-search-up
  bindkey '\eOB' history-substring-search-down
fi

# Automatically load base16-shell color scheme.
if zplug check chriskempson/base16-shell; then
  BASE16_SHELL=$HOME/.config/base16-shell/
  [ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
