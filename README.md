# Adam's Vim Setup

My "dot vim" (`~/.vim`) dir.

## Features

* Great starting point for using Vim for editing source code in many
  programming languages.
* Easy to extend: all plugins are loaded with [Vundle](https://github.com/gmarik/Vundle.vim).
* Fold-able, well-commented vimrc file.
* Lots of great ideas and some terrible ones!

## Install

Here's how to install this Vim configuration. Assumes Bash shell and a POSIX
operating system.

### Replace existing Vim configuration

    cd ~
    mv .vim .vimrc /tmp
    ln -s ~/.vim/vimrc .vimrc

### Install Adam's Vim Setup

    git clone https://github.com/meonkeys/dotvim.git .vim
    cd .vim

### Install Vundle

Plugins are managed with Vundle. Install Vundle:

    git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

### Install Plugins

Start Vim and run `:PluginInstall`. Done!

Plugins are enumerated in `vimrc`. See the vundle documentation in `:help
vundle` or [online](https://github.com/gmarik/Vundle.vim) for further
instructions.

### Misc Plugin Notes

Some plugins require extra setup. I use `ubuntu-setup` to get them working.

Only install `vim-nox` on Ubuntu 18.04. `vim-gtk` and others do not have ruby support. If `update-alternatives` points to the wrong one you won't get `+ruby` and Command-T won't work.

#### Airline

For GNU/Linux operating systems besides Ubuntu, follow the Fontconfig
instructions
[here](https://powerline.readthedocs.org/en/master/installation/linux.html#fontconfig).
General info about integrating vim-airline with fancy fonts
[here](https://github.com/bling/vim-airline#integrating-with-powerline-fonts).

# See also

[My "dotfiles"](https://gitlab.com/meonkeys/dotfiles), configuration files for
other programs I use on my GNU/Linux desktop.
