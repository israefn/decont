# This script should index the genome file specified in the first argument,
# creating the index in a directory specified by the second argument.

# The STAR command is provided for you. You should replace the parts surrounded by "<>" and uncomment it.

echo "Indexing the genome..."
mkdir -P res/contaminants_idx
STAR --runThreadN 4 --runMode genomeGenerate --genomeDir res/contaminants_idx --genomeFastaFiles res/contaminants.fasta.gz --genomeSAindexNbases 9
echo

