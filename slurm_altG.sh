#!/bin/bash

# Number of datasets
num_datasets=5

# Template file
template_file="/uoa/home/t05cj23/sharedscratch/main/scripts/alt_germline.sh"

# Loop over each dataset
for dataset_id in $(seq 1 $num_datasets); do
  # Create a SLURM script for the current dataset
  job_script="run_germline_c20_ID${dataset_id}.sh"
  sed "s/{{DATASET_ID}}/${dataset_id}/g" $template_file > $job_script

  # Submit the job script
  echo "Submitting job script for Dataset ID: $dataset_id"
  sbatch $job_script
done