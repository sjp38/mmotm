#!/bin/bash

if [ $# -ne 2 ]
then
	echo "Usage: $0 <from> <to>"
	exit 1
fi

from=$1
to=$2

diff_output=$(git diff "$from..$to" --name-status -- broken-out/)
dropped=$(echo "$diff_output" | grep -c '^D')
added=$(echo "$diff_output" | grep -c '^A')
modified=$(echo "$diff_output" | grep -c '^M')
date=$(git show "$to:.DATE" | head -n 1)
base=$(git show "$to:.DATE" | tail -n 1)
total=$(git show "$to:series" | sed '/^#/d' | wc -l)

echo "$date: based on $base, $added adds, $modified modifications, $dropped drops, $total total"
