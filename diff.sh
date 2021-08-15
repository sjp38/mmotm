#!/bin/bash

pr_usage() {
	echo "Usage: $0 [OPTION]..."
	echo
	echo "OPTION"
	echo "  --from <commit>	start point of the diff"
	echo "  --to <commit>	end point of the diff"
}

pr_usage_exit() {
	exit_code=$1

	pr_usage
	exit "$exit_code"
}

while [ $# -ne 0 ]
do
	case $1 in
	"--from")
		if [ $# -lt 2 ]
		then
			echo "<commit> not given"
			pr_usage_exit 1
		fi
		from=$2
		shift 2
		continue
		;;
	"--to")
		if [ $# -lt 2 ]
		then
			echo "<commit> not given"
			pr_usage_exit 1
		fi
		to=$2
		shift 2
		continue
		;;
	*)
		if [ $# -ne 0 ]
		then
			pr_usage_exit 1
		fi
		;;
	esac
done

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
