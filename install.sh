#!/bin/bash
#**************************************************************************
#Copyright © 2016 jianglin
#File Name: install.sh
#Author: jianglin
#Email: xiyang0807@gmail.com
#Created: 2016-06-21 14:38:53 (CST)
#Last Update: Thursday 2018-03-08 16:45:16 (CST)
#          By:
#Description:
#**************************************************************************/
# echo 'You might need to change your default shell to zsh: `chsh -s /bin/zsh` (or `sudo vim /etc/passwd`)'

# dir="$HOME/git"
# cd $dir
# git clone https://github.com/honmaple/dotfiles.git honmaple
# cd honmaple

# dotfiles="$HOME/git/honmaple"

# if [[ -d "$dotfiles" ]]; then
#   echo "Symlinking dotfiles from $dotfiles"
# else
#   echo "$dotfiles does not exist"
#   exit 1
# fi

link() {
  from="$1"
  to="$2"
  echo "Linking '$from' to '$to'"
  # rm -f "$to"
  ln -s "$from" "$to"
}
link emacs.d $HOME/.emacs.d
link vim $HOME/.vim
link i3 $HOME/.i3

# for location in $(find home -name '.*'); do
#   file="${location##*/}"
#   file="${file%.sh}"
#   link "$dotfiles/$location" "$HOME/$file"
# done
