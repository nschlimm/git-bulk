# git-bulk

`git bulk` adds covenien support for operations that you want to execute on multiple git repositories.

# features

* simply add workspaces that contain multiple git repos in their directory structure
* run any git command on the repositories of the registered workspaces in one command to `git bulk`
* use the "guarded mode" to check on each execution

# usage

usage: git bulk [-g] <git command>
       git bulk --addworkspace <ws-name> <ws-root-directory>
       git bulk --removeworkspace <ws-name> <ws-root-directory>
       git bulk --addcurrent <ws-name>
       git bulk --purge
       git bulk --listall
       
# installation

1) get the git-bulk.sh
2) create symlink like `ln -s <path to script>/git-bulk.sh /usr/local/bin/git-bulk`
3) make the git-bulk.sh script executable with `chmod -u+x <path to script>/git-bulk.sh`

# samples

Register a workspace so that `git bulk` knows about it:

`git bulk --addworkspace myworkspace ~/workspaces/myeclipseworkspace`

List all registered workspaces:

`git bulk --listall`

Run a git command on the repositories:

git bulk fetch

git bulk status -s

