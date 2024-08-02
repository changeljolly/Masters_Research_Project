import pandas as pd
import os 
import numpy as n

# Function to apply filtering criteria to a DataFrame
def filter_df(df):
    filtered_df = df[
        (df['SVM_pos_score'] > 0.5) &
        (df['BAF_alt'] > 0.1) & (df['BAF_alt'] < 0.5) &
        (df['Depth_ref'] > 5) &
        (df['Depth_alt'] > 5)
    ]
    return filtered_df

# Load the datasets
df1 = pd.read_csv('/uoa/home/t05cj23/sharedscratch/main/output/ID1/somatic/chr20.putativeSNVs.csv')

# Apply the filtering criteria to both datasets
filtered_ID1 = filter_df(df1)

# Specify the directory where you want to save the filtered data
output_directory = '/uoa/home/t05cj23/sharedscratch/main/filtered SNV'  # e.g., '/path/to/your/directory'

# Save each filtered dataset separately
filtered_ID1.to_csv(f'{output_directory}/filtered_ID1.csv', index=False)

# Print the number of rows in the final outputs
print(f"Number of rows in filtered_ID1.csv: {filtered_ID1.shape[0]}")
