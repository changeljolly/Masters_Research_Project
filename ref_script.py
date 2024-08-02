import pandas as pd
import os

# Define paths to data files
sra_metadata_file = "/uoa/home/t05cj23/sharedscratch/git/sra_metadata_with_batchid.csv"
single_cell_data_file= "/uoa/home/t05cj23/sharedscratch/git/Randolph_singlecell_metadata.tsv"
output_directory = '/uoa/home/t05cj23/sharedscratch/git/barcode'

# Read SRA metadata CSV file
sample_meta = pd.read_csv(sra_metadata_file)

# Read single cell data text file
single_cell_meta = pd.read_csv(single_cell_data_file, sep='\t')

# Merge data files on 'Batch'
ref_data = pd.merge(sample_meta, single_cell_meta, how="inner", left_on='batchID', right_on='Batch')

# Check if output directory exists
os.makedirs(output_directory, exist_ok=True)

# Get unique BAM file names
unique_runs = ref_data['Run'].unique()

# Iterate over unique BAM file names
for Run in unique_runs:
    # Filter data for the current BAM file name
    run_data = ref_data[ref_data['Run'] == Run]
    
    # Extract cell barcodes from the 'CellID' column and remove batch ID information
    cell_barcodes = [cell_id.split('_')[-1] + "-1" for cell_id in run_data['CellID']]
    
    # Create output text file path
    output_file = os.path.join(output_directory, f"{Run}.txt")
    
    # Write cell barcodes to text file
    with open(output_file, 'w') as f:
        f.write('\n'.join(cell_barcodes))
    
    print(f"Saved cell barcodes for {Run} to {output_file}")
