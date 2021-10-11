#!/bin/bash

commits=$(git log --pretty='%h' -- broken-out/)
for commit in $commits
do
	$(dirname "$0")/diff_brief.sh "$commit"
done
