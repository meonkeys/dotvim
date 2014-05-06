# Adam's Vim Setup

My "dot vim" (`~/.vim`) dir.

# Install

Here's how to install this Vim configuration. Assumes Bash shell and a POSIX
operating system.

## Replace existing Vim configuration

    cd ~
    mv .vim .vimrc /tmp
    ln -s ~/.vim/vimrc .vimrc

## Install Adam's Vim Setup

    git clone https://github.com/meonkeys/dotvim.git .vim
    cd .vim

## Install Vundle

Plugins are managed with Vundle. Install Vundle:

    git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

## Install Plugins

Start Vim and run `:PluginInstall`. Done!

Plugins are enumerated in `vimrc`. See the vundle documentation in `:help
vundle` or [online](https://github.com/gmarik/Vundle.vim) for further
instructions.

## Misc Plugin Notes

Some plugins require extra setup.

### YouCompleteMe

    mkdir /tmp/ycm_build && cd /tmp/ycm_build
    cmake -G "Unix Makefiles" -DUSE_SYSTEM_LIBCLANG=ON . ~/.vim/bundle/YouCompleteMe/cpp
    make ycm_support_libs

### Command-T

    sudo apt-get install ruby1.9.1-dev
    cd ~/.vim/bundle/Command-T/ruby/command-t/
    ruby extconf.rb
    make
