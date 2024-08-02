#!/bin/bash
#SBATCH --partition=uoa-compute
#SBATCH --time=12:00:00
#SBATCH --mem-per-cpu=16GB
#SBATCH --cpus-per-task=12

# Set the base path for Monopogen
path="/uoa/home/t05cj23/sharedscratch/git/Monopogen"
export LD_LIBRARY_PATH="${path}/apps:$LD_LIBRARY_PATH"
echo "LD_LIBRARY_PATH: $LD_LIBRARY_PATH"

# Base paths for input files and output directory
base_input_path="/uoa/home/t05cj23/sharedscratch/main/hg38"
base_output_path="/uoa/home/t05cj23/sharedscratch/main/output"
region_list_base="/uoa/home/t05cj23/sharedscratch/main/scripts/region"

# Number of datasets to process
num_datasets=5

# Specify the region to process
region_id=20

# Iterate over each dataset
for dataset_id in $(seq 1 $num_datasets); do
  # Only process the current dataset ID
  if [ $dataset_id -eq {{DATASET_ID}} ]; then
    echo "Processing Dataset ID: $dataset_id for region chr${region_id}..."

    # Construct the input genome file and output directory
    genome_file="${base_input_path}/chr${region_id}.fa.gz"
    output_dir="${base_output_path}/ID${dataset_id}"

    # BAM file list
    bam_file="${base_output_path}/ID${dataset_id}/Bam/chr${region_id}.filter.bam.lst"

    # Region list
    region_list="${region_list_base}/chr${region_id}.lst"

    # Debugging: Print out paths and check file existence
    echo "Checking BAM file: $bam_file"
    ls -l $bam_file

    # Run Monopogen germline analysis
    python ${path}/src/Monopogen.py germline -a ${path}/apps -t 12 -r $region_list \
      -p ${path}/ -g $genome_file -s all -o $output_dir 

    echo "Completed processing Dataset ID: $dataset_id for region chr${region_id}."
  fi
done

echo "All datasets processed for region chr${region_id}."