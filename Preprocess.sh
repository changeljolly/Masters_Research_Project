#!/bin/bash
#SBATCH --partition=uoa-compute
#SBATCH --time=02:00:00
#SBATCH --mem-per-cpu=16GB

# Arguments
monopogen_script=$1
list_file=$2
output_dir=$3

path="/uoa/home/t05cj23/sharedscratch/git/Monopogen"

export LD_LIBRARY_PATH="${path}/apps:$LD_LIBRARY_PATH"
echo $LD_LIBRARY_PATH

python $monopogen_script preProcess -b $list_file -o $output_dir -a ${path}/apps -t 8

