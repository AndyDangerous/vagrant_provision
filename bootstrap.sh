#!/usr/bin/env bash

set -ex

# set some ENV VARS
RUBY_VERSION=2.3.1
VAGRANT_HOME_DIR=/home/vagrant

# install all the (aptitude) things!
apt-get update
apt-get -y install wget docker.io git autoconf bison build-essential libssl-dev libyaml-dev libreadline-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev libsqlite3-dev silversearcher-ag tmux

install docker-compose
curl -L https://github.com/docker/compose/releases/download/1.7.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# install elixir
wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && sudo dpkg -i erlang-solutions_1.0_all.deb
apt-get update
apt-get -y install esl-erlang elixir

# install Ruby with rbenv
git clone https://github.com/sstephenson/rbenv.git $VAGRANT_HOME_DIR/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> $VAGRANT_HOME_DIR/.bashrc
echo 'eval "$(rbenv init -)"' >> $VAGRANT_HOME_DIR/.bashrc
source $VAGRANT_HOME_DIR/.bashrc

git clone https://github.com/sstephenson/ruby-build.git $VAGRANT_HOME_DIR/.rbenv/plugins/ruby-build
cd $VAGRANT_HOME_DIR/.rbenv/plugins/ruby-build/
su vagrant
sudo ./install.sh

sudo $VAGRANT_HOME_DIR/.rbenv/bin/rbenv install $RUBY_VERSION
sudo $VAGRANT_HOME_DIR/.rbenv/bin/rbenv global $RUBY_VERSION
sudo $VAGRANT_HOME_DIR/.rbenv/bin/rbenv rehash
sudo $VAGRANT_HOME_DIR/.rbenv/bin/rbenv exec gem install bundler --no-ri --no-rdoc
sudo $VAGRANT_HOME_DIR/.rbenv/bin/rbenv rehash

# get some dotfiles
cd $VAGRANT_HOME_DIR
git clone https://github.com/AndyDangerous/dotfiles.git



# let vagrant user own all the things in its home dir
chown -R vagrant:vagrant /home/vagrant/
