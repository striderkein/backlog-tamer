#!/bin/sh

export $(cat .env | grep -v ^#)
ln -s $(pwd)/main.sh /usr/local/bin/balo
