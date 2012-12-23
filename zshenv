# zsh の設定ファイル
# ログインシェルとして起動された場合のみ
# に読みこまれる設定
# 環境変数のような一度設定しておけばよいものを書いておく
# echo "loading zshenv"

export LANG=ja_JP.UTF-8

# path settings

export BREW_PATH=/usr/local/bin:/usr/local/sbin
export SBAZ_PATH=~/Library/sbaz/bin
export GAE_GO=/opt/other/google_appengine
export HASKELL=~/Library/Haskell/bin
export AIRSDK=/opt/other/AdobeAIRSDK/bin
export LOCAL_PATH=~/bin

export PATH=$LOCAL_PATH:$HASKELL:$GAE_GO:$SBAZ_PATH:$AIRSDK:$BREW_PATH:$PATH

# ruby
export RUBYLIB=~/Library/rubylib/lib








