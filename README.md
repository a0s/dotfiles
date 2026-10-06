# dotfiles

My macOS shell and terminal setup, shared between several machines.

Only general, non-sensitive configuration lives here. Anything tied to one
machine — work clusters, private paths, development checkouts — stays local
and never reaches this repository.

## How it works

The repository is a **bare Git repo** in `~/.dotfiles` whose work tree is
`$HOME` itself. Files stay where programs expect them; there are no symlinks
and no install script.

```zsh
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

dotfiles status            # only tracked files are shown
dotfiles add ~/.zshrc.d/45-krew.zsh
dotfiles commit -m "..."
dotfiles push
```

Git only sees files that were added explicitly, so the rest of the home
directory is invisible to it.

## What's inside

```
~/
├── .zshrc                    loader: sources ~/.zshrc.d/*.zsh in order
├── .zshrc.d/
│   ├── 10-history.zsh        large shared history
│   ├── 20-ls.zsh             colored ls aliases, lesspipe
│   ├── 30-completion.zsh     zsh-completions, menu selection
│   ├── 40-pyenv.zsh
│   ├── 41-starship.zsh
│   ├── 42-direnv.zsh
│   ├── 43-iterm.zsh          per-directory iTerm2 color preset via direnv
│   ├── 45-krew.zsh
│   ├── 50-locale.zsh
│   ├── 60-git.zsh            dotfiles, gpr, wtcd
│   ├── 61-git-config.zsh     git colors and aliases
│   ├── 62-tofu.zsh           OpenTofu aliases
│   ├── 70-smartcat.zsh       only if smartcat is installed
│   └── 99-cmux.zsh           agent-monitor autostart in the cmux Dock
├── .direnvrc                 export_alias, export_function, iterm_theme
└── .config/
    ├── starship.toml         prompt + catppuccin and gruvbox palettes
    └── cmux/
        ├── cmux.json         appearance, sidebar, workspace colors
        ├── dock.json         agent-monitor in the Dock
        └── bin/
            ├── cmux-follow                    keep a Dock command in the focused pane's directory
            └── agent-monitor-dock-autostart   relaunch agent-monitor after a cmux restart
```

## Shared vs. machine-local

Each machine adds its own pieces next to the shared ones, and Git is told to
ignore them via `~/.dotfiles/info/exclude`:

```
.zshrc.d/*.local.zsh
.config/cmux/local/
```

| What | Where it goes |
|---|---|
| A shell setting every machine wants | `~/.zshrc.d/NN-name.zsh`, committed |
| A PATH tweak, dev checkout, work tool | `~/.zshrc.d/NN-name.local.zsh`, local only |
| cmux actions, workspaces, private shortcuts | `~/.config/cmux/local/cmux.pack.json`, loaded through `"packs": ["local"]`; a missing pack is simply skipped |

Fragments load in lexical order, so the number decides precedence. For
example, a development checkout is put on `PATH` by a `65-*.local.zsh`
fragment so that `70-smartcat.zsh` already initializes the dev build.

### Different prompt color per machine

`starship.toml` uses `catppuccin_frappe` by default. To make another host
recognisable at a glance, a local fragment renders a copy with a different
palette:

```zsh
# ~/.zshrc.d/92-starship-palette.local.zsh
_starship_palette=gruvbox_dark
_starship_local=~/.cache/starship-$_starship_palette.toml
if [[ ! -e $_starship_local || ~/.config/starship.toml -nt $_starship_local ]]; then
  mkdir -p ~/.cache
  sed "s/^palette = .*/palette = '$_starship_palette'/" ~/.config/starship.toml > $_starship_local
fi
export STARSHIP_CONFIG=$_starship_local
unset _starship_palette _starship_local
```

## Setting up a new machine

```zsh
brew install starship direnv pyenv zsh-completions lesspipe
brew install kubectl krew opentofu           # optional
brew install a0s/agent-monitor/agent-monitor # optional, with cmux

git clone --bare git@github.com:a0s/dotfiles.git ~/.dotfiles
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

dotfiles config status.showUntrackedFiles no
dotfiles config remote.origin.fetch '+refs/heads/*:refs/remotes/origin/*'
printf '%s\n' '.zshrc.d/*.local.zsh' '.config/cmux/local/' >> ~/.dotfiles/info/exclude

# keep this README out of $HOME
dotfiles config core.sparseCheckout true
printf '%s\n' '/*' '!/README.md' > ~/.dotfiles/info/sparse-checkout

# move aside every file the checkout would replace
dotfiles ls-tree -r --name-only HEAD | while read -r f; do
  if [ -e ~/"$f" ]; then
    mkdir -p ~/.dotfiles-backup/"$(dirname "$f")"
    mv ~/"$f" ~/.dotfiles-backup/"$f"
  fi
done

dotfiles checkout
```

> **Back up first.** A fresh bare clone has no index, and recent Git then
> overwrites existing files on `checkout` with only a warning, so the loop
> above is what keeps your old configs in `~/.dotfiles-backup`.

Then move whatever was machine-specific in the old configs into
`*.local.zsh` fragments and open a new shell.
