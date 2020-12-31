#!/bin/bash

touch /home/omega/init

sudo chsh -s /usr/bin/fish omega

cd /home/omega && \
    mkdir Code && \
    cd Code && \
    git clone https://github.com/pbek/QOwnNotes.git && \
    cd QOwnNotes && \
    git submodule update --init
