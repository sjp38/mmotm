#!/bin/bash

commits=$(git log --pretty='%h' -- broken-out/)
for commit in $commits
do
	diff_output=$(git diff "$commit^".."$commit" --name-status \
		-- broken-out/)
	dropped=$(echo "$diff_output" | grep '^D' | wc -l)
	added=$(echo "$diff_output" | grep '^A' | wc -l)
	modified=$(echo "$diff_output" | grep '^M' | wc -l)
	date=$(git show "$commit:.DATE" | head -n 1)

	echo "$date: $added adds, $modified modifications, $dropped drops"
done
