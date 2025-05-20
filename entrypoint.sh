#!/bin/bash

echo "Building with Pyenv $ENV_VERSION"
source $VIRTUAL_ENV/bin/activate
env-freeze
echo ""
echo "Copying to user workspace"
cp -rfL . /home/apes/ws
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
