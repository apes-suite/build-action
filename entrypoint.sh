#/bin/bash

echo "Building with Pyenv $ENV_VERSION"
env-freeze
echo ""
bin/waf --mpicmd="mpiexec --oversubscribe" $@
