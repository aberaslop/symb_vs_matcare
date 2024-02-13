#!/bin/sh
#Script to submit de novo assembly jobs

GENOME=$(cat ../genomes)

for ASSEMBLER in abyss megahit spades
do
	mkdir ${ASSEMBLER}

	for GENOME in $GENOMES
	do
		mkdir ${ASSEMBLER}/${GENOME}
	done

	sbatch ${ASSEMBLER}.sh #or would it be srun?
done
