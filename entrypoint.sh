#!/bin/bash

echo "::group::Build-Environment"
echo "Building with Pyenv $ENV_VERSION"
source $VIRTUAL_ENV/bin/activate
env-freeze
echo "::endgroup::"
echo "::group::Build-Preparation"
echo "Copying $2 to user workspace"
mkdir -p /home
cp -rfL $2 /home/apes
chown -R apes /home/apes
ORIGIN=$PWD
cd /home/apes
echo "::endgroup::"
echo "::group::Building"
echo "Running bin/waf --mpicmd='mpiexec --oversubscribe' $1"
runuser -u apes -- bin/waf --mpicmd="mpiexec --oversubscribe" $1
SUCCESS=$?
echo "::endgroup::"
echo "::group::Build-Finalization"
cd $ORIGIN
if [[ $SUCCESS ]]; then
  echo "* Successfully compiled \`$2\` with:" >> $GITHUB_STEP_SUMMARY
  echo "  \`bin/waf --mpicmd='mpiexec --oversubscribe' $1\`" >> $GITHUB_STEP_SUMMARY
  echo "Copying $3 from user workspace to $ORIGIN/$2"
  cp -rfL /home/apes/$3 $2
  SUCCESS=$?
  if [[ $SUCCESS ]]; then
    echo "* Successfully copied \`$3\` back to workspace" >> $GITHUB_STEP_SUMMARY
  else
    echo "* But *FAILED* to copy resulting \`$3\`!" >> $GITHUB_STEP_SUMMARY
  fi
else
  echo "**FAILED** to compile \`$2\` with:" >> $GITHUB_STEP_SUMMARY
  echo "\`bin/waf --mpicmd='mpiexec --oversubscribe' $1\`" >> $GITHUB_STEP_SUMMARY
fi
echo "::endgroup::"
exit $SUCCESS
