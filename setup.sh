# ln -sf FILE LINK 

# environment variables 
# CONFIG=~/config 

# bash
# ln -sf ~/config/X ~/X  
ln -sf ~/config/.aliases ~/.aliases 
ln -sf ~/config/.profile ~/.profile 
ln -sf ~/config/.bashrc  ~/.bashrc

# git  
ln -sf ~/config/.gitconfig ~/.gitconfig 
git config --global core.excludesfile ~/config/git/.gitignore # TODO just track the config file 

# ghci 
ln -sf ~/config/ghci.conf ~/.ghc/ghci.conf

# stack 
# ln -s ~/config/stack/X ~/.stack/X 
ln -sf ~/config/stack/config.yaml                      ~/.stack/config.yaml
ln -sf ~/config/stack/templates/spirosboosalis.hsfiles ~/.stack/templates/spirosboosalis.hsfiles
ln -sf ~/config/stack/templates/shell-monad.hsfiles    ~/.stack/templates/shell-monad.hsfiles

# StayFocusd?

# X-keys?

# terminal
# faster repeat when holding down keys (e.g. arrow keys in mouse-less terminal)
defaults write NSGlobalDomain KeyRepeat -int 2

defaults write com.apple.finder AppleShowAllFiles YES
killall Finder

# karabiner

# nix
# http://nixos.org/nix/manual/
# bash <(curl https://nixos.org/nix/install)
ln -sf ~/config/nix/config.nix  ~/.nixpkgs/config.nix

# User Profiles

# local? 

