#!/bin/bash

DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"

cd "${DOTFILES_DIR}/links" || exit 1
echo "🔗 Create a link using GNU Stow..."

for pkg in *; do
    if [ -d "$pkg" ]; then
      stow -R -v -t ~ "$pkg"
    fi
done

echo "✅ All links updated!"