#!/usr/bin/env sh
set -eu

sh -c "git config --global --add safe.directory $PWD"

/setup-ssh.sh

export GIT_SSH_COMMAND="ssh -v -i ~/.ssh/id_ed25519 -o StrictHostKeyChecking=no -l $INPUT_SSH_USERNAME"
git remote add mirror "$INPUT_TARGET_REPO_URL"

mkdir -p .$INPUT_TARGET_SUBDIRECTORY
mv * .$INPUT_TARGET_SUBDIRECTORY
mv .$INPUT_TARGET_SUBDIRECTORY $INPUT_TARGET_SUBDIRECTORY

git subtree push --prefix=$INPUT_TARGET_SUBDIRECTORY mirror main
#git push --tags --force --prune mirror "refs/remotes/origin/$INPUT_TARGET_SUBDIRECTORY/*:refs/heads/*"

# NOTE: Since `post` execution is not supported for local action from './' for now, we need to
# run the command by hand.
/cleanup.sh mirror
