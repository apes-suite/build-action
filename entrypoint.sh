#!/bin/bash

echo "Building with Pyenv $ENV_VERSION"
env
echo ""
git config --global --add safe.directory $PWD
useradd tester
bin/waf --mpicmd="su tester mpiexec --oversubscribe" $@
