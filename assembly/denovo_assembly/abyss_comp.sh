#!/bin/sh

GENOMES=$(cat ../genomes)

module load shared 2021 Miniconda3
conda activate abyss

for GENOME in $GENOMES
do
	abyss-fac abyss/${GENOME}/k*/${GENOME}-contigs.fa > abyss/${GENOME}/${GENOME}_abyss_k_comparison.tsv

	KMER=$(tail -n +2 abyss/${GENOME}/${GENOME}_abyss_k_comparison.tsv | sort -n -k 6 | awk '{print $11}' | sed "s#abyss/${GENOME}/##" | sed "s#/${GENOME}-contigs.fa##" | tail -n1)

	echo "${KMER} selected" >> abyss/${GENOME}/${GENOME}_abyss_k_comparison.tsv

	cp abyss/${GENOME}/${KMER}/${GENOME}-contigs.fa abyss/${GENOME}/
done
