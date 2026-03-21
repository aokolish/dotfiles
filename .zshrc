# Set custom prompt
setopt PROMPT_SUBST
autoload -U promptinit
promptinit
prompt aeo

# Add paths
export PATH="$HOME/bin:$PATH"

# Initialize completion
autoload -U compinit
compinit -D

# Colorize terminal
alias ls='ls -G'
alias ll='ls -lG'

alias c='clear'

alias k='kubectl'

export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"
export GREP_OPTIONS="--color"

# Nicer history
export HISTSIZE=100000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE

# Use vim as the editor
export EDITOR=vi

# set up autojump
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

export AWS_SDK_LOAD_CONFIG=true

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform

eval "$(pyenv init --path)"
eval "$(pyenv init -)"
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
export PATH="$HOME/.local/bin:$PATH"
