#!/bin/sh
source ../bashunit/bashunit.sh
standardout=false

cp ~/.gitconfig ~/.gitconfigbak # save git config

git config --global --remove-section bulkworkspaces

# test wrong commands
assertContains "bash git-bulk.sh --addworkspac carriertech /Users/niklasschlimm/workspaces/carriertech" "unknown"
assertContains "bash git-bulk.sh wedfwe wefwefwf" "unknown GIT"
assertContains "bash git-bulk.sh wefwefwf" "unknown GIT"
assertContains "bash git-bulk.sh -h" "unknown argument"
assertContains "bash git-bulk.sh --h" "unknown argument"

# test too many arguments
assertContains "bash git-bulk.sh --addworkspace bla carriertech /Users/niklasschlimm/workspaces/carriertech" "wrong number"
assertContains "bash git-bulk.sh --addworkspace bla" "wrong number"
assertContains "bash git-bulk.sh --addworkspace" "wrong number"
assertContains "bash git-bulk.sh --addworkspace carriertech /Users/niklasschlimm/workspaces/carriertech xqsxq" "wrong number"
assertContains "bash git-bulk.sh --removeworkspace bla carriertech" "wrong number"
assertContains "bash git-bulk.sh --removeworkspace" "wrong number"
assertContains "bash git-bulk.sh --removeworkspace carriertech /Users/niklasschlimm/workspaces/carriertech xqsxq" "wrong number"
assertContains "bash git-bulk.sh --addcurrent bla carriertech" "wrong number"
assertContains "bash git-bulk.sh --addcurrent" "wrong number"
assertContains "bash git-bulk.sh --addcurrent carriertech /Users/niklasschlimm/workspaces/carriertech xqsxq" "wrong number"
assertContains "bash git-bulk.sh --listall carriertech" "wrong number"
assertContains "bash git-bulk.sh --purge carriertech" "wrong number"
assertContains "bash git-bulk.sh -g -h ss ss" "unknown argument"
assertContains "bash git-bulk.sh -g --listall" "wrong number"
assertContains "bash git-bulk.sh --bla" "unknown argument"

# test correct
assertCheckContains "bash git-bulk.sh --addworkspace testws bla" "git config --global --get-regexp bulkworkspaces" "bla"
assertCheckNotContains "bash git-bulk.sh --removeworkspace testws" "git config --global --get-regexp bulkworkspaces" "testws"
assertCheckContains "bash git-bulk.sh --addcurrent testws" "git config --global --get-regexp bulkworkspaces" "testws"

# correct git command
assertContains "bash git-bulk.sh status -s" "executing"

git config --global bulkworkspaces.testws "testdir"
assertContains "bash git-bulk.sh -w testws status -s" "Executing"
git config --global --remove-section bulkworkspaces
assertContains "bash git-bulk.sh -w persona status -s" "unknown workspace name"

# test correct listing of repos
git config --global bulkworkspaces.testws "testdir"
assertContains "bash git-bulk.sh --listall" "testws"
git config --global --remove-section bulkworkspaces

# test purge success
git config --global bulkworkspaces.testws "testdir"
assertContains "git config --global --get-regexp bulkworkspaces" "testws"
assertCheckContains "bash git-bulk.sh --purge" "git config --global --get-regexp bulkworkspaces" "^$"

testend "git bulk tests"

cp ~/.gitconfigbak ~/.gitconfig # restore git config

