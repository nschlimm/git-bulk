# git-bulk

`git bulk` adds covenien support for operations that you want to execute on multiple git repositories.

# features

* simply add workspaces that contain multiple git repos in their directory structure
* run any git command on the repositories of the registered workspaces in one command to `git bulk`
* use the "guarded mode" to check on each execution

# usage
```bash
usage: git bulk [-g] <git command>
       git bulk --addworkspace <ws-name> <ws-root-directory>
       git bulk --removeworkspace <ws-name> <ws-root-directory>
       git bulk --addcurrent <ws-name>
       git bulk --purge
       git bulk --listall
```

# installation

1. get the git-bulk.sh
2. create symlink like `ln -s <path to script>/git-bulk.sh /usr/local/bin/git-bulk`
3. make the git-bulk.sh script executable with `chmod -u+x <path to script>/git-bulk.sh`

# samples

Register a workspace so that `git bulk` knows about it:

```bash
$ git bulk --addworkspace personal ~/workspaces/personal
```

List all registered workspaces:

```bash
$ git bulk --listall
bulkworkspaces.personal /Users/niklasschlimm/workspaces/personal
```

Run a git command on the repositories:

```bash
$ git bulk fetch

Executing bulk operation in workspace /Users/niklasschlimm/workspaces/personal
Current repository: /Users/niklasschlimm/workspaces/personal/bashunit
-> executing git fetch
Current repository: /Users/niklasschlimm/workspaces/personal/git-bulk
-> executing git fetch
Current repository: /Users/niklasschlimm/workspaces/personal/shellscripts
-> executing git fetch
Current repository: /Users/niklasschlimm/workspaces/personal/supergitclient
-> executing git fetch
remote: Counting objects: 6, done.
remote: Compressing objects: 100% (6/6), done.
remote: Total 6 (delta 3), reused 0 (delta 0), pack-reused 0
Unpacking objects: 100% (6/6), done.
From github.com:nschlimm/supergitclient
   7f7e3bc..45bff06  master     -> origin/master
$
```

git bulk status -s

