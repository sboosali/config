
Setup 
===
$ chmod +x setup.sh 
$ ./setup.sh 


Foot Pedal
===

to use the foot pedal as modifier keys, you must merge keypresses from different input devices (mac keeps them seperate):
$ git clone https://github.com/mejedi/my-multiple-keyboards
$ cd my-multiple-keyboards
$ ./build.sh
to install, open MyMultipleKeyboards.pkg
to activate, open Preferences, click My Multiple Keyboards, select "On any keyboard"

breaks Alfred clipboard history pasting. you must hold "command" when pasting from Aflred (otherwise, it just types "v")


Local v Global
===

you can have a local config override the global config via `local/*`


Package Managers
===
brew list
cabal list --installed
pip freeze


Daemons
=== 
killall -KILL distnoted


Haskell
===
stack new my-package ~/config/stack/templates/spirosboosalis.hsfiles -p "module-name:MyPackage" -p "category:Development"
stack new my-script  ~/config/stack/templates/shell-monad.hsfiles 

