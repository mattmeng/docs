---
title: Stories for Working with the Repository
authors:
  - name: Matt Meng
    email: matt.meng@intel.com
layout: page
---

This document describes several stories in an attempt to help Developers and Release Managers effectively manage their code and standardize our use of branching and working with the repository.

## Caveats

* Before every action, make sure all the appropriate branches are up to date and in sync with the remote.
* Create two aliases in your Git config file (`~/.gitconfig` on Linux and Mac OS X, `%HOMEPATH%/.gitconfig` on Windows).  Place this under the `[alias]` section:
  * `nb = !sh -c 'git checkout -b $1 && git push -u origin $1' -`
  * `db = !sh -c 'git branch -D $1 && git push --delete origin $1' -`

## Terminology

<dl>
  <dt>&lt;required_value&gt;</dt>
  <dd>A required value, usually specified in a previous instruction.</dd>
  <dt>[optional_value]</dt>
  <dd>An optional value, usually specified in a previous instruction.</dd>
</dl>

## Naming Conventions

<dl>
  <dt>master/&lt;x.y&gt;</dt>
  <dd>Master branches are namespaced simply with the version, (e.g. `master/9.5`).  These always represent the latest version of that release.</dd>
  <dt>development</dt>
  <dd>The development branch always represents the next major release.</dd>
  <dt>topic/&lt;branch_name&gt;</dt>
  <dd>A topic branch is used for story work.  It can only come off of and merge back into development.</dd>
  <dt>patch/&lt;x.y&gt;/development</dt>
  <dd>The patch development branch is used to integrate all patch bug fixes into a single place for testing and development.</dd>
  <dt>patch/&lt;x.y&gt;/&lt;branch_name&gt;</dt>
  <dd>A patch branch represents a fix to a bug that exists in released code.</dd>
  <dt>release/&lt;x.y.z[_MRa]&gt;</dt>
  <dd>A release branch represents a releasable increment.  They are namespaced using the version and can optionally include a maintenance release number preceded by an underscore. Release branches are code frozen, so reviews are required to submit commits to them.</dd>
</dl>

## Story Summary

