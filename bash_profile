#PS1='\e[0;32m\u@\h\e[m:\e[0;34m\w\e[m\$ ' #Prompt user host:path$
export CLICOLOR=1
export LSCOLORS=exfxcxdxbxegedabagacad
export EDITOR=vim
alias grep='grep --color=auto'

# macOS
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

