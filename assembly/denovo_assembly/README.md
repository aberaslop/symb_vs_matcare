# Symbiosis vs. maternal care
## 1. Assembly
### 1.2. De novo genome assembly

1. `submit_Assembly.sh` - makes new directory and submits job scripts for each assembly tool - `abyss.sh` (ABySS), `megahit.sh` (MEGAHIT) and `spades.sh` (SPAdes).
2. `abyss_comp.sh` - compares the assembly stats to choose 'best' kmer size for ABySS (must be done after `abyss.sh` has finished for all kmer sizes and genomes.

