#!/bin/sh
function finish {
   cp ~/.gitconfigbak ~/.gitconfig # restore git config
}
trap finish EXIT
cp ~/.gitconfig ~/.gitconfigbak # save git config

source ../bashunit/bashunit.sh
standardout=true

source git-bulk.sh &>/dev/null

git config --global --remove-section bulkworkspaces &>/dev/null

# unit test checkWSName

# check if s´wsname detection works when in subdirectory of ws
upperdir=$(cd .. && pwd)
git config --global bulkworkspaces.testws "$upperdir"
assertCheckContains "wsnameToCurrent" 'echo $wsname' "testws" 
git config --global --remove-section bulkworkspaces

# check is error is displayed when not in a ws directory
(
cd ~
assertContains "wsnameToCurrent" "your workspaces"
)

cp ~/.gitconfigbak ~/.gitconfig # restore git config