# Source Control Documentation

## Roles <a name="roles" />

---

### Contributor <a name="roles-contributor" />

The contributor role represents an individual contributor, a developer who will make changes to source, but does not necessarily have write privileges to the repository to which he or she contributes. The majority of developers will fit this category. Contributors are responsible for executing stories and completing all definition-of-done criteria.

#### Stories <a name="roles-contributor-stories" />

##### Obtaining a copy of a Github Repository <a name="roles-contributor-stories-clone" />

**As a contributor, I want to clone a repository so I can work on code on my local machine.**

1. Browse to the repository on github.intel.com
2. Find the clone url in the right column
3. In a terminal, change to the directory where you want the repository to be located (this will be the PARENT directory of the repository)
4. Execute the following: `git clone <clone url>`
5. The repository is now cloned locally in a subdirectory with the same name as the repository

##### Updating a local repository <a name="roles-contributor-stories-pull" />

**As a contributor, I want to include the latest changes to a github repository in my local copy**

1. In a terminal, make sure the current working directory is inside the working copy of your git repository
2. Stash any local changes by executing `git stash`, or throw them away by executing `git reset --hard`
3. Execute `git pull --rebase`
4. If there are merge conflicts, do the following:
  1. Resolve merge conflicts using a tool of your choice (we recommend a text editor)
  2. Execute `git add <resolved_file_1 [resolved_file_2 [...]]>`
  3. Execute `git commit -m "<merge message>"`
5. If applicable and desired, re-apply local changes stashed in step 2 by executing `git stash pop`

##### Submitting Changes to a Github Repository <a name="roles-contributor-stories-push" />

**As a contributor, I want to submit my changes to the github repository**

