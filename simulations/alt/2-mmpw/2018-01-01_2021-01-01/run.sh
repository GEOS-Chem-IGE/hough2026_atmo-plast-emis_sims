#!/usr/bin/env bash

#OAR -n run
#OAR --project pr-geoschem
#OAR -l /nodes=1,walltime=10:00:00
#OAR -t heterogeneous

# Activate the simulation environment
source ./activate_env.sh

time -p ./gcclassic
