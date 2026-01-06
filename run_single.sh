#!/bin/bash

# Dont let script run more than once
if [[ $(pgrep -c "`basename $0`") -gt 1 ]]; then
    echo "Process already running"
    exit 1
fi


echo "**********************"
echo $(date)
#cd ~/mesa/scripts
pwd

source ~/.bashrc
source mesa_test.sh

module load git
#spack load git-lfs # also loads a new git

cd "$MESA_GIT" || exit

# Get all updates over all branches
git fetch --all

echo "Starting"

if [[ $? != 0 ]];then
	echo "Update failed"
	exit 1
fi

if [ "$#" -eq 0 ]; then
    echo "Please provide an SHA!"
   exit 
else
    export VERSION=$1
fi

if [ "$#" -ge 2 ]; then
	export TEST_ID="$2"
fi



export OUT_FOLD="${MESA_LOG}/${VERSION}single"

if [ -d $OUT_FOLD ]; then
	echo "Skipping $i"
	continue
else
	echo "Submitting $i" 
	mkdir -p "$OUT_FOLD"
fi

if [[ -n "${TEST_ID:-}" ]]; then
	sbatch -o "$OUT_FOLD"/single.txt --parsable --export=VERSION=$VERSION,HOME=$HOME,OUT_FOLD=$OUT_FOLD,TEST_ID=$TEST_ID "${MESA_SCRIPTS}/test-mesa-single.sh" "$TEST_ID"
else
  sbatch -o "$OUT_FOLD"/build.txt --parsable --export=VERSION=$VERSION,HOME=$HOME,OUT_FOLD="$OUT_FOLD" "${MESA_SCRIPTS}/test-mesa.sh"
fi

date
echo "**********************"
