# Vim mode
export VISUAL=vim
export EDITOR=vim
autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd v edit-command-line
bindkey -v

# Turn off all beeps
unsetopt BEEP

# Enable completion
autoload -Uz compinit
compinit

# Set prompt
autoload -Uz promptinit
promptinit

# Pure prompt
#   npm install --global pure-prompt
# or
#   mkdir -p $HOME/.zsh
#   git clone https://github.com/sindresorhus/pure.git $HOME/.zsh/pure
#   add line (before `autoload -Uz promptinit`): fpath+=$HOME/.zsh/pure
prompt pure

# Complete based on history
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward
bindkey -M vicmd "^[[A" history-beginning-search-backward
bindkey -M vicmd "^[[B" history-beginning-search-forward

# Make backspace work
bindkey "^?" backward-delete-char

# Make Vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
export KEYTIMEOUT=1

# Alias some commands
alias grep='grep --color=auto'
alias ls='ls -G'

# Set Python3 from Homebrew to be the default Python
typeset -U path
path=('/usr/local/opt/python/libexec/bin' $path)
export PATH
