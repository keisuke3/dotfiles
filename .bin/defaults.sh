#!/bin/bash

if [ "$(uname)" != "Darwin" ] ; then
	echo "Not macOS!"
	exit 1
fi

# キーリピートを最速に設定
defaults write NSGlobalDomain KeyRepeat -int 2

# リピート入力認識までの時間を最短に設定
defaults write NSGlobalDomain InitialKeyRepeat -int 25
