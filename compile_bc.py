import pandas as pd
import os

# Directory containing text files to merge
input_directory = '/uoa/home/t05cj23/sharedscratch/git/barcode'

# List to store data from each text file
data = []

# Iterate over each text file in the directory
for filename in os.listdir(input_directory):
    if filename.endswith(".txt"):
        file_path = os.path.join(input_directory, filename)
        run_name = os.path.splitext(filename)[0]  # Extract Run name from file name
        
        # Read lines from text file and store in data list
        with open(file_path, 'r') as f:
            for line in f:
                data.append({'Run': run_name, 'CellBarcode': line.strip()})

# Create DataFrame from collected data
df = pd.DataFrame(data)

# Rearrange columns such that 'CellBarcode' is first
df = df[['CellBarcode', 'Run']]

# Output CSV file path
output_csv = '/uoa/home/t05cj23/sharedscratch/git/merged_barcodes.csv'

# Save DataFrame to CSV
df.to_csv(output_csv, index=False)

print(f"Merged data saved to {output_csv}")
