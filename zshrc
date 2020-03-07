# Vim mode
export VISUAL=vim
autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# Turn off all beeps
unsetopt BEEP

#enable completion
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

# Make Vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
export KEYTIMEOUT=1

# Show inidicator on the right about the current mode
function zle-line-init zle-keymap-select {
    RPS1="${${KEYMAP/vicmd/n}/(main|viins)/i}"
    RPS2=$RPS1
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select
