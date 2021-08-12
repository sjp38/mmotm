#!/bin/bash

if [ $# -ne 2 ]
then
	echo "Usage: $0 <from> <to>"
	exit 1
fi

from=$1
to=$2

diff_output=$(git diff "$from".."$to" --name-status | grep broken-out/)
echo "$diff_output"

dropped=$(echo "$diff_output" | grep '^D' | grep 'broken-out' | wc -l)
added=$(echo "$diff_output" | grep '^A' | grep 'broken-out' | wc -l)
modified=$(echo "$diff_output" | grep '^M' | grep 'broken-out' | wc -l)

echo "$dropped drop, $added add, $modified modified"
