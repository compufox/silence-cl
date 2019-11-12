# silence
### _ava fox_

a rewrite of [silence](https://github.com/theZacAttacks/silence) in common lisp and also with a gui

## Installation

[download a release](https://github.com/theZacAttacks/silence-cl/releases) for your os and run!

note: *nix systems will need tcl/tk 8.5+ installed. do so via your package manager.

## Building

First you'll need to install a lisp implementation. My reccomendation is installing [roswell](https://github.com/roswell/roswell), because it defaults to a decent implementation and gives you the ability to choose between multiple implementations (much like rbenv does for ruby).

Once that's installed you can run this command and it'll download a shell script from this repo and run it. It'll print out info about what it's doing along the way, as well :3

`bash $(curl -fsSL https://raw.githubusercontent.com/theZacAttacks/silence-cl/master/dist/setup.sh)`

Once that's done go into the `silence-cl` directory 

`cd ~/common-lisp/silence-cl/`

and run `make`

the binary will be located in `silence-cl/bin`

you'll still need tk8.6 and tcl8.6 installed to run the binary, and if you're on windows you'll need to unzip the tk_windows.zip and place the binary next to the `bin` and `lib` folders

If you have any questions/issues please open an issue here! 

## Usage

run the application,

enter in the information it requires,

block gab instances :3

## License

NPLv1+

