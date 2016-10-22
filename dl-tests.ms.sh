#!/bin/bash

tag=0.7.1

set -e

tmp=$(mktemp -d)

trap cleanup EXIT
cleanup() {
    set +e
    [ -z "$tmp" -o ! -d "$tmp" ] || rm -rf "$tmp"
}

unset CDPATH
pwd=$(pwd)

pushd "$tmp"
git clone https://github.com/guille/ms.js.git
cd ms.js
git archive --prefix="test/" --format=tar tags/${tag}:test/ \
    | bzip2 > "$pwd"/tests-${tag}.tar.bz2
popd
