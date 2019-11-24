# This script should merge all files from a given sample (the sample id is provided in the third argument)
# into a single file, which should be stored in the output directory specified by the second argument.
# The directory containing the samples is indicated by the first argument.

echo "Merging all files...."
mkdir -p $2
cat $1/$3-12.5dpp.1.1s_sRNA.fastq.gz $1/$3-12.5dpp.1.2s_sRNA.fastq.gz > $2/$3.fastq.gz
echo

# El modelo que seguí para elaborar el script
# mkdir -p out/merged
# cat data/C57BL_6NJ-12.5dpp.1.1s_sRNA.fastq.gz data/C57BL_6NJ-12.5dpp.1.2s_sRNA.fastq.gz > out/merged/C57BL_6NJ.fastq.gz
# cat data/SPRET_EiJ-12.5dpp.1.1s_sRNA.fastq.gz data/SPRET_EiJ-12.5dpp.1.2s_sRNA.fastq.gz > out/merged/SPRET_EiJ.fastq.gz


