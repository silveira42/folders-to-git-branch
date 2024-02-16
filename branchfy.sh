#!/bin/bash

echo "Welcome to branchfy!"
# https://linuxsimply.com/bash-scripting-tutorial/error-handling-and-debugging/error-handling/exit-on-error/
# set -e makes it such that the bash stops running if any command returns anything other than 0
set -e
shopt -s extglob

# https://www.baeldung.com/linux/use-command-line-arguments-in-bash-script
# getting arguments
# $1 is the path to the project
# https://stackoverflow.com/questions/19838064/bash-determine-if-variable-is-empty-and-if-so-exit
[[ -z "$1" ]] && { echo "Parameter 1 is empty" ; exit 1; }

# going to proposed path.
cd "$1"

# getting project name
PROJECT=$(basename `pwd`)

# https://stackoverflow.com/questions/1885525/how-do-i-prompt-a-user-for-confirmation-in-bash-script
read -p "Confirm usage in $PWD? " -r

if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    echo "Closing program..."
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1 # handle exits from shell or function but don't exit interactive shell
fi

GIT_DIRECTORY="branchfy-repository/"

mkdir "$GIT_DIRECTORY"
cd ./"$GIT_DIRECTORY"
git init -q
git branch -m "branchfy-temp"

cd ../

# https://stackoverflow.com/questions/14352290/listing-only-directories-using-ls-in-bash
for d in $(ls -d */)
do
    # ignoring our created repo folder
    # https://stackoverflow.com/questions/32018804/bash-only-iterate-through-files-not-sub-directories
    [[ "$d" = "$GIT_DIRECTORY" ]] && continue
    BRANCH_NAME="${d%%/}"
    echo "$BRANCH_NAME"
    cd "$GIT_DIRECTORY"
    git checkout -q -b "$BRANCH_NAME"
    rm -rf !(.git)
    cp -r ../"$d"/* ./
    git add .
    git commit -q -m 'initial commit'
    echo "Branch done!"
    cd ../
done

echo "Your branchfy git repository is done. Go to $PWD/$GIT_DIRECTORY"

read -p "Do you want to clean-up the old files? " -r

if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    echo "All done. Thanks for using branchfy!"
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1 # handle exits from shell or function but don't exit interactive shell
fi

echo "Cleaning old directories."

mv "$GIT_DIRECTORY" ../branchfy-temp-dir

rm -rf ../"$PROJECT"

mv ../branchfy-temp-dir ../"$PROJECT"

echo "All done. Thanks for using branchfy!"

exit 0
