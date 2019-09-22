#!/bin/bash
output=$1
module load picard
java -Xmx64g -jar $PICARDJARPATH/picard.jar MergeSamFiles I=17_116553.realigned.g1k_decoy.bwa.bam I=17_116553v2.realigned.g1k_decoy.bwa.bam I=17_116553v3.realigned.g1k_decoy.bwa.bam I=17_116553v4.realigned.g1k_decoy.bwa.bam O=${output%.bam}.g1k_decoy.bwa.merged.bam
