#!/bin/bash

echo "::group::Build-Environment"
echo "Building with Pyenv $ENV_VERSION"
source $VIRTUAL_ENV/bin/activate
env-freeze
echo "::endgroup::"
echo "::group::Build-Preparation"
echo "Chowning to apes user"
GHUSER=$(ls -ld . | awk 'NR==1 {print $3}')
GHGROUP=$(ls -ld . | awk 'NR==1 {print $4}')
chown -R apes .
ORIGIN=$PWD
cd $2
echo "::endgroup::"
echo "::group::Building"
echo "Running bin/waf --mpicmd='mpiexec --oversubscribe' $1"
runuser -u apes -- bin/waf --mpicmd="mpiexec --oversubscribe" $1
SUCCESS=$?
echo "::endgroup::"
echo "::group::Build-Finalization"
cd $ORIGIN
echo "Chowning to GH user"
chown -R $GHUSER:$GHGROUP $ORIGIN
if [[ $SUCCESS ]]; then
  echo "* Successfully compiled \`$2\` with:" >> $GITHUB_STEP_SUMMARY
  echo "  \`bin/waf --mpicmd='mpiexec --oversubscribe' $1\`" >> $GITHUB_STEP_SUMMARY
else
  echo "**FAILED** to compile \`$2\` with:" >> $GITHUB_STEP_SUMMARY
  echo "\`bin/waf --mpicmd='mpiexec --oversubscribe' $1\`" >> $GITHUB_STEP_SUMMARY
fi
echo "::endgroup::"
exit $SUCCESS
