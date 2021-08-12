#!/bin/bash

bindir=$(dirname "$0")
cd $bindir || exit 1

rm -fr broken-out.tar.gz broken-out/ series .DATE*

wget https://www.ozlabs.org/~akpm/mmotm/broken-out.tar.gz
tar -xf broken-out.tar.gz
rm -f broken-out.tar.gz
