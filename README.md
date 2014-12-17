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

Some plugins require extra setup. I use `ubuntu-setup` to get them working.

### Airline

For GNU/Linux operating systems besides Ubuntu, follow the Fontconfig
instructions
[here](https://powerline.readthedocs.org/en/master/installation/linux.html#fontconfig).
General info about integrating vim-airline with fancy fonts
[here](https://github.com/bling/vim-airline#integrating-with-powerline-fonts).

### Tern

[Tern](http://ternjs.net/) provides some [IDE-like features when editing
JavaScript](https://www.youtube.com/watch?v=TIE9ZOqlvFo). Tern needs
definitions of types for JavaScript libraries in use. For example, here's how I
train Tern for Meteor projects.

    cd ~/.vim/bundle/tern_for_vim/node_modules/tern/plugin/
    wget https://raw.githubusercontent.com/Slava/tern-meteor/master/meteor.js

# See also

[My "dotfiles"](https://gitlab.com/meonkeys/dotfiles), configuration files for
other programs I use on my GNU/Linux desktop.
