#!/bin/bash

if [ $# -ne 1 ]
then
	echo "Usage: $0 <commit>"
	exit 1
fi

commit=$1

diff_output=$(git diff "$commit^..$commit" --name-status -- broken-out/)
dropped=$(echo "$diff_output" | grep -c '^D')
added=$(echo "$diff_output" | grep -c '^A')
modified=$(echo "$diff_output" | grep -c '^M')
date=$(git show "$commit:.DATE" | head -n 1)
base=$(git show "$commit:.DATE" | tail -n 1)
total=$(git show "$commit:series" | sed '/^#/d' | wc -l)

echo "$date: based on $base, $added adds, $modified modifications, $dropped drops, $total total"
