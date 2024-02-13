#!/bin/bash -l

#SBATCH -J trimm                   # Give your job a name, so you can recognize it in the queue overview
#SBATCH -N 1                       # Define, how many nodes you need. Here, we ask for 1 node.
#SBATCH -n 4			   # number of cpus
#SBATCH --workdir=/scistor/guest/zrs382/fusarium/genomes/pacbio   # i believe also  works as -D, but leaving it off also works, as it is hte default in slurm.
#SBATCH --tasks=1
#SBATCH --cpus-per-task=32
#SBATCH -p defq
#SBATCH --output=%x_%j.out         # to name output log : name of name_of_job plus slurm_jobid- but i could do (job array index plus job id = %a_%A.out)
#SBATCH --error=%x_%j.err          # to name error log
#SBATCH --mail-type=BEGIN,END,FAIL # Turn on mail notification.  Options NONE, BEGIN, END, FAIL, ALL.
#SBATCH --mail-user=a.berasateguilopez@vu.nl # to set email address
#SBATCH --array=1-9 	           # number of jobs in the array, (the number of genomes)
#SBATCH --time=0-04:00:00          #reserves the computing resources for 0 days, 4 hours and 0 minutes max (actual time may be shorter if your run completes before this time wall)
#SBATCH --mem=250G		   # memory size (per cpu, i think)

    # You may not place any commands before the last SBATCH directive
    # Note: for parallel operations increase cpus-per-task above
    # Note 2: output and error logs can be given absolute paths

    echo "== Starting run at $(date)"
    echo "== Job ID: ${SLURM_JOBID}"
    echo "== Node list: ${SLURM_NODELIST}"
    echo "== Submit dir. : ${SLURM_SUBMIT_DIR}"
    echo "== Scratch dir. : ${TMPDIR}"

    # cd $TMPDIR
    # or change to a project folder with matlab file e.g. hello_World.m

    #if you want to direct to a folder do here

#cd /scistor/guest/zrs382/gallerucinae/

#load necessary packages

module load shared 2021
conda activate transcriptomics



GENOME=$(sed -n ${SLURM_ARRAY_TASK_ID}p ../genomes)


trimmomatic PE -threads ${SLURM_NPROCS} -trimlog ${GENOME}-trimmomatic.log ${GENOME}_1.fastq.gz ${GENOME}_2.fastq.gz ${GENOME}_1_trimmedpaired.fastq.gz ${GENOME}_1_trimmedunpaired.fastq.gz ${GENOME}_2_trimmedpaired.fastq.gz ${GENOME}_2_trimmedunpaired.fastq.gz ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
