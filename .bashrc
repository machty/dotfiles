export HOME=~

# https://github.com/reactioncommerce/reaction/issues/1938
#$ sudo sysctl -w kern.maxfiles=65536
#$ sudo sysctl -w kern.maxfilesperproc=65536
#$ ulimit -n 65536

# 10/31/17: you installed a LaunchDaemon to auto-configure these
# kernel max file limits at /Library/LaunchDaemons/limit.maxfiles.plist:
# https://unix.stackexchange.com/questions/108174/how-to-persist-ulimit-settings-in-macos

# Use postgres.app path
PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"

export EDITOR="/usr/local/bin/vim"

export PATH="/Users/machty/bin:$PATH"

c_red=`tput setaf 1`
c_green=`tput setaf 2`
c_sgr0=`tput sgr0`

parse_git_branch ()
{
        if git rev-parse --git-dir >/dev/null 2>&1
        then
                gitver=$(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')
                if git diff --quiet 2>/dev/null >&2 
                then
                        gitver=${c_green}$gitver${c_sgr0}
                else
                        gitver=${c_red}''$gitver${c_sgr0}
                fi
        else
                return 0
        fi
        echo $gitver
}

export PS1="\W \$(parse_git_branch) :: "
export PS1="\W :: "

alias r='rails'
alias git=hub
alias precomp='RAILS_ENV=production bundle exec rake assets:precompile'
alias gpom='git push origin master'
alias gphm='git push heroku master'
alias gs='git status'
alias ga='git add .'
alias gl='git log'
alias gd='git diff'
alias gff='git pull --ff-only'
alias gpr='git pull --rebase'
alias be='bundle exec'
alias bef='bundle exec fastlane'
alias bo='bundle open'
alias ll='ls -lG'

alias pretty_json='python -m json.tool'

alias nombom='npm cache clear && bower cache clean && rm -rf node_modules bower_components && npm install && bower install'
alias excnombom='npm cache clear && bower cache clean && rm -rf node_modules bower_components && npm install && bower install && npm link exc-shared'
alias nom='npm cache clear && rm -rf node_modules && npm install'
alias bom='bower cache clean && rm -rf bower_components && bower install'

alias rb_stacktrace="echo 'call (void)rb_backtrace()' | lldb -p"

alias androidstudio="open -a /Applications/Android\ Studio.app"

export PATH="$HOME/.rbenv/bin:$PATH"

export EC2_HOME=$HOME/ec2
export PATH=$PATH:$EC2_HOME/bin

# NOTE: this made bash startup slow to a crawl
#export JAVA_HOME=$(/usr/libexec/java_home)
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_45.jdk/Contents/Home

# https://developer.android.com/studio/command-line/variables.html
# TL;DR, ANDROID_HOME is deprecated, but define both
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
export ANDROID_HOME=$HOME/Library/Android/sdk

export NODE_PATH=/usr/local/lib/node_modules:/usr/local/bin/node:$NODE_PATH
export EXECJS_RUNTIME=Node

[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

set -o vi
export PATH="$PATH:/usr/local/bin"

# {{{:
# Node Completion - Auto-generated, do not touch.
#shopt -s progcomp
#for f in $(command ls ~/.node-completion); do
  #f="$HOME/.node-completion/$f"
  #test -f "$f" && . "$f"
#done
# }}}

# e.g. pt -r staging
alias pt="heroku addons:open PAPERTRAIL"

alias curlheaders="curl -s -D - -o /dev/null"

export ANSIBLE_HOSTS=~/.ansible_hosts
export ANSIBLE_NOCOWS=1

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

source $HOME/.dotfiles/.git-completion.bash

[[ -s $HOME/.keys ]]             && source $HOME/.keys

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# added by travis gem
[ -f /Users/machty/.travis/travis.sh ] && source /Users/machty/.travis/travis.sh

ulimit -n 5000

export PATH="/usr/local/Cellar/php70/7.0.26_18/bin:$PATH"

complete -C '/usr/local/bin/aws_completer' aws

# Set up direnv to eval ./.envrc
# https://github.com/direnv/direnv#bash
eval "$(direnv hook bash)"

# Set up chruby and enable auto-switching based on ./.ruby-version
source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh

export PATH="$HOME/.fastlane/bin:$PATH"
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

source $HOME/.cargo/env

export PATH=$HOME/code/flutter/flutter/bin:$PATH

export CLICOLOR=1

[ -f ~/.fzf.bash ] && source ~/.fzf.bash


