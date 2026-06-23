#!/usr/bin/env bash

#OAR -n dryrun
#OAR --project pr-geoschem
#OAR -l /nodes=1/core=1,walltime=01:00:00

# Activate the simulation environment
source ./activate_env.sh

python download_data.py dryrun.log wu
