if [ -x /opt/homebrew/bin/lesspipe.sh ]; then
  export LESSOPEN="|/opt/homebrew/bin/lesspipe.sh %s"
fi

alias ll='ls -lGah'
alias la='ls -Gah'
alias l='ls -G'
alias ls='ls -G'
