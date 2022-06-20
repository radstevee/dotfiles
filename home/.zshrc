autoload -U compinit 
compinit

export _JAVA_AWT_WM_NONREPARENTING=1

alias ls='exa --icons -a'
alias la='exa --icons -la'
alias tree='exa --icons --tree' 
alias _='sudo'
alias please='sudo'
alias tb='nc termbin.com 9999'
alias rpi='ssh root@rpi'
alias server='ssh root@server'
alias hp='server'
alias ssn='systemctl shutdown'
alias sr='systemctl reboot'
alias docker='sudo docker'
alias grep='grep --color=auto'
alias vim='nvim'
alias :q='exit'
alias :wq='echo wtf do you idiot wanna write this is a fucking shell'
alias wttr='curl wttr.in'
alias clear='clear && fetch'
alias ewwrs='eww kill && eww daemon && eww open bar'
alias cat='bat'
alias r='ranger' 
alias c='clear'
alias cr='c && r'
alias %='source ~/.zshrc'

export EDITOR=nvim
export PATH=$HOME/.local/bin:$PATH

startup() {
  fetch
}

startup
eval "$(starship init zsh)"
