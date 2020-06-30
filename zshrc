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
prompt redhat

# Complete based on history
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward
bindkey -M vicmd "^[[A" history-beginning-search-backward
bindkey -M vicmd "^[[B" history-beginning-search-forward

# Make backspace work
bindkey "^?" backward-delete-char

# Make Vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
export KEYTIMEOUT=1

# Show indicator on the right about the current mode
function zle-line-init zle-keymap-select {
    RPS1="${${KEYMAP/vicmd/n}/(main|viins)/i}"
    RPS2=$RPS1
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# Set Python3 from Homebrew to be the default Python
typeset -U path
path=('/usr/local/opt/python/libexec/bin' $path)
export PATH
