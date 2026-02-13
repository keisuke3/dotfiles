#!/bin/bash
# Raycast Git Repos から WezTerm の既存ウィンドウにタブで開くスクリプト
# Usage: open-in-wezterm.sh <directory>

DIR="${1:-.}"
WEZTERM="$(command -v wezterm)"

if [ -z "$WEZTERM" ]; then
  echo "wezterm not found" >&2
  exit 1
fi

if "$WEZTERM" cli list &>/dev/null; then
  # 既存ウィンドウに新しいタブを生成
  "$WEZTERM" cli spawn --cwd "$DIR" > /dev/null 2>&1
  # WezTerm を前面に持ってくる
  open -a WezTerm
else
  # WezTerm を起動して指定ディレクトリで開く
  open -a WezTerm
  # WezTerm の起動を待つ
  for i in $(seq 1 30); do
    if "$WEZTERM" cli list &>/dev/null; then
      break
    fi
    sleep 0.2
  done
  # 起動後、デフォルトタブで対象ディレクトリへ移動
  if "$WEZTERM" cli list &>/dev/null; then
    PANE_ID=$("$WEZTERM" cli list --format json | /usr/bin/python3 -c "import sys,json; panes=json.load(sys.stdin); print(panes[0]['pane_id'])" 2>/dev/null)
    if [ -n "$PANE_ID" ]; then
      "$WEZTERM" cli send-text --pane-id "$PANE_ID" --no-paste "cd $(printf '%q' "$DIR") && clear"$'\n'
    fi
  fi
fi
