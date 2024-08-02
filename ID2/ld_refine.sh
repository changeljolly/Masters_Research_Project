#!/bin/bash
#SBATCH --partition=uoa-compute
#SBATCH --time=12:00:00
#SBATCH --mem-per-cpu=16GB
#SBATCH --cpus-per-task=12

path="/uoa/home/t05cj23/sharedscratch/git/Monopogen"

export LD_LIBRARY_PATH="${path}/apps:$LD_LIBRARY_PATH"
echo $LD_LIBRARY_PATH

python  ${path}/src/Monopogen.py  somatic  \
    -a  ${path}/apps  -r /uoa/home/t05cj23/sharedscratch/main/scripts/region/chr20.lst \
    -i /uoa/home/t05cj23/sharedscratch/main/output/ID2 -l /uoa/home/t05cj23/sharedscratch/git/ref_barcode.csv -s LDrefinement \
    -g /uoa/home/t05cj23/sharedscratch/main/hg38/chr20.fa.gz

echo "LDrefinement for ID2 complete"