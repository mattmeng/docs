---
title: Cool Shortcuts
authors:
  - name: Matt Meng
    email: matt.meng@intel.com
layout: page
---

The following commands an aliases can be used enhance your use of Git.  Aliases can be added to your `~/.gitconfig` file for use.

## Managing Branches

<dl>
  <dt>Alias: <code>nb = !sh -c 'git checkout -b $1 && git push -u origin $1' -</code></dt>
  <dd>Creates a new branch locally and remotely and checks it out.</dd>
  <dt>Alias: <code>db = !sh -c 'git branch -D $@ && git push --delete origin $@' -</code></dt>
  <dd>Deletes a branch locally and remotely.  Make sure to be on a different branch before issuing the command (because you can't delete the branch you are on).</dd>
</dl>

## Logs

<dl>
  <dt><code>git log --graph --decorate=full --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset  %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=short</code></dt>
  <dd>Shows a graphical representation of the history of the current branch.</dd>
  <dt><code>git log --no-merges --first-parent</code></dt>
  <dd>Shows just the commits to the current branch.  However, the history goes on beyond when the branch was created.</dd>
</dl>

## Submodules
Ever wonder what commit the submodules on you current branch are at? Here are two git aliases that you can add to your `.gitconfig` that will help with that. Simply use `git sc` or `git scd` (if HEAD is detached, and not on a branch), and you'll see what commits your submodules are at.

```
sc = !git ls-tree -r $( git branch | awk '{print $2}') | grep ^160000 | awk {'"'"'printf (\"%5s\\t%s\\n\", $4, $3)'"'"'}
```

```
scd = !git ls-tree -r $( git branch | awk '{print $5}' | sed s'/.$//') | grep ^160000 | awk {'"'"'printf (\"%5s\\t%s\\n\", $4, $3)'"'"'}
```
