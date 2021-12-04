#!/bin/bash

bindir=$(dirname "$0")

commits=$(git log --pretty='%h' -- broken-out/)
for commit in $commits
do
	"$bindir"/__diff_brief.sh "$commit^" "$commit"
done
