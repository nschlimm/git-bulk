#!/bin/sh
source ./bashunit.sh

cp ~/.gitconfig ~/.gitconfigbak # save git config

git config --global --remove-section bulkworkspaces

# test wrong commands
assert "bash git-bulk.sh --addworkspac carriertech /Users/niklasschlimm/workspaces/carriertech" "unknown"
assert "bash git-bulk.sh wedfwe wefwefwf" "unknown GIT"
assert "bash git-bulk.sh wefwefwf" "unknown GIT"
assert "bash git-bulk.sh -h" "unknown argument"
assert "bash git-bulk.sh --h" "unknown argument"

# test too many arguments
assert "bash git-bulk.sh --addworkspace bla carriertech /Users/niklasschlimm/workspaces/carriertech" "wrong number"
assert "bash git-bulk.sh --addworkspace bla" "wrong number"
assert "bash git-bulk.sh --addworkspace" "wrong number"
assert "bash git-bulk.sh --addworkspace carriertech /Users/niklasschlimm/workspaces/carriertech xqsxq" "wrong number"
assert "bash git-bulk.sh --removeworkspace bla carriertech" "wrong number"
assert "bash git-bulk.sh --removeworkspace" "wrong number"
assert "bash git-bulk.sh --removeworkspace carriertech /Users/niklasschlimm/workspaces/carriertech xqsxq" "wrong number"
assert "bash git-bulk.sh --addcurrent bla carriertech" "wrong number"
assert "bash git-bulk.sh --addcurrent" "wrong number"
assert "bash git-bulk.sh --addcurrent carriertech /Users/niklasschlimm/workspaces/carriertech xqsxq" "wrong number"
assert "bash git-bulk.sh --listall carriertech" "wrong number"
assert "bash git-bulk.sh --purge carriertech" "wrong number"
assert "bash git-bulk.sh -g -h ss ss" "unknown argument"
assert "bash git-bulk.sh -g --listall" "wrong number"
assert "bash git-bulk.sh --bla" "unknown argument"

# test correct
assert_with "bash git-bulk.sh --addworkspace testws bla" "git config --global --get-regexp bulkworkspaces" "bla"
assert_with_not "bash git-bulk.sh --removeworkspace testws" "git config --global --get-regexp bulkworkspaces" "testws"
assert_with "bash git-bulk.sh --addcurrent testws" "git config --global --get-regexp bulkworkspaces" "testws"

# correct git command
assert "bash git-bulk.sh status -s" "executing"

# test correct listing of repos
git config --global bulkworkspaces.testws "testdir"
assert "bash git-bulk.sh --listall" "testws"
git config --global --remove-section bulkworkspaces

# test purge success
git config --global bulkworkspaces.testws "testdir"
assert "git config --global --get-regexp bulkworkspaces" "testws"
assert_with "bash git-bulk.sh --purge" "git config --global --get-regexp bulkworkspaces" "^$"

testend "git bulk tests"

cp ~/.gitconfigbak ~/.gitconfig # restore git config

