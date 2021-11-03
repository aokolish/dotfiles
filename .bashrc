source ~/bin/bash_colors.sh

if [ -f /etc/profile ]; then
    PATH=""
    source /etc/profile
fi

export PATH="$HOME/bin:$PATH"
export PATH="/usr/local/heroku/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="/usr/local/share/npm/bin:$PATH"
export PATH="/usr/local/opt/postgresql@9.6/bin:$PATH"
eval "$(rbenv init -)"

. ~/.bash/aliases
source ~/bin/git-completion.bash

export EDITOR=vim

# Git prompt components
function minutes_since_last_commit {
    now=`date +%s`
    last_commit=`git log --pretty=format:'%at' -1`
    seconds_since_last_commit=$((now-last_commit))
    minutes_since_last_commit=$((seconds_since_last_commit/60))
    echo $minutes_since_last_commit
}
grb_git_prompt() {
    local g="$(__gitdir)"
    if [ -n "$g" ]; then
        local MINUTES_SINCE_LAST_COMMIT=`minutes_since_last_commit`
        if [ "$MINUTES_SINCE_LAST_COMMIT" -gt 30 ]; then
            local COLOR=${RED}
        elif [ "$MINUTES_SINCE_LAST_COMMIT" -gt 10 ]; then
            local COLOR=${YELLOW}
        else
            local COLOR=${GREEN}
        fi
        local SINCE_LAST_COMMIT="\001${COLOR}\002$(minutes_since_last_commit)m\001${NORMAL}\002"
        # The __git_ps1 function inserts the current git branch where %s is
        local GIT_PROMPT=`__git_ps1 "(%s|${SINCE_LAST_COMMIT})"`
        echo ${GIT_PROMPT}
    fi
}
PS1="\W\$(grb_git_prompt) \u\$ "

export MANPATH="/usr/local/man:/usr/local/mysql/man:/usr/local/git/man:$MANPATH"

export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"

# moar history
export HISTSIZE=10000
export HISTFILESIZE=$HISTSIZE

# silence annoying "[tunemygc] not enabled" messages
export RUBY_GC_TUNE_VERBOSE=0

# fix command-t in vim
stty -ixon

# Erase duplicates in history
export HISTCONTROL=erasedups
# Append to the history file when exiting instead of overwriting it
shopt -s histappend

ulimit -n 4096

[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

# terrible fix for rbenv + tmuxinator
function rvm () {
  if [[ $1 == 'use' ]]; then
    rbenv shell $2
  fi
}

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

## lendinghome toolbelt
export PATH="~/work/lendinghome-monolith/toolbelt:~/work/lendinghome-monolith/bin:$PATH"
export PATH="~/code/work/lendinghome-monolith/toolbelt:~/code/work/lendinghome-monolith/bin:$PATH"

export NVM_DIR="/Users/aokolish/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

export RUBY_GC_TUNE_VERBOSE=0

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
