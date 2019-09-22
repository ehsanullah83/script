#!/bin/bash
output=$1
module load picard
java -Xmx64g -jar $PICARDJARPATH/picard.jar MergeSamFiles I=MA143_1.realigned.g1k_decoy.bwa.bam I=MA143_1v2.realigned.g1k_decoy.bwa.bam I=MA143_1v3.realigned.g1k_decoy.bwa.bam I=MA143_1v4.realigned.g1k_decoy.bwa.bam I=MA143_1v5.realigned.g1k_decoy.bwa.bam I=MA143_1v6.realigned.g1k_decoy.bwa.bam I=MA143_1v7.realigned.g1k_decoy.bwa.bam I=MA143_1v8.realigned.g1k_decoy.bwa.bam I=MA143_1v9.realigned.g1k_decoy.bwa.bam I=MA143_1v10.realigned.g1k_decoy.bwa.bam I=MA143_1v11.realigned.g1k_decoy.bwa.bam O=${output%.bam}.g1k_decoy.bwa.merged.bam

