#!/bin/sh
function finish {
   cp ~/.gitconfigbak ~/.gitconfig # restore git config
   rm ~/.gitconfigbak
}
trap finish EXIT
cp ~/.gitconfig ~/.gitconfigbak # save git config

source ../bashunit/bashunit.sh
standardout=false

git config --global --remove-section bulkworkspaces

# test wrong GIT commands
assertContains "bash git-bulk.sh --addworkspac carriertech /Users/niklasschlimm/workspaces/carriertech" "unknown"
assertContains "bash git-bulk.sh wedfwe wefwefwf" "unknown GIT"
assertContains "bash git-bulk.sh wefwefwf" "unknown GIT"
assertContains "bash git-bulk.sh -h" "unknown argument"
assertContains "bash git-bulk.sh --h" "unknown argument"

# test worng usage of options and argument count
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
assertContains "bash git-bulk.sh -w -g personal status -s" "unknown workspace"

# test correct workspace administration
assertCheckContains "bash git-bulk.sh --addworkspace testws1 bla" "git config --global --get-regexp bulkworkspaces" "bla"
assertCheckContains "bash git-bulk.sh --addworkspace testws2 blub" "git config --global --get-regexp bulkworkspaces" "blub"
assertCheckNotContains "bash git-bulk.sh --removeworkspace testws1" "git config --global --get-regexp bulkworkspaces" "testws1"
assertCheckContains "bash git-bulk.sh --addcurrent testws" "git config --global --get-regexp bulkworkspaces" "testws"

# correct git command
assertContains "bash git-bulk.sh status -s" "executing"
assertContains "bash git-bulk.sh -a status -s" "executing"

# tests with bulk commands on workspaces
git config --global bulkworkspaces.testws1 "~/workspaces/personal"
git config --global bulkworkspaces.testws2 "~/workspaces/community"
assertContains "bash git-bulk.sh -w testws2 status -s" "workspaces/community"
assertContains "bash git-bulk.sh -a status -s" "workspaces/personal"
assertContains "bash git-bulk.sh status -s" "workspaces/personal"
assertContains "bash git-bulk.sh -a status -s" "workspaces/community"
assertContains "bash git-bulk.sh -w testws2 -a" "incompatible"
cd ..
assertContains "bash git-bulk/git-bulk.sh status -s" "you are not"
cd git-bulk/
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

