export TERM="xterm-256color"
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
autoload -Uz compinit
compinit

### zplug begin ####

source ~/.zplug/init.zsh

zplug "mafredri/zsh-async"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"
zplug "chriskempson/base16-shell"
zplug "zsh-users/zsh-history-substring-search", defer:2 # MUST BE LOADED AFTER zsh-syntax-highlighting!

zplug "sindresorhus/pure", use:pure.zsh, as:theme

zplug load --verbose

### zplug end ####

# gimme search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# gimme colors
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# aliases
alias reload="source ~/.zshrc"
