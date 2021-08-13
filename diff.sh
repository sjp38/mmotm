#!/bin/bash

if [ $# -ne 2 ]
then
	echo "Usage: $0 <from> <to>"
	exit 1
fi

from=$1
to=$2

diff_output=$(git diff "$from".."$to" --name-status | grep broken-out/)

dropped=$(echo "$diff_output" | grep '^D' | grep 'broken-out/' | \
	awk -F'broken-out/' '{print $2}')
added=$(echo "$diff_output" | grep '^A' | grep 'broken-out/' | \
	awk -F'broken-out/' '{print $2}')
modified=$(echo "$diff_output" | grep '^M' | grep 'broken-out/' | \
	awk -F'broken-out/' '{print $2}')

echo "Dropped"
echo "----"
echo
echo "$dropped"
echo
echo "Added"
echo "-----"
echo
echo "$added"
echo
echo "Modified"
echo "--------"
echo
echo "$modified"
echo

dropped=$(echo "$diff_output" | grep '^D' | grep 'broken-out' | wc -l)
added=$(echo "$diff_output" | grep '^A' | grep 'broken-out' | wc -l)
modified=$(echo "$diff_output" | grep '^M' | grep 'broken-out' | wc -l)

echo "summary: $dropped drop, $added add, $modified modified"
