#!/usr/bin/env bash

set -e

# Shared functions

pretty_print() {
    printf "\n%b\n" "$1"
}

pretty_print "Here we go..."

# Homebrew installation

if ! command -v brew &>/dev/null; then
    pretty_print "Installing Homwebrew, follow  the instructions..."

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # mkdir homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C homebrew
    # eval "$(homebrew/bin/brew shellenv)"
    brew update --force --quiet
    chmod -R go-w "$(brew --prefix)/share/zsh"
else
    pretty_print "You already have Homebrew installed..."
fi

if ! command -v ansible $>/dev/null; then
    pretty_print "Installing Ansible..."

    brew install ansible

else
    pretty_print "You already have Ansible installed..."
fi 

## pull ansible
sudo ansible-pull -U https://github.com/apmontgomery/ansible.git

ansible-playbook local.yml
