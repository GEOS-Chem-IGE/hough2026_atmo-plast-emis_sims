#!/usr/bin/env bash

#OAR -n build
#OAR --project pr-geoschem
#OAR -l /nodes=1/core=1,walltime=00:10:00

# Exit on any error
set -e

# Activate the simulation environment
source ./activate_env.sh

set -x
mkdir -p build
cd build
time -p cmake ../../../GCClassic -DRUNDIR=..
time -p make -j
time -p make install
set +x
