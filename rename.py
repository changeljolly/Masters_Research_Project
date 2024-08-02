import pandas as pd

#Read the CSV file
df = pd.read_csv('/uoa/home/t05cj23/sharedscratch/git/merged_barcodes.csv')

#Rename the columns using the rename method
df = df.rename(columns={'CellBarcode': 'cell', 'Run': 'id'})

#Save the DataFrame back to a CSV file
df.to_csv('ref_barcode.csv', index=False)
