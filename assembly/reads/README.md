# Fusarium Lifestyles
## 1 Assembly
### 1.1 Read quality control

Requires raw `fastq.gz` paired-end reads in this directory as well as `TruSeq3-PE.fa` file with adapter sequences downloaded from here (for Illumina NovaSeq 6000 151bp paired-end reads).

1. `sbatch trimmomatic.sh` - trims raw reads using Trimmomatic.
2. `sbatch fastqc.sh` - after trimming, checks read quality with FastQC.
