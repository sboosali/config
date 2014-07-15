#!/bin/bash

source ~/.aliases

# Paths
export PATH=/usr/local/bin:$PATH # Brew's /usr/local/bin should override System's /usr/bin
export PATH=~/bin:$PATH

# show current branch when in git repo (or descendent thereof)
source ~/bin/git-prompt.sh
PS1='\w$(__git_ps1 " (%s)") \$ '
PS1="\n$PS1"

# bash history
shopt -s histappend
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# Git
export EDITOR="/usr/bin/emacs -q" # shell emacs
export GIT_EDITOR=`which nano`

function dog {
 SEP="--------------------------------------------------------"

 while read file; do
     if [ -f "$file" ]; then
         echo -e "\n"$SEP
         echo "$file"
         echo -e $SEP"\n"
         cat "$file"
     fi
 done
}

function blame {
 FILE=$1
 LINE=$2

 git show $(git blame "$FILE" -L $LINE,$LINE | awk '{print $1}')
}

# absolute path
function path {
 echo $(cd $(dirname $1); pwd)/$(basename $1)
}

