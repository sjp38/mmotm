#!/bin/bash

commits=$(git log --pretty='%h' -- broken-out/)
for commit in $commits
do
	diff_output=$(git diff "$commit^..$commit" --name-status \
		-- broken-out/)
	dropped=$(echo "$diff_output" | grep -c '^D')
	added=$(echo "$diff_output" | grep -c '^A')
	modified=$(echo "$diff_output" | grep -c '^M')
	date=$(git show "$commit:.DATE" | head -n 1)
	base=$(git show "$commit:.DATE" | tail -n 1)

	echo "$date: based on $base, $added adds, $modified modifications, $dropped drops"
done
