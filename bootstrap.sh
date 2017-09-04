#!/usr/bin/env bash

########## Variables

dir="$HOME/.dotfiles"                    # dotfiles directory
olddir="$HOME/.dotfiles_old"             # old dotfiles backup directory

##########

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir || exit
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
while read -r -d '' file; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv "$HOME/$file" "$olddir"
    echo "Creating symlink to $file in home directory."
    ln -s "$dir/$file" "$HOME/$file"
done < <(find . -name ".*" ! -name ".git" ! -name "." ! -name ".DS_Store" -print0 | sed "s/\.\///g")
