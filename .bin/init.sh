#!/bin/bash

if [ "$(uname)" != "Darwin" ] ; then
	echo "Not macOS!"
	exit 1
fi

# Install Xcode
if ! xcode-select -p &>/dev/null; then
	echo "📦 Installing Xcode Command Line Tools..."
	xcode-select --install > /dev/null
fi

# Install Homebrew
if ! command -v brew &>/dev/null; then
	echo "🍺 Installing Homebrew..."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" >/dev/null
fi

# Install Git
if ! command -v git &>/dev/null; then
	echo "🔧 Installing Git..."
	brew install git > /dev/null
fi

# Install dotfiles repository
DOTFILES_DIR="$HOME/dotfiles"
if [ ! -d "$DOTFILES_DIR" ]; then
	echo "📁 Cloning dotfiles repository..."
	git clone https://github.com/keisuke3/dotfiles.git "$DOTFILES_DIR"
fi

echo "✅ Initialization complete!"