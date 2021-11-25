#!/bin/bash

if [ $# -ne 1 ]
then
	echo "Usage: $0 <linux repo>"
	exit 1
fi

linux_repo=$1

bindir=$(dirname $(realpath $0))

date="$bindir/.DATE"
base_version="v$(cat "$date" | tail -n 1)"

echo "base version: $base_version"
if ! git -C "$linux_repo" checkout "$base_version"
then
	echo "baseline ($base_version) checkout failed"
	exit 1
fi

series="$bindir/series"
patchesdir="$bindir/broken-out"

for patch in $(grep "^[^#]" $series)
do
	if ! git -C "$linux_repo" am "$patchesdir/$patch"
	then
		echo "failed applying $patch"
		break
	fi
done
