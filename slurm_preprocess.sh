#!/bin/bash

# Define paths
path="/uoa/home/t05cj23/sharedscratch/git/Monopogen"
list_dir="/uoa/home/t05cj23/sharedscratch/main/list"
base_output_dir="/uoa/home/t05cj23/sharedscratch/main/output"
scripts_dir="/uoa/home/t05cj23/sharedscratch/main/scripts"

# Set the library path
export LD_LIBRARY_PATH="${path}/apps:$LD_LIBRARY_PATH"
echo $LD_LIBRARY_PATH

# Ensure base output directory exists
mkdir -p $base_output_dir

# Loop through each list file, sorted numerically, and submit a SLURM job for each
for list_file in $(ls ${list_dir}/ID*_list.lst | sort -V); do
    # Extract the ID from the list file name
    filename=$(basename -- "$list_file")
    id="${filename%_list.lst}"

    # Create a unique output directory for this dataset
    output_dir="${base_output_dir}/${id}"
    mkdir -p $output_dir

    echo "Preprocessing ${list_file} with output to ${output_dir}..."

    # Run the preprocessing job script
    sbatch ${scripts_dir}/Preprocess.sh ${path}/src/Monopogen.py ${list_file} ${output_dir} 8

done

echo "Preprocessing submitted for all files."
