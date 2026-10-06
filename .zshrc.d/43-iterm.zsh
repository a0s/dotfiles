# iTerm2 per-directory color preset, driven by direnv's ITERM_THEME
export ITERM_DEFAULT_THEME="Claude Dark"
_iterm_sync_theme() {
  [[ "$TERM_PROGRAM" == "iTerm.app" ]] || return
  local want="${ITERM_THEME:-$ITERM_DEFAULT_THEME}"
  [[ "$want" == "$_ITERM_THEME_CUR" ]] && return
  printf '\e]1337;SetColors=preset=%s\a' "$want" > /dev/tty
  _ITERM_THEME_CUR="$want"
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd _iterm_sync_theme
