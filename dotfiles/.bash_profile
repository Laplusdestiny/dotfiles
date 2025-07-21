#! /bin/bash

if [[ -f ~/.bashrc ]] ; then
    . ~/.bashrc
fi
_byobu_sourced=1 . /usr/bin/byobu-launch 2>/dev/null || true
