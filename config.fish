#!/bin/fish
set PATH ~/bin $PATH
echo 'PATH =' $PATH

source $CONFIG/.aliases   

if test -e $CONFIG/local/.aliases
 source    $CONFIG/local/.aliases
end

set VISUAL Max
