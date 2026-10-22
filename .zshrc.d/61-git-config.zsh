# Git colors and aliases. Written to ~/.gitconfig only when missing or different:
# unconditional `git config --global` in every new shell races for the lock when
# cmux restores several tabs at once ("could not lock config file").
() {
  local -A want=(
    color.diff.meta         'yellow bold'
    color.diff.frag         'magenta bold'
    color.diff.old          'red bold'
    color.diff.new          'green bold'

    color.status.added      yellow
    color.status.changed    green
    color.status.untracked  cyan

    alias.co        checkout
    alias.ci        commit
    alias.st        'status --ignore-submodules'
    alias.br        branch
    alias.hist      'log --pretty=format:"%h %ad | %s%d [%an]" --graph --date=short'
    alias.type      'cat-file -t'
    alias.dump      'cat-file -p'
    alias.stashall  'stash --include-untracked'
    alias.loog      'log --graph --all --decorate --oneline'
  )
  local nl=$'\n' have="$nl$(git config --global --list 2>/dev/null)$nl" k
  for k in ${(k)want}; do
    [[ $have == *"$nl$k=${want[$k]}$nl"* ]] || git config --global $k ${want[$k]}
  done
}
