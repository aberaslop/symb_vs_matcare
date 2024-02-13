#!/bin/bash -l

#SBATCH -J spades                   # Give your job a name, so you can recognize it in the queue overview
#SBATCH -N 1                       # Define, how many nodes you need. Here, we ask for 1 node.
#SBATCH -n 4			   # number of cpus
#SBATCH --conGENOMEt="highmem"	   # request high memory node
#SBATCH --workdir=/scistor/guest/zrs382/fusarium/genomes/pacbio   # i believe also  works as -D, but leaving it off also works, as it is hte default in slurm.
#SBATCH --tasks=1
#SBATCH --cpus-per-task=32
#SBATCH -p defq
#SBATCH --output=%x_%j.out         # to name output log : name of name_of_job plus slurm_jobid- but i could do (job array index plus job id = %a_%A.out)
#SBATCH --error=%x_%j.err          # to name error log
#SBATCH --mail-type=ALL # Turn on mail notification.  Options NONE, BEGIN, END, FAIL, ALL.
#SBATCH --mail-user=a.berasateguilopez@vu.nl # to set email address
#SBATCH --array=1-9 	           # number of jobs in the array, (the number of genomes)
#SBATCH --time=0-48:00:00          #reserves the computing resources for 0 days, 4 hours and 0 minutes max (actual time may be shorter if your run completes before this time wall)
#SBATCH --mem=250G		   # memory size (per cpu, i think)


GENOME=$(sed -n ${SLURM_ARRAY_TASK_ID}p ../genomes)

module load SPAdes

spades.py 	-1 ../reads/${GENOME}_1_trimmedpaired.fastq.gz \
		-2 ../reads/${GENOME}_2_trimmedpaired.fastq.gz \
		--careful \
		-o spades/fusotu${GENOME} \
		-t ${SLURM_NPROCS}

mv spades/${GENOME}/contigs.fasta spades/${GENOME}/${GENOME}-contigs.fa
