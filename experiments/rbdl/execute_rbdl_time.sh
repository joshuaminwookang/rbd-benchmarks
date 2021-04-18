#!/bin/sh
# execute_rbdl_time.sh
# Usage: ./execute_rbdl_time.sh
RBD_BENCHMARKS_PATH=`realpath $(dirname "$0")/../..`
RESULTS_PATH=$RBD_BENCHMARKS_PATH/results
echo "Running time experiments..."
for DATA_NUM in 0
do
   echo "($DATA_NUM) RBDL:"
   cd $RBD_BENCHMARKS_PATH/testbenches/rbdl/time_rbdl
   for ROBOT_MODEL in iiwa hyq atlas
   do
      echo "RBDL: $RESULTS, time, $ROBOT_MODEL"
      # ./time_rbdl $ROBOT_MODEL
      ./time_rbdl $ROBOT_MODEL
   done
cd $RBD_BENCHMARKS_PATH/experiments/rbdl
done
echo "Done!"
