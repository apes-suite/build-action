#!/bin/bash

echo "Building with Pyenv $ENV_VERSION"
export PATH="$VIRTUAL_ENV/bin:$PATH"
mkdir -p /github/home/.cache/pip
env-freeze
echo ""
git config --global --add safe.directory '*'
export OMPI_ALLOW_RUN_AS_ROOT=1
export OMPI_ALLOW_RUN_AS_ROOT_CONFIRM=1
bin/waf --mpicmd="mpiexec --oversubscribe" $@
