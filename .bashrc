export HOME=~

# Use postgres.app path
PATH="/Applications/Postgres.app/Contents/Versions/9.4/bin:$PATH"

export EDITOR="$HOME/bin/mvim"

export PATH="~/bin:$PATH"

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
alias bo='bundle open'

alias nombom='npm cache clear && bower cache clean && rm -rf node_modules bower_components && npm install && bower install'
alias nom='npm cache clear && rm -rf node_modules && npm install'
alias bom='bower cache clean && rm -rf bower_components && bower install'

export PATH="$HOME/.rbenv/bin:$PATH"

export EC2_HOME=$HOME/ec2
export PATH=$PATH:$EC2_HOME/bin

export JAVA_HOME=$(/usr/libexec/java_home)

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
alias pt="heroku addons:open papertrail"

alias curlheaders="curl -s -D - -o /dev/null"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

export PATH="$PATH:$HOME/.android-sdk/tools" 
export PATH="$PATH:$HOME/.android-sdk/platform-tools" 

export ANDROID_HOME=$HOME/.android-sdk

export ANSIBLE_HOSTS=~/.ansible_hosts
export ANSIBLE_NOCOWS=1

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

source $HOME/.dotfiles/.git-completion.bash




[[ -s $HOME/.keys ]]             && source $HOME/.keys



### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
