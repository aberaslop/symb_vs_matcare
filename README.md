Bioinformatics analysis pipeline for:


The pipeline was written for and run on the Vrije Universiteit Amsterdam facility which uses the Univa Grid Engine batch-queue system. This means that many of the bash scripts (.sh file endings) specify core allocation, run times and memory usage allocation that may need to be adapted for different platforms.

Associated data files: DOI


## 1. Assembly

`cd assembly`

### 1.1. Read quality control

`cd assembly/reads`

Requires rw `fastq.gz` paired-ends in this directory as well as `TruSeq3-PE.fa` file with adapter sequences dowloaded from here (for Illumina NovaSeq 6000 151 bp paired-end reads).

1. `sbatch trimmomatic.sh` - trim raw reads using Trimmomatic
2. `sbatch fastqc.sh` - after trimming, checks read quality with FastQC.
