
# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle :compinstall filename '/home/radsteve/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000000
SAVEHIST=1000000
setopt autocd
#bindkey -v
# End of lines configured by zsh-newuser-install

# user-defined

source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

export MOZ_USE_OMTC=1
export BUN_INSTALL=/home/radsteve/.bun
export EDITOR=nvim
export PATH=$HOME/.flutter/bin:$PATH
export PATH=$HOME/.yarn/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=/opt/spicetify-cli:$PATH
export PATH=$BUN_INSTALL/bin:$PATH
export PATH=/opt/shell-color-scripts/colorscripts:$PATH
export PATH=/home/radsteve/.local/share/JetBrains/Toolbox/scripts:$PATH
export _JAVA_AWT_NONREPARENTING=1
export ENABLE_FLUTTER_DESKTOP=true

startup() {
  cutefetch
}

startup

eval "$(starship init zsh)"

# edit encrypted file, permanently borrowed from reddit
ee() { # wrapper around gpg to edit encrypted files with $EDITOR
    # get file info and a temporary file name
    [ ! "$1" ] && return 1

    file="$1"
    tmp="$(mktemp -u).$(basename "$file")"

    [ -e "$file" ] # file exists?
    file_exists=$?

    file -b "$file" | grep -Eq '^GPG symmetrically encrypted data \(AES256 cipher\)$' # file is encrypted?
    file_is_enc=$?

    # if it is encrypted, decrypt it
    if [ $file_is_enc -eq 0 ]; then
        #                                                                              exit 1 on error
        gpg --output "$tmp" -d --cipher-algo AES256 --pinentry-mode loopback "$file" || return 1
    fi

    # if it did NOT get decrypted AND it exists, just edit it normally and exit
    if [ $file_is_enc -ne 0 ] && [ $file_exists -eq 0 ]; then
    #                   exit after
        $EDITOR "$file" && return 0
    fi

    [ $file_is_enc -eq 0 ] && cp "$tmp" "$tmp.orig" # if it did get decrypted, copy tmp to another tmpfile for comparison

    $EDITOR "$tmp" # open editor

    [ $file_is_enc -eq 0 ] || [ ! -e "$file" ] # original file got decrypted OR original file does not exist?
    should_enc=$?

    [ -e "$tmp" ] # tmpfile exists?
    tmp_exists=$?

    ! diff -Nq "$tmp" "$tmp.orig" > /dev/null 2>&1 # tmpfile differs from the tmpfile copy?
    tmp_modified=$?

    file -b "$tmp" | grep -Eqv '^empty$|^very short file \(no magic\)$' # tmpfile NOT empty or short?
    tmp_empty=$?

    # if all those conditions are met, encrypt
    [ $should_enc -eq 0 ] && [ $tmp_exists -eq 0 ] && [ $tmp_modified -eq 0 ] && [ $tmp_empty -eq 0 ] &&\
        gpg --output "$file" -c --cipher-algo AES256 --pinentry-mode loopback --no-symkey-cache "$tmp"

    # remove tmpfiles
    rm -f "$tmp" "$tmp.orig"
}

alias ls='exa --icons -a'
alias la='exa --icons -la'
alias tree='exa --icons --tree' 
alias _='sudo'
alias grep='grep --color=auto'
alias :q='exit'
alias cat='bat'
alias c='clear'
alias %='source ~/.zshrc'
alias c%='c && %'
alias cc%='cd && c%'
