#!/bin/bash
# ~/.bashrc -> ~/.profile -> $CONFIG/.profile -> $CONFIG/.aliases
# (maybe) -> $CONFIG/local/.aliases
# (maybe) -> $CONFIG/local/.profile


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
source $CONFIG/.aliases
# local config overrides global config
if [ -f     $CONFIG/local/.aliases ]
then source $CONFIG/local/.aliases
fi
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #


# Paths
export PATH=/usr/local/bin:$PATH # Brew's /usr/local/bin should override System's /usr/bin
export PATH=~/bin:$PATH
PATH=/Library/Frameworks/Python.framework/Versions/3.3/bin:$PATH
PATH=$PATH:~/bin:~/bin/abcmidi
PATH=$PATH:~/sox:/usr/texbin:/usr/X11/bin
PATH=$PATH:~/Library/Haskell/bin
PATH=$PATH:/Applications/CoqIdE_8.4.app/Contents/Resources/bin
PATH=$PATH:~/bin/scala/bin
# Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
export PATH

# show current branch when in git repo (or descendent thereof)
source ~/bin/git-prompt.sh
PS1='\w$(__git_ps1 " (%s)") \$ '
PS1="\n$PS1"
#export PS1="\n\w \[\033[31m\]\`git branch 2> /dev/null | grep ^[\*] | sed -E  s/^\\\\\\\\\*\ \(.+\)$/\(\\\\\\\\\1\)\ /\`\[\033[37m\]$\[\033[00m\] "

# editors
export VISUAL=Max

# bash history
shopt -s histappend
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"


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

# better history
export HISTCONTROL=erasedups
export HISTFILESIZE=HISTSIZE=
export PROMPT_COMMAND='history -a'

# Haskell
# for ghc and ghci in .aliases and for h and hp in ~/bin/
export ghcopts="-XNoMonomorphismRestriction -XFlexibleContexts"

# Python
PYTHONPATH=$PYTHONPATH:~/bin/python
PYTHONPATH=$PYTHONPATH:/Library/Frameworks/Python.framework/Versions/3.3/lib/python3.3/site-packages
export PYTHONPATH
IPYTHONDIR=~/.ipython
export IPYTHONDIR

# Coq
COQPATH=$COQPATH:~/bin/ProofGeneral/coq/ex/


function mysql() {

if [ $# -gt 1 ]
then echo "Usage: mysql [start stop \"\"]"
     return 0
fi

case "$1" in
start) sudo /opt/local/bin/mysqld_safe5 &
;;
stop)  /opt/local/bin/mysqladmin5 -u root -p shutdown
;;
"")    echo todo
;;
*)     echo "Usage: mysql [start stop \"\"]"
;;
esac
}

function download {
    URL=$1
    FILE=`basename $1`
    curl $URL > $FILE
}

function pl {
prolog -q -s path.pl -t 'halt.'
}

SPHINX_HOME=~/bin/sphinx4/sphinx4-5prealpha
alias transcribe="java -jar $SPHINX_HOME/bin/Transcriber.jar"


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# local config extends global config
if [ -f     $CONFIG/local/.profile ]
then source $CONFIG/local/.profile
fi
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
