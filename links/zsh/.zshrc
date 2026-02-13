export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"

# sheldon (plugin manager)
eval "$(sheldon source)"

# eza (ls alternative)
alias ls="eza --icons --group-directories-first"
alias lt="eza --icons --group-directories-first --tree --level=2"

# OSC 7 (notify terminal of current directory)
__wezterm_osc7() {
  printf '\e]7;file://%s%s\e\\' "${HOST}" "${PWD}"
}
add-zsh-hook chpwd __wezterm_osc7
__wezterm_osc7

# starship (prompt)
eval "$(starship init zsh)"

function gitmain() {
  git config --global user.name "keisuke3"
  git config --global user.email "ishii@gizumo-inc.jp"
}

function gitcyg() {
  git config --global user.name "ishii_keisuke-a_cyg"
  git config --global user.email "ishii_keisuke_a@external.cygames.jp"
}
