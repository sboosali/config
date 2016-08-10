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

