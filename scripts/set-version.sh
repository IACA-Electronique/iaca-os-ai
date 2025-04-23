#!/bin/bash


VERSION=$1

if [ -z "$VERSION" ]; then
    echo "Usage : $0 <version>"
    exit 1
fi


printf "$VERSION" > src/usr/local/iaca/os/exec/commands/ai/version
sed -i "s/^Version:.*/Version: $VERSION/" src/DEBIAN/control