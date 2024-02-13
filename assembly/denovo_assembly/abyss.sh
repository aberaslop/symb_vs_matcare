#!/bin/bash -l

#SBATCH -J abyss                   # Give your job a name, so you can recognize it in the queue overview
#SBATCH -N 1                       # Define, how many nodes you need. Here, we ask for 1 node.
#SBATCH -n 48                       # number of cpus
#SBATCH --workdir=/scistor/guest/zrs382/fusarium/genomes/pacbio   # i believe also  works as -D, but leaving it off also works, as it is hte default in slurm.
#SBATCH --tasks=1
#SBATCH --cpus-per-task=32
#SBATCH -p defq
#SBATCH --output=%x_%j.out         # to name output log : name of name_of_job plus slurm_jobid- but i could do (job array index plus job id = %a_%A.out)
#SBATCH --error=%x_%j.err          # to name error log
#SBATCH --mail-type=ALL # Turn on mail notification.  Options NONE, BEGIN, END, FAIL, ALL.
#SBATCH --mail-user=a.berasateguilopez@vu.nl # to set email address
#SBATCH --array=120-128 	   #kmer sizese to check                # number of jobs in the array, (the number of genomes)
#SBATCH --time=0-24:00:00          #reserves the computing resources for 0 days, 4 hours and 0 minutes max (actual time may be shorter if your run completes before this time wall)
#SBATCH --mem=250G          

GENOME=$(cat ../genomes)

module load shared 2021 Miniconda3

conda activate abyss

for GENOME in $GENOMES
do
	mkdir abyss/${GENOME}/k${SLURM_ARRAY_TASK_ID}
	abyss-pe -C abyss/${GENOME}/k${SLURM_ARRAY_TASK_ID} name=${GENOME} in='../reads/${GENOME}_1_trimmedpaired.fastq.gz ../reads/${GENOME}_2_trimmedpaired.fastq.gz' np=${SLURM_NPROCS}
done
