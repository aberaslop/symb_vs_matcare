#!/bin/sh
#Script to submit assembly assessment jobs

sbatch quast.sh
sbatch busco.sh
sbatch blast.sh
