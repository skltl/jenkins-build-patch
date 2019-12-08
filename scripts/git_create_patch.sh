#!/usr/bin/env bash


# source: https://git-blame.blogspot.com/2013/06/checking-current-branch-programatically.html
if branch=$(git symbolic-ref --short -q HEAD)
then
  echo on branch $branch
else
  echo not on any branch
  exit 1
fi

tmpfile=$(mktemp)
git diff HEAD > $tmpfile

echo "trying to send file..."
curl -X POST -v -F "patch.diff=@$tmpfile" http://localhost:8080/job/MyPatchBuilder/buildWithParameters

rm $tmpfile
