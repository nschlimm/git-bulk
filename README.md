# git-bulk

`git bulk` adds covenien support for operations that you want to execute on multiple git repositories.

# features

* simply register workspaces that contain multiple git repos in their directory structure
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

1. get the `git-bulk.sh`
2. create symlink like `ln -s <path to script>/git-bulk.sh /usr/local/bin/git-bulk`
3. make the git-bulk.sh script executable with `chmod -u+x <path to script>/git-bulk.sh`

# samples

Register a workspace so that `git bulk` knows about it:

```bash
$ git bulk --addworkspace personal ~/workspaces/personal
```

Register the current directory as a workspace to `git bulk`

```bash
$ git bulk --addcurrent personal
```

List all registered workspaces:

```bash
$ git bulk --listall
bulkworkspaces.personal /Users/niklasschlimm/workspaces/personal
```

Run a git command on the repositories:

```bash
$ git bulk fetch
```

![fetchdemo](https://cloud.githubusercontent.com/assets/876604/23709805/e8178406-041a-11e7-9a0c-01de5fbf8944.png)

Remove a registered workspaces:

```bash
$ git bulk --removeworkspace personal
```
Remove all registered workspaces:

```bash
$ git bulk --purge
```
