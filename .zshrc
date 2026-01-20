alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
  autoload -Uz compinit
  compinit
  zmodload zsh/complist
  zstyle ':completion:*' menu select
fi

HISTSIZE=50000
SAVEHIST=50000
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
alias history='fc -l 1'

export LANG="C.UTF-8"
export LC_COLLATE="C.UTF-8"
export LC_CTYPE="C.UTF-8"
export LC_MESSAGES="C.UTF-8"
export LC_MONETARY="C.UTF-8"
export LC_NUMERIC="C.UTF-8"
export LC_TIME="C.UTF-8"
unset LC_ALL

eval "$(starship init zsh)"
eval "$(direnv hook zsh)" && source ~/.direnvrc
eval "$(pyenv init - zsh)"

git config --global color.diff.meta "yellow bold"
git config --global color.diff.frag "magenta bold"
git config --global color.diff.old "red bold"
git config --global color.diff.new "green bold"

git config --global color.status.added yellow
git config --global color.status.changed green
git config --global color.status.untracked cyan

git config --global alias.co checkout
git config --global alias.ci commit
git config --global alias.st 'status --ignore-submodules'
git config --global alias.br branch
git config --global alias.hist 'log --pretty=format:"%h %ad | %s%d [%an]" --graph --date=short'
git config --global alias.type 'cat-file -t'
git config --global alias.dump 'cat-file -p'
git config --global alias.stashall 'stash --include-untracked'
git config --global alias.loog 'log --graph --all --decorate --oneline'

alias ll='ls -lGah'
alias la='ls -Gah'
alias l='ls -G'
alias ls='ls -G'

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
