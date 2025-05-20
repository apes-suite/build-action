#!/bin/bash

echo "Building with Pyenv $ENV_VERSION"
source $VIRTUAL_ENV/bin/activate
env-freeze
echo ""
echo ""
echo "Copying to user workspace"
mkdir -p /home
cp -rfL $2 /home/apes
chown -R apes /home/apes
ORIGIN=$PWD
cd /home/apes
echo "Running bin/waf --mpicmd='mpiexec --oversubscribe' $1"
runuser -u apes -- bin/waf --mpicmd="mpiexec --oversubscribe" $1
SUCCESS=$?
cd $ORIGIN
if [[ $SUCCESS ]]; then
  echo "Copying from user workspace"
  cp -rfL /home/apes/build $2
fi
exit $SUCCESS
