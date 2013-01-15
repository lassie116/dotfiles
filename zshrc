# zshの設定ファイル
# ログインシェルとして起動された場合
# インタラクティブシェルとして起動された場合
# に読みこまれる
# 基本的な設定を書いておけばよい

echo "loading zshrc"

# path
export PATH=$LOCAL_PATH:$RBENV:$PATH

# main

autoload colors
colors
RPROMPT="%{${fg[yellow]}%}[%~]%{${reset_color}%}"
PROMPT="%n@%m$ "
bindkey -e                  # emacs keybind

autoload -U compinit
compinit

setopt auto_cd
setopt auto_pushd
setopt correct
setopt list_packed
setopt noautoremoveslash

# history settings

HISTFILE=~/.zsh_history
HISTSIZE=100000000
SAVEHIST=$HISTSIZE
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data 
setopt inc_append_history

# for awesome with ibus
xmodmap -e 'keysym Muhenkan = Super_L'

# aliases

alias ls="ls --color"

# for screen

preexec () {
  [ ${STY} ] && echo -ne "\ek${1%% *}\e\\"
}

# for rvm

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" 
