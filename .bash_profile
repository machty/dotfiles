# .bash_profile is meant for login shells, but OS X always runs
# its terminals (Terminal.app and iTerm) as login shells, hence
# it only runs .bash_profile by default. Most install scripts
# expect to install into bashrc, so we keep all the config there
# and just source it from here.

# 11/12/17: I made this read-only so that scripts don't try to set it.

if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

