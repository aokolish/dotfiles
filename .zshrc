# Set custom prompt
setopt PROMPT_SUBST
autoload -U promptinit
promptinit
prompt aeo

# Add paths
export PATH="$HOME/bin:$PATH"

# not sure if needed
PATH="/opt/homebrew/opt/postgresql@13/bin:$PATH"

# add poetry to path
PATH="/Users/alexokolish/.local/bin:$PATH"

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

# Disable C-s/C-q flow control so C-s works as tmux prefix without freezing
stty -ixon

# Restore Ctrl+R reverse search (vi mode overrides it with redisplay)
bindkey '^R' history-incremental-search-backward

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

eval "$(direnv hook zsh)"

# opencode
export PATH=/Users/alexokolish/.opencode/bin:$PATH

[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
[[ -f ~/.secrets.zsh ]] && source ~/.secrets.zsh