1. Commit to local repository
  1. Make changes to one or more files locally
  2. Execute `git add <file1 [file 2 ...]>` to mark changed files as ready to commit
  3. Execute `git diff --staged` to review what changes are marked for committing
  4. Execute `git commit -m <message>` to commit these changes with a given message. Omitting the "`-m <message>" portion will open an editor for writing a commit message. We recommend following these [best practices](http://chris.beams.io/posts/git-commit).
2. Push changes to remote repository (Github)
  1. Execute `git push` to push changes in your local repository to the remote repository
  2. If `git push` fails, try the following:
    - Verify you have rights to push to the remote repository
    - Verify that your local repository is up-to-date (see the section on [updating a repository](#roles-contributor-stories-pull)) and then retry.

##### Forking a Repository <a name="roles-contributor-stories-fork" />

**As a contributor, I want to fork a repository to track my individual/team changes, so we can modify a repository without affecting the production repository**

1. Navigate to the production repository at github.intel.com
2. Note the clone URL in the right column for use in step 8
3. Click on the "Fork" button in the upper right corner of the project page
4. Select your username when it prompts "Where should we fork this repository"
5. Github will automatically navigate to the new forked repository, to which you have all rights
6. Clone a local copy of the forked repository (see [Obtaining a copy of a Github Repository](#roles-contributor-stories-clone))
7. In a terminal, make sure the current working directory is inside the local copy of the fork
8. Execute `git remote add upstream <clone url of upstream repository from step 2>`

##### Updating a Fork <a name="roles-contributor-stories-update-fork" />

**As a contributor, I want to include changes from the upstream repository in my fork**
1. In a terminal, make sure the current working directory is inside the local copy of the fork
2. Stash any local changes
3. Check out the branch that you will update from upstream by executing `git checkout <branch>`
4. Execute `git fetch upstream` (this assumes you have added a remote called "upstream" pointing to the upstream repository as described in [Forking a Repository](#roles-contributor-stories-fork))
5. Execute `git rebase upstream/<branch>`
6. If there are any merge conflicts, resolve them and commit the changes
7. Execute `git push` to push these changes to your fork on github

##### Submitting a Pull Request <a name="roles-contributor-stories-pull-request" />

**As a contributor, I want changes made in my fork to be incorporated into the upstream repository**

1. Make sure your fork is up-to-date with the upstream repository (see [Updating a Fork](#roles-contributor-stories-update-fork))
2. Navigate to your forked repository on github.intel.com
3. Click the link called "Pull request", which is above the list of files, on the right side of the main body column
4. Select the upstream repository as the Base Fork
5. Select the branch in the upstream that should receive the changes as the Base branch. Unless special circumstances warrant it, this should**always**be master
6. Select your forked repository as the Head Fork
7. Select the branch containing your changes as the Compare branch.
8. Review the changes.
9. If everything looks right, click "Create pull request"
10. Leave any special instructions or comments in the "Leave a Comment" section and click "Create Pull Request". Also, leave detailed justification for how the definition of done has been met for the proposed changes.

##### Updating a Submodule <a name="roles-contributor-stories-update-submodule" />

**As a contributor, I want to use newer commits of repositories I include as submodules, so I can have up-to-date dependencies**

1. Finish writing this section
2. Do the things in this section once they are written

##### Building a Fork <a name="roles-contributor-stories-build" />

**As a contributor, I want to build my fork so that I can test, demo and release it**

A fork is a fully functional repository, so it will be built the same way as [building the main project](#roles-maintainer-stories-build).

---

### Maintainer <a name="roles-maintainer">

The maintainer role represents developers and others with decision-making authority who have write access to the production repositories. They are responsible for making sure that nothing is accepted into the repositories that does not meet the definiton of done.

#### Stories <a name="roles-maintainer-stories" />

##### Building SIEM <a name="roles-maintainer-stories-build" />

**As a maintainer, I want to build my project so that I can test, demo and release it**

1. If your project does not have a build configuration in TeamCity, work with the DevOps team to create one
2. Navigate to https://tc01s-or.devtools.intel.com/. You may need to request access if you have never done so before
3. A list of projects will be displayed. Select the project you wish to build and press the associated 'run' button
4. Access any desired artifacts (such as ISOs and logs) inthe "artifacts" drop-down of the build

##### Accepting Pull Requests <a name="roles-maintainer-stories-pull-request" />

**As a maintainer, I need to integrate changes from contributors into the production repository**

1. Navigate to the pending pull request
  1. Navigate to the repository on github.intel.com
  2. Click "Pull requests" on the right column
  3. Select the desired pull request
2. Review the changes.
  1. If the repository is tied to continuous integration, verify that all tests pass
  2. Review code changes
    1. Make sure that only changes that the contributor is claim to have made are included
    2. If you are a technical expert for the repository, review the changes for completeness, correctness and best practices. If you are not, find a technical expert to do this for you
    3. Make sure the contributor has documented how the definition of done was satisfied in the comments section
    4. Check the comments for any special instructions about the merge.
    5. Verify that the pull request is targeting the correct branch. This should be master unless very specific circumstances dictate otherwise
3. Make a decision about what to do with the pull request. There are three options:
  1. Accept the pull request.
    1. Click "Merge pull request"
    2. Leave a comment justifying the acceptance of the pull request.
    3. Click "Confirm merge"
  2. Leave comments for the contributor in the comment section at the bottom of the pull request, indicating further work that must be done. The contributor will be notified and can take any applicable actions to make the pull request acceptable.
  3. Reject the pull request
    1. Leave a comment in the comment section explaining why the pull request is rejected.
    2. Click "Close pull request"

##### Releasing <a name="roles-maintainer-stories-releasing" />

**As a maintainer, I want to release my code and track what the state of the code was at release time**

1. [Build](#roles-maintainer-stories-build) the product from the proposed branch
2. Ensure all manual and automated tests are passing
3. Execute `git tag -a <tag name> -m <tag message>`
  - Tag name should be the version number of the release, such as 9.5.3
  - Tag message is like a commit message - specify the reason for tagging or the major features of the tag
4. Execute `git push --tags` to push your tags to github

##### Back-porting to pre-9.5.3 releases<a name="roles-maintainer-stories-releasing" />

**As a maintainer, I want to back-port a release that is not tracked in the new repositories**
