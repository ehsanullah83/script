#!/bin/bash
#sbatch --time=24:00:00 --partition=gpu --gres=gpu:p100:4 ~/git/scripts/crx_vep_annot.sh
module load VEP
module load samtools
vep -i /data/ullahe2/crx_enhancer_phase-II/Crx_goodpeaks_mm9.narrowPeak_human_grch37_v1_gnomAD_vcfanno.vcf.gz --offline \
--cache --dir_cache $VEPCACHEDIR \
--fasta $VEPCACHEDIR/GRCh37.fa --species human --assembly GRCh37  \
--format vcf \
--output_file /data/ullahe2/crx_enhancer_phase-II/Crx_goodpeaks_mm9.narrowPeak_human_grch37_v1_gnomAD_vcfanno_vep.vcf \
--plugin dbscSNV,$VEPCACHEDIR/dbscSNV1.1.txt.gz \
--plugin GeneSplicer,$GS/bin/genesplicer,$GS/human,context=200 \
--plugin SpliceRegion \
--plugin MaxEntScan,/data/OGVFB/resources/MaxEntScan \
--plugin CADD,/fdb/CADD/1.3/prescored/whole_genome_SNVs.tsv.gz,/fdb/CADD/1.3/prescored/InDels.tsv.gz \
--plugin MPC,/data/OGVFB/OGL_NGS/variant_prioritization/data/MPC/fordist_constraint_official_mpc_values_v2.txt.gz \
--canonical \
--ccds \
--total_length \
--hgvs \
--shift_hgvs 1 \
--sift b \
--polyphen b \
--symbol \
--check_existing \
--numbers \
--biotype \
--total_length \
--pubmed \
--domains \
--gene_phenotype \
--max_af \
{params.pick} \
--fields Allele,Consequence,Codons,Amino_acids,Gene,SYMBOL,Feature,EXON,HGVSc,HGVSp,MAX_AF,MAX_AF_POPS,PolyPhen,SIFT,MPC,Protein_position,BIOTYPE,CANONICAL,DOMAINS,Existing_variation,CLIN_SIG,PICK,PUBMED,Phenotypes,CADD_RAW,CADD_PHRED,GeneSplicer,SpliceRegion,ada_score,rf_score,MaxEntScan_diff \
--vcf --compress_output bgzip --force_overwrite