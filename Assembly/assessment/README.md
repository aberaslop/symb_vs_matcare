# Symbiosis vs maternal care
## 1. Assembly
### 1.4. Assessment

1. `submit_assessment.sh` - submits `quast.sh` (QUAST), `busco.sh` (BUSCO) and `blast.sh` (BLAST) scripts for assembly quality statistics. `busco.sh` requires the Hypocreales BUSCO dataset downloaded from here.
2. `sbatch blobtools.sh` - submits `blobtools.sh` to run BlobTools (must be done after `blast.sh` has finished for all strains.

