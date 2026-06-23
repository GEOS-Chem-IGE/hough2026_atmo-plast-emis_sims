#!/usr/bin/env bash

#OAR -n dryrun
#OAR --project pr-geoschem
#OAR -l /nodes=1/core=1,walltime=00:15:00

# Activate the simulation environment
source ./activate_env.sh

time -p ./gcclassic --dryrun | tee dryrun.log
