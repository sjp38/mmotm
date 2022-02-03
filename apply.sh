#!/bin/bash

if [ $# -ne 1 ]
then
	echo "Usage: $0 <linux repo>"
	exit 1
fi

linux_repo=$1

bindir=$(dirname "$(realpath "$0")")

date="$bindir/.DATE"
base_version="v$(tail -n 1 "$date")"

echo "base version: $base_version"
if ! git -C "$linux_repo" checkout "$base_version"
then
	echo "baseline ($base_version) checkout failed"
	exit 1
fi

series="$bindir/series"
patchesdir="$bindir/broken-out"

while read -r patch
do
	if echo "$patch" | grep "^#" -q
	then
		continue
	fi
	if ! git -C "$linux_repo" am "$patchesdir/$patch"
	then
		echo "Failed applying $patch"
		echo "Maybe adding \"From: Andrew Morton <akpm@linux-foundation.org>\" could help?"
		break
	fi
done < "$series"
