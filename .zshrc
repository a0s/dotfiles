# Load every fragment from ~/.zshrc.d in lexical order.
# Shared fragments are tracked in the dotfiles repo; *.local.zsh stay on this machine.
for f in ~/.zshrc.d/*.zsh(N); do
  source "$f"
done
unset f
