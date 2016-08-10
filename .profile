#!/bin/bash

# ~/.bashrc -> ~/.profile -> $CONFIG/.profile -> $CONFIG/.aliases
# (maybe) -> $CONFIG/local/.aliases
# (maybe) -> $CONFIG/local/.profile

# flow:
# ~/.profile -> $CONFIG/.profile -> $CONFIG/.aliases

# symbolically link to (I just use source)
# ln -s ~/.profile $CONFIG/.profile

CONFIG=~/config # TODO here? 

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
source $CONFIG/.aliases

# when run from a terminal in Emacs, the EMACSPATH as already been exported; EMACSPATH is used during Emacs initialization for "sub-app" custom initialization, by checking the name of the app e.g. Work.app versus Notes.app; we save time and avoid the wrong settings by not running these "sub-app"s
alias commit="export EMACSPATH=; git add -u; git commit"

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Paths
export PATH=~/bin:$PATH

# # Haskell: Add GHC 7.10.1 to the PATH, via https://ghcformacosx.github.io/
# export GHC_DOT_APP="/Applications/ghc-7.10.1.app"
# if [ -d "$GHC_DOT_APP" ]; then
#   export PATH="${HOME}/.cabal/bin:${GHC_DOT_APP}/Contents/bin:${PATH}"
# fi

# Haskell: stack 
# export PATH=${HOME}/.stack/programs/x86_64-osx/ghc-7.10.3/bin:$PATH  

# Haskell: sandbox cabal (relative path) and Emacs cabal and user cabal. 
export PATH=.cabal-sandbox/bin:~/.emacs.d/.cabal-sandbox/bin:~/.cabal/bin:$PATH  

PATH=/usr/local/bin:$PATH # Brew's /usr/local/bin should override
                          # System's /usr/bin
PATH=/usr/local/opt/llvm/bin:$PATH
# PATH=/Library/Frameworks/Python.framework/Versions/3.3/bin:$PATH
# PATH=$PATH:~/sox:/usr/texbin:/usr/X11/bin
# PATH=$PATH:~/Library/Haskell/bin
# PATH=$PATH:/Applications/CoqIdE_8.4.app/Contents/Resources/bin
# PATH=$PATH:~/bin/scala/bin
# PATH="/usr/local/heroku/bin:$PATH" # Added by the Heroku Toolbelt

PATH=~/config/bin:$PATH

echo 'PATH =' $(echo $PATH | tr ':' '\n')
echo

# show current branch when in git repo (or descendent thereof)
source ~/bin/git-prompt.sh
PS1='\w$(__git_ps1 " (%s)") \$ '
PS1="\n$PS1"
#export PS1="\n\w \[\033[31m\]\`git branch 2> /dev/null | grep ^[\*] | sed -E  s/^\\\\\\\\\*\ \(.+\)$/\(\\\\\\\\\1\)\ /\`\[\033[37m\]$\[\033[00m\] "



# ln -sf /Applications/Emacs.app/Contents/MacOS/Emacs                       /usr/local/bin/emacs
# ln -sf /Applications/Emacs.app/Contents/MacOS/bin-x86_64-10_5/emacsclient /usr/local/bin/emacsclient
# emacsclient --alternate-editor Emacs "$@"  # Emacs client "this application will not run on your computer" 
# ln -sf /Applications/Emacs.app/Contents/MacOS/Emacs /usr/local/bin/emacsclient

emacs="/Applications/Emacs.app/Contents/MacOS/Emacs"
# alias emacsclient="/Applications/Emacs.app/Contents/MacOS/bin/emacsclient"
# emacs --file 

function edit () { 
emacs "$@"
}


# editors
# "The editor used to edit the commit log message will be chosen
#    from the GIT_EDITOR environment variable, the core.editor configuration
#    variable, the VISUAL environment variable, or the EDITOR environment
#    variable (in that order)."
export GIT_EDITOR=emacs
export VISUAL=emacs
export EDITOR=emacs

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

SPHINX_HOME=~/bin/sphinx4/sphinx4-5prealpha
alias transcribe="java -jar $SPHINX_HOME/bin/Transcriber.jar"

alias clean-Haskell="remove $1.{dyn_hi,dyn_o,hi,o}"

function backup {
 BACKUP=/Volumes/Backup/Backups
 cp ~/diary/*        $BACKUP/diary/
 cp ~/Dropbox/*.note $BACKUP/Dropbox/
 cp ~/Haskell/*.{hs,lhs} $BACKUP/Haskell/
 #TODO http://superuser.com/questions/299938/how-can-i-recursively-copy-files-by-file-extension-preserving-directory-structu
}

# converts video to audio, and opens it in iTunes
function blind {
 NAME="${1%%.*}"
 INPUT="$NAME.mp4"
 OUTPUT="$NAME.m4a"
 # echo $NAME
 ffmpeg  -i "$INPUT"  -c copy "$OUTPUT"
 open "$OUTPUT"
}

function cobra () {
python -c "
import sys
x = list(sys.stdin)[0].strip().split()
print($@)
"
}

function space () {
stat -f%z "$@" | cobra '(float(x[0])/1e9, "gigabytes")'
}

function brush () {
# synonym for "touch"
mkdir -p `dirname "$1"`
touch "$1"
}

# stupid OS X demons: iCloud synchronizing, update nagging, spellchecking
killall EscrowSecurityAlert nbagent LaterAgent AppleSpell > /dev/null

# Pretty print the path
function show-path () {
echo $PATH | tr ':' '\n'
}

# Running projects
function h() {
    stack build --ghc-options -fno-code
    stack build && stack exec "$1"
}

# New project scaffolding
function hnew () {
    PACKAGE="$1"
    MODULE="$2"

    echo $PACKAGE | pbcopy
    open https://github.com/new # create repository

    stack new $PACKAGE ~/spiros/config/stack/templates/spirosboosalis.hsfiles -pmodule:$MODULE
    cd $PACKAGE
    stack build
    stack exec -- $PACKAGE-example

    git init
    git add .
    git commit -m"1st"
    git remote add origin https://github.com/sboosali/$PACKAGE.git
    git push -u origin master

    open sources/$MODULE/Example.hs
}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# local config extends global config
if [ -f     $CONFIG/local/.profile ]
then source $CONFIG/local/.profile
fi
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
