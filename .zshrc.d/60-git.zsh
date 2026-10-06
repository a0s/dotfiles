alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
alias gpr='git pull --rebase'

wtcd() {
  local wt_path
  wt_path=$(git worktree list | grep "$1" | awk '{print $1}' | head -n 1)

  if [ -n "$wt_path" ]; then
    cd "$wt_path"
  else
    echo "Worktree '$1' не найден!"
  fi
}