* [Development](#development)
  * Developer Stories
    * [I have a topic branch that should go into the next major release for x.y.z.](#story_1)
    * [I need to apply a fix to code that has been captured in a release branch (code freeze).](#story_2)
  * Release Manager Stories
    * [Every 2nd Monday, a new major version may need to be prepared for release and I need to initiate a code freeze so that we can test and verify.](#story_3)
    * [Every 3rd Wednesday, we may release a new major version and I need to finish the release branch.](#story_4)
* [Patches](#patches)
  * Developer Stories
    * [I have a bug fix that should go into the next maintenance release for x.y.z.](#story_5)
    * [I made a patch fix to one version and need to make the same fix in another version.](#story_6)
    * [I have a bug fix that needs to be released immediately for x.y.z.](#story_7)
    * [I need to apply a fix to code that has been captured in a release branch (code freeze).](#story_8)
  * Release Manager Stories
    * [Every 2nd Monday, a new MR needs to be released and I need to initiate a code freeze so that we can test and verify.](#story_9)
    * [Every 3rd Wednesday, we will release a new maintenance release and I need to finish the release branch.](#story_10)
    * [We need to make an emergency maintenance release for a major bug.](#story_11)
* [Common Tasks](#common-tasks)
  * [Create a Merge Request in Gitlab](#create-a-merge-request-in-gitlab)
  * [Close a Merge Request in Gitlab](#close-a-merge-request-in-gitlab)
  * [Cherry-pick a Fix onto a Target Branch](#cherry-pick-a-fix-onto-a-target-branch)
  * [Protect a Branch](#protect-a-branch)
* [Submodule Basics](#submodule-basics)

## Development

<a id='story_1'></a>
**Developer Story:** I have a topic branch that should go into the next major release for x.y.z.  *For this example, we'll say __9.5.1__ and the story is __123456__.*

*Create a new branch and work on it:*

![Create a new branch and work on it](/files/dev_1.png)


1. Topic branches should be based off of the development branch: `git checkout development`
2. Create a new topic branch: `git nb topic/123456`
3. Make fixes and push up new commits.

*Regularly merge down changes from development:*

![Regularly merge down changes from development](/files/dev_2.png)

1. Checkout the topic branch: `git checkout topic/123456`
2. Merge development into the topic branch: `git merge development`
3. Fix any conflicts and push up the changes.

*When you're done and the topic is tested and good:*

![When you're done and the topic is tested and good](/files/dev_3.png)

1. Checkout the topic branch: `git checkout topic/123456`
2. Merge in changes from the development branch: `git merge development`
3. Fix any conflicts.
4. Checkout the development branch: `git checkout development`
5. Merge in the changes from your topic branch: `git merge topic/123456`
6. Delete the branch: `git db topic/123456`

---

<a id='story_2'></a>
**Developer Story:** I need to apply a fix to code that has been captured in a release branch (code freeze).  *For this example, we'll use __9.5.1__ and the bug is __654321__.*

*At this point, there will be a release branch corrosponding to the appropriate version.*

![At this point, there will be a release branch corrosponding to the appropriate version.](/files/dev_4.png)

1. Checkout the release branch: `git checkout release/9.5.1`
2. Create a new topic branch: `git nb topic/654321`
3. Make fixes only for regression issues.
4. Commit and push your fixes.

*Merge those fixes into the development and release branches:*

![Merge those fixes into the development and release branches](/files/dev_5.png)

1. Create a merge request in Gitlab using `topic/654321` as the source, `release/9.5.1` as the target and your **Scrum Master** as the assignee. (See [Create a Merge Request in Gitlab](#create-a-merge-request-in-gitlab))
2. Checkout the development branch: `git checkout development`
3. Merge the fixes from your topic branch: `git merge topic/654321`
4. Resolve any conflicts and push up the changes.
5. Delete your local branch: `git branch -D topic/654321`

---

<a id='story_3'></a>
**Release Manager Story:** Every 2nd Monday, a new major version may need to be prepared for release and I need to initiate a code freeze so that we can test and verify.  *For this example, we'll use __9.5.1__.*

*Create a new release branch and protect it:*

![Create a new release branch and protect it](/files/dev_6.png)

1. Checkout the development branch: `git checkout development`
2. Create a new release branch: `git nb release/9.5.1`
3. Protect the branch on Gitlab and do not allow `Developers` to push.  (See [Protect a Branch](#protect-a-branch))

*Document all fixes included in the new release:*

1. Move any unfinished dependencies in the release's dependency tree to a future release.
2. Note the finished dependencies and email them out to Core Engineering.  Any problem that affects these bugs are considered regressions and must be fixed in the new release branch.

---

<a id='story_4'></a>
**Release Manager Story:** Every 3rd Wednesday, we may release a new major version and I need to finish the release branch.  *For this example, we'll use __9.5.1__.*

*If this is a release for an already existing line (e.g. master/9.5 exists and the new version is 9.5.1), merge the release branch into the existing master branch:*

![Existing Line](/files/dev_7.png)

1. Checkout the development branch: `git checkout development`
2. Merge the release branch into the development branch: `git merge release/9.5.1`
3. Checkout the appropriate master branch: `git checkout master/9.5`
4. Merge the release branch into the master branch: `git merge release/9.5.1`
5. Create a tag at the new commit: `git tag 9.5.1`
6. Push up the new commit and tag: `git push --tags origin master/9.5`
7. Delete the release branch: `git db release/9.5.1`

*If this is a release for a new line (e.g. the new version is 9.6.0 and no master/9.6 exists), create a new master line and merge the release branch into it:*

![New Line](/files/dev_8.png)

1. Checkout the development branch: `git checkout development`
2. Merge the release branch into the development branch: `git merge release/9.6.0`
3. Checkout the newest master branch: `git checkout master/9.5`
4. Create a new master branch: `git nb master/9.6`
5. Merge the release branch into the master branch: `git merge release/9.6.0`
6. Create a tag at the new commit: `git tag 9.6.0`
7. Push up the new commit and tag: `git push --tags origin master/9.6`
8. Protect the new master branch and do not allow `Developers` to push to it. (See [Protect a Branch](#protect-a-branch))
9. Delete the release branch: `git db release/9.6.0`

## Patches

<a id='story_5'></a>
**Developer Story:** I have a bug fix that should go into the next maintenance release for x.y.z. *For this example, we'll say __9.5.0__ and the bug is __123456__.*

*Create a new branch and work on it:*

![Create a new branch and work on it](/files/patch_1.png)

1. These patch branches should be based off of the appropriate patch development branch: `git checkout patch/9.5/development`
2. Create a new patch branch: `git nb patch/9.5/123456`
3. Make fixes and push up new commits.
4. For each fix, `cherry-pick` it if it needs to be applied to another version.  (See [Cherry-pick a Fix onto a Target Branch](#cherry-pick-a-fix-onto-a-target-branch).

*When you're done and the fix is tested and good:*

![When you're done and the fix is tested and good](/files/patch_2.png)

1. Checkout the patch branch: `git checkout patch/9.5/123456`
2. Merge in changes from the patch development branch: `git merge patch/9.5/development`
3. Fix any conflicts.
4. Checkout the patch development branch: `git checkout patch/9.5/development`
5. Merge in the changes from your patch branch: `git merge patch/9.5/123456`
6. Delete the patch branch: `git db patch/9.5/123456`

---

<a id='story_6'></a>
**Developer Story:** I made a patch fix to one version and need to make the same fix in another version.  *For this story, `patch/9.5/123456` contains the fix we want and `development` is where we want it to go.*

*Get the SHA for the commit you want to copy and cherry-pick it onto the target branch:*

![Get the SHA for the commit you want to copy and cherry-pick it onto the target branch](/files/patch_3.png)

1. Find the SHA of the commit in question: `git log patch/9.5/123456`
2. Let's say the commit in question is `1a2b3c4` (Only the first 7 chars are needed).
3. Cherry-pick using `development` as the target branch and `1a2b3c4` as the commit SHA.  (See [Cherry-pick a Fix onto a Target Branch](#cherry-pick-a-fix-onto-a-target-branch))

---

<a id='story_7'></a>
**Developer Story:** I have a bug fix that needs to be released immediately for x.y.z.  *For this example, we'll say __9.5.0__ and the bug is __456789__.*

*Create a new branch and work on it:*

![Create a new branch and work on it](/files/patch_4.png)

1. These patch branches should be based off of the appropriate master branch: `git checkout master/9.5`
2. Create a new patch branch: `git nb patch/9.5/456789`
3. Make fixes and push up new commits.
4. For each fix, `cherry-pick` it if it needs to be applied to another version.  (See [Cherry-pick a Fix onto a Target Branch](#cherry-pick-a-fix-onto-a-target-branch).

*When you're done and the fix is tested and good:*

![When you're done and the fix is tested and good](/files/patch_5.png)

1. Create a merge request in Gitlab using `patch/9.5/456789` as the source, `master/9.5` as the target and **Adam Hanny** as the assignee. (See [Create a Merge Request in Gitlab](#create-a-merge-request-in-gitlab))
2. Checkout the appropriate patch development branch: `git checkout patch/9.5/development`
3. Merge your patch branch into the patch development branch: `git merge patch/9.5/456789`
4. Delete your local branch: `git branch -D patch/9.5/456789`

---

<a id='story_8'></a>
**Developer Story:** I need to apply a fix to code that has been captured in a release branch (code freeze).  *For this example, we'll use __9.5.0 MR5__ and the bug is __654321__.*

*At this point, there will be a release branch corrosponding to the appropriate version.*

![At this point, there will be a release branch corrosponding to the appropriate version.](/files/patch_6.png)

1. Checkout the release branch: `git checkout release/9.5.0_MR5`
2. Create a new branch: `git nb patch/9.5/654321`
3. Make fixes only for regression issues.
4. Commit and push your fixes.

*Merge those fixes into the patch development and release branches:*

![Merge those fixes into the patch development and release branches](/files/patch_7.png)

1. Create a merge request in Gitlab using `patch/9.5/654321` as the source, `release/9.5.0_MR5` as the target and **Adam Hanny** as the assignee. (See [Create a Merge Request in Gitlab](#create-a-merge-request-in-gitlab))
2. Checkout the appropriate patch development branch: `git checkout patch/9.5/development`
3. Merge the fixes from your patch branch: `git merge patch/9.5/654321`
4. Resolve any conflicts and push up the changes.
5. Delete your local branch: `git branch -D patch/9.5/654321`

---

<a id='story_9'></a>
**Release Manager Story:** Every 2nd Monday, a new MR needs to be released and I need to initiate a code freeze so that we can test and verify.  *For this example, we'll use __9.5.0 MR5__.*

*Create a new release branch and protect it:*

![Create a new release branch and protect it](/files/patch_8.png)

1. Checkout the appropriate patch development branch: `git checkout patch/9.5/development`
2. Create a new release branch: `git nb release/9.5.0_MR5`
3. Protect the branch on Gitlab and do not allow `Developers` to push.  (See [Protect a Branch](#protect-a-branch))

*Document all fixes included in the new release:*

1. Move any unfinished dependencies in the release's dependency tree to a future release.
2. Note the finished dependencies and email them out to Core Engineering.  Any problem that affects these bugs are considered regressions and must be fixed in the new release branch.

---

<a id='story_10'></a>
**Release Manager Story:** Every 3rd Wednesday, we will release a new maintenance release and I need to finish the release branch.  *For this example, we'll use __9.5.0 MR5__.*

*Merge the release back into the patch development branch and the master branch:*

![Merge the release back into the patch development branch and the master branch](/files/patch_10.png)

1. Checkout the patch development branch: `git checkout patch/9.5/development`
2. Merge the release branch into the patch development branch: `git merge release/9.5.0_MR5`
3. Checkout the appropriate master branch: `git checkout master/9.5`
4. Merge the release branch into the master branch: `git merge release/9.5.0_MR5`
5. Create a tag at the new commit: `git tag 9.5.0_MR5`
6. Push up the new commit and tag: `git push --tags origin master/9.5`
7. Delete the branch: `git db release/9.5.0_MR5`

---

<a id='story_11'></a>
**Release Manager Story:** We need to make an emergency maintenance release for a major bug.  *For this example, we'll use __9.5.0 MR6__ and the bug is __456789__.*

*Review the merge request submitted by the developer:*

1. Review the merge request using the first few steps in [Close a Merge Request in Gitlab](#close-a-merge-request-in-gitlab).
2. Validate that the source branch is the appropriate patch branch.
3. Validate that the target branch is the appropriate master branch.
4. Before closing the request, validate with the developer that the fixes have been merged into development.
5. Close the merge request submitted by the developer.  (See [Close a Merge Request in Gitlab](#close-a-merge-request-in-gitlab))

*Tag the new commit:*

![Tag the new commit](/files/patch_11.png)

1. Checkout the appropriate master branch: `git checkout master/9.5`
2. Pull down the new changes: `git pull`
3. Create a tag at the new commit: `git tag 9.5.0_MR6`
4. Push up the new tag: `git push --tags`

## Common Tasks

### Create a Merge Request in Gitlab

1. Go to https://git.ida.lab/core/core in a web browser.
2. One the left nav bar, click **Merge Requests**.
3. Click **New Merge Request**.
4. Select the source branch (the branch that contains the changes you want).
5. Select the target branch (the branch that you want the changes to go to).
6. Click **Compare branches**.
7. Assign the request.
8. Review the changes and **Submit new merge request**.

### Close a Merge Request in Gitlab

1. Go to https://git.ida.lab/core/core in a web browser.
2. One the left nav bar, click **Merge Requests**.
3. Select the Merge Request you want to work on.
4. Review the source and target branches.
5. If they are wrong, edit the merge request and change them to the appropriate branches.
6. With other experts in the affected code, review the commits and changes introduced by the request.
7. Comment on any questionable or unclear lines of code. Gitlab should notify those watching the request that a comment has been submitted.
8. If there are any problems, close the request.
9. If the request is acceptable Gitlab and is able to auto-merge it, check **Remove source-branch** and click *Accept Merge Request*.
10. If Gitlab is unable to auto-merge it, return it to the author to fix the conflicts.  They should then update the merge request (by pushing up the conflict resolutions) and reassign it to you.

### Cherry-pick a Fix onto a Target Branch

1. Checkout the branch the fix needs to go into (the target branch): `git checkout <target_branch>`
2. Cherry-pick the commit without committing (so you can review the changes): `git cherry-pick --no-commit <sha_for_fix>`
3. Review the staged changes: `git diff --staged`
4. Fix anything wrong if necessary.
5. Commit the changes and push them up.

### Protect a Branch

This can only be done by a `Master`.

1. Go to https://git.ida.lab/core/core in a web browser.
2. Click on **Settings** on the left nav bar.
3. Click on **Protected Branches**.
4. Select the branch you want to protect.
5. If you would like to allow `Developers` to push to this branch, check **Developers can push**.
6. Click **Protect**.

## Submodule Basics

### Great News!
One of the benefits of working with a technology like git is that it is widely used and supported. This means that it is easy to find great support and answers about any questions you may have on the internet. Google is your friend. That being said, here is a compilation of a few sources that should help you master git submodules.

### Adding, Using, Removing and Updating Submodules
An overview of basic git submodule actions can be found [here](https://chrisjean.com/git-submodules-adding-using-removing-and-updating/).

### Getting `reference is not a tree` error?
Try this:
* `git submodule sync`
* `git submodule update`
