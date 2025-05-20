#!/bin/bash

echo "Building with Pyenv $ENV_VERSION"
export PATH="$VIRTUAL_ENV/bin:$PATH"
env-freeze
echo ""
echo "Copying to user workspace"
copy -rfL . /home/apes/ws
chown -R apes /home/apes/ws
ORIGIN=$PWD
cd /home/apes/ws
echo "Running bin/waf --mpicmd='mpiexec --oversubscribe' $@"
runuser -u apes -- bin/waf --mpicmd="mpiexec --oversubscribe" $@
SUCCESS=$?
cd $ORIGIN
if $SUCCESS; then
  echo "Copying from user workspace"
  cp -rfL /home/apes/ws/build .
fi
exit $SUCCESS
