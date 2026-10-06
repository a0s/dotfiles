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
