export TERM="xterm-256color"
export HISTFILE=~/.zsh_history
export HISTSIZE=1000
export SAVEHIST=1000
export CLICOLOR=1 # Make output of tools like `ls` colored on macOS.

### zplug begin ####

# Check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/zplug/zplug ~/.zplug
  source ~/.zplug/init.zsh && zplug update --self
fi

source ~/.zplug/init.zsh

zplug "mafredri/zsh-async"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"
zplug "chriskempson/base16-shell"
zplug "zsh-users/zsh-history-substring-search", defer:2 # MUST BE LOADED AFTER zsh-syntax-highlighting!

zplug "sindresorhus/pure", use:pure.zsh, as:theme

# Install packages that have not been installed yet
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  else
    echo
  fi
fi

zplug load #--verbose

### zplug end ####

# gimme search
if zplug check zsh-users/zsh-history-substring-search; then
  # macOS
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
  # Linux
  bindkey '\eOA' history-substring-search-up
  bindkey '\eOB' history-substring-search-down
fi

# gimme colors
if zplug check chriskempson/base16-shell; then
  BASE16_SHELL=$HOME/.config/base16-shell/
  [ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
fi

# aliases
alias reload="source ~/.zshrc"
alias la='ls -A'
alias ll='ls -alF'
