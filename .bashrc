export HOME=~

# 10/31/17: you installed a LaunchDaemon to auto-configure these
# kernel max file limits at /Library/LaunchDaemons/limit.maxfiles.plist:
# https://unix.stackexchange.com/questions/108174/how-to-persist-ulimit-settings-in-macos
# TODO: symlink this so that file is in dotfiles.
ulimit -n 5000

# Paths
# TODO: expand, audit, reorder, cleanup
export PATH="/Users/machty/.dotfiles/bin:$PATH"
export PATH="/Users/machty/bin:$PATH"
export PATH="/Users/machty/Library/Python/2.7/bin:$PATH"
export PATH="$PATH:/usr/local/bin"
export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.fastlane/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"
export PATH=$HOME/code/flutter/flutter/bin:$PATH

# Editor
export EDITOR="/usr/local/bin/vim"

# android
alias androidstudio="open -a /Applications/Android\ Studio.app"
# https://developer.android.com/studio/command-line/variables.html
# TL;DR, ANDROID_HOME is deprecated, but define both
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
export ANDROID_HOME=$HOME/Library/Android/sdk

# ansible
export ANSIBLE_HOSTS=~/.ansible_hosts
export ANSIBLE_NOCOWS=1

# aws
complete -C '/usr/local/bin/aws_completer' aws
export AWS_PROFILE=exc

# bundler
alias be='bundle exec'
alias bef='bundle exec fastlane'

# bash
export PS1="\W :: "
alias ll='ls -lG'
alias ptmp="pushd $(mktemp -d)"
set -o vi
export CLICOLOR=1

# curl
alias curlheaders="curl -s -D - -o /dev/null"
alias download="curl -O"

# direnv
eval "$(direnv hook bash)"

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# git
alias git=hub
alias precomp='RAILS_ENV=production bundle exec rake assets:precompile'
alias gs='git status'
alias gff='git pull --ff-only'
alias gpr='git pull --rebase'
source $HOME/.dotfiles/.git-completion.bash

# go
export GOPATH="$HOME/go"

# heroku
alias pt="heroku addons:open PAPERTRAIL"

# java
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_45.jdk/Contents/Home

# json
alias pretty_json='python -m json.tool'

# node
export NODE_PATH=/usr/local/lib/node_modules:/usr/local/bin/node:$NODE_PATH
export EXECJS_RUNTIME=Node

# npm
alias nombom='npm cache clear && bower cache clean && rm -rf node_modules bower_components && npm install && bower install'
alias nom='npm cache clear && rm -rf node_modules && npm install'
alias bom='bower cache clean && rm -rf bower_components && bower install'

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# ruby
source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh

# rust
source $HOME/.cargo/env

# travis
[ -f /Users/machty/.travis/travis.sh ] && source /Users/machty/.travis/travis.sh

