#!/bin/sh

# Prevent numpy from multithreading?
if [ $EPIC -eq 0 ]; then
  export OPENBLAS_NUM_THREADS=1
fi

# CD into our working directory
cd ${EVERESTDAT}

if [ $NODES -eq 1 ]; then
  # Run on a single node with Python multiprocessing
  python -c "import everest; everest.missions.k2.slurm._Run($CAMPAIGN, $SUBCAMPAIGN, $EPIC, $STRKWARGS)"
else
  # Run on multiple nodes with MPI
  mpirun -np $TASKS python -c "import everest; everest.missions.k2.slurm._Run($CAMPAIGN, $SUBCAMPAIGN, $EPIC, $STRKWARGS)"
fi