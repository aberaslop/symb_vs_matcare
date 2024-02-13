#!/bin/sh
#$ -cwd           # Set the working directory for the job to the current directory
#$ -pe smp 4      # Request 4 cores
#$ -l h_rt=24:0:0 # Request 24 hour runtime
#$ -l h_vmem=1G   # Request 1GB RAM
#$ -j y
#$ -t 1-5

#!/bin/bash -l

#SBATCH -J trimm                   # Give your job a name, so you can recognize it in the queue overview
#SBATCH -N 1                       # Define, how many nodes you need. Here, we ask for 1 node.
#SBATCH -n 4                       # Request 4 cores
#SBATCH --workdir=/scistor/guest/zrs382/fusarium/genomes/pacbio   # i believe also  works as -D, but leaving it off also works, as it is hte default in slurm.
#SBATCH --tasks=1
#SBATCH --cpus-per-task=32
#SBATCH -p defq
#SBATCH --output=%x_%j.out         # to name output log : name of name_of_job plus slurm_jobid- but i could do (job array index plus job id = %a_%A.out)
#SBATCH --error=%x_%j.err          # to name error log
#SBATCH --mail-type=BEGIN,END,FAIL # Turn on mail notification.  Options NONE, BEGIN, END, FAIL, ALL.
#SBATCH --mail-user=a.berasateguilopez@vu.nl # to set email address
#SBATCH --array=1-9                # number of jobs in the array, (the number of genomes)
#SBATCH --time=0-48:00:00          # REquests 48h runtime reserves the computing resources for 0 days, 4 hours and 0 minutes max (actual time may be shorter if your run completes before this time wall)
#SBATCH --mem=250G


#load necessary packages

module load shared 2021 FastQC

# execute commands

GENOME=$(sed -n ${SLURM_ARRAY_TASK_ID}p ../genomes)

fastqc -t ${SLURM_NPROCS} ${GENOME}_1_trimmedpaired.fastq.gz ${GENOME}_2_trimmedpaired.fastq.gz
