
Foot Pedal
===

must merge keypresses with active modifier keys from multiple keyboards (mac keeps them seperate):
$ git clone https://github.com/mejedi/my-multiple-keyboards
$ cd my-multiple-keyboards
$ ./build.sh
open MyMultipleKeyboards.pkg to install
open Preferences, click My Multiple Keyboards, and select "On any keyboard"

breaks Alfred clipboard history pasting. you must hold "CMD" when pasting from Aflred (otherwise, it just types "v")


Local v Global
===

you can have a local config override the global config via `local/*`
