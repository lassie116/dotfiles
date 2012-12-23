# zsh の設定ファイル
# ログインシェルとして起動された場合のみ
# に読みこまれる設定
# 環境変数のような一度設定しておけばよいものを書いておく
echo "loading zprofile"


export PORTS_MANPATH=/opt/local/man
export MANPATH=$PORTS_MANPATH:$MANPATH

# go lang setting
export GOROOT=$HOME/src/go
export GOOS=darwin
export GOARCH=amd64


