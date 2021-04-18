#!/bin/sh
# compiled_rbdl_time.sh
# Usage: ./compile_rbdl_time.sh
RBD_BENCHMARKS_PATH=`realpath $(dirname "$0")/../..`
RESULTS_PATH=$RBD_BENCHMARKS_PATH/results
echo "Compiling time experiments..."
for DATA_NUM in 0
do
   echo "($DATA_NUM) RBDL:"
   cd $RBD_BENCHMARKS_PATH/testbenches/rbdl/time_rbdl
   make clean
   make RBD_BENCHMARKS=$RBD_BENCHMARKS_PATH RESULTS=$RESULTS_PATH
cd $RBD_BENCHMARKS_PATH/experiments/rbdl
done
echo "Done!"
