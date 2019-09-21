#!/bin/bash
#sbatch --time=24:00:00 --partition=gpu --gres=gpu:p100:4 ~/git/scripts/crx_enhancer.sh
module load bedtools
bedtools intersect -wa -a /fdb/gnomad/release-2.1/vcf/genomes/gnomad.genomes.r2.1.sites.vcf.bgz -b /data/ullahe2/crx_enhancer_phase-II/Crx_goodpeaks_mm9.narrowPeak_human_grch37_v1.bed -header > /data/ullahe2/crx_enhancer_phase-II/Crx_goodpeaks_mm9.narrowPeak_human_grch37_v1_gnomAD_intersect.vcf
