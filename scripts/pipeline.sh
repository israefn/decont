#Download all the files specified in data/urls

for url in $(cat data/urls)
do
    bash scripts/download.sh $url data
done

# Download the contaminants fasta file, and uncompress it

bash scripts/download.sh https://bioinformatics.cnio.es/data/courses/decont/contaminants.fasta.gz res yes

# Index the contaminants file

bash scripts/index.sh res/contaminants.fasta res/contaminants_idx

# Merge the samples into a single file

for sid in $(ls data/*.sRNA.fastq.gz | cut -d "_" -f1 | sed 's:data/::' | sort | uniq)
do
    bash scripts/merge_fastqs.sh data out/merged $sid
done

# Run cutadapt for all merged files

for fname in out/merged/*.fastq.gz
do
   sid=$(ls data xxxxxxxxxxxxxxxx fname XXXXXXXXXXXX)

    sid=$(ls out/merged/*.fastq.gz | cut -d "_" -f1 | sed 's:data/::' | sort | uniq)
    mkdir -p log/cutadapt
    mkdir -p out/cutadapt
    cutadapt -m 18 -a TGGAATTCTCGGGTGCCAAGG --discard-untrimmed -o out/cutadapt/${sid}.trimmed.fastq.gz data/${sid}.fastq.gz > log/cutadapt/${sid}.log
done

#TODO: run STAR for all trimmed files
for fname in out/trimmed/*.fastq.gz
do
    # you will need to obtain the sample ID from the filename
    sid=$(ls data/*.sRNA.fastq.gz | cut -d "_" -f1 | sed 's:data/::' | sort | uniq)
    mkdir -p out/star/$sid
    STAR --runThreadN 4 --genomeDir res/contaminants_idx --outReadsUnmapped Fastx --readFilesIn out/cutadapt/${sid} --readFilesCommand zcat --outFileNamePrefix out/star/${sid}
done 

# TODO: create a log file containing information from cutadapt and star logs
# (this should be a single log file, and information should be *appended* to it on each run)
# - cutadapt: Reads with adapters and total basepairs
# - star: Percentages of uniquely mapped reads, reads mapped to multiple loci, and to too many loci
