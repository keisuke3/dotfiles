#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
VSCODE_SETTING_PATH="${HOME}/Library/Application\ Support/Code - Insiders/User/settings.json"
VSCODE_KEYBINDINGS_PATH="${HOME}/Library/Application\ Support/Code - Insiders/User/keybindings.json"

# Link settings.json to vscode
if not [ -L "${VSCODE_SETTING_PATH}" ]; then
  echo "Linking settings.json to Code - Insiders..."
  ln -fsvn "${SCRIPT_DIR}/settings.json" "${VSCODE_SETTING_PATH}"
else
  echo "Code - Insiders settings.json is not found."
fi

# Link keybindings.json to vscode
if not [ -L "${VSCODE_KEYBINDINGS_PATH}" ]; then
  echo "Linking keybindings.json to Code - Insiders..."
  ln -fsvn "${SCRIPT_DIR}/keybindings.json" "${VSCODE_KEYBINDINGS_PATH}"
else
  echo "Code - Insiders keybindings.json is not found."
fi

# Install extensions to vscode
if [ "$(which "code-insiders")" != "" ]; then
  echo "Installing extensions to Code - Insiders..."
  cat < "${SCRIPT_DIR}/extensions" | while read -r line
  do
    code-insiders --install-extension "$line"
  done
else
  echo "Code - Insiders command not found."
fi