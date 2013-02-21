# Adam's Vim Setup

My "dot vim" (`~/.vim`) dir.

# Install

Here's how to install this Vim configuration. Assumes Bash shell and a POSIX operating system.

## Replace existing Vim configuration

    cd ~
    mv .vim .vimrc /tmp
    ln -s ~/.vim/vimrc .vimrc

## Install Adam's Vim Setup

    git clone git://github.com/meonkeys/dotvim.git .vim
    cd .vim
    git submodule init
    git submodule update

## Update helptags

This is a pathogen goodie. Start Vim, and run

    :Helptags

# Initial Setup

For posterity, here's how I created this repository.

## Replace existing Vim configuration

    cd ~
    mv .vim .vimrc /tmp
    ln -s ~/.vim/vimrc .vimrc

## Install [pathogen](https://github.com/tpope/vim-pathogen)

    mkdir -p .vim/bundle
    cd .vim
    git submodule add git://github.com/tpope/vim-pathogen.git bundle/pathogen

## Install other plugins.

For example, [Gundo](http://sjl.bitbucket.org/gundo.vim/):

    git submodule add git://github.com/sjl/gundo.vim.git bundle/gundo
