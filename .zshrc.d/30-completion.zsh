if type brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh-completions:$FPATH"
fi
autoload -Uz compinit
compinit
zmodload zsh/complist
zstyle ':completion:*' menu select
