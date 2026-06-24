#!/bin/bash

INDEX=/pvol/WPM_project/RNA_seq/hisat2_index_bgt/060_bgt
READDIR=/pvol/WPM_project/RNA_seq/fastp
OUTDIR=/pvol/WPM_project/RNA_seq/hisat2/map_bgt
LOGDIR=/pvol/WPM_project/RNA_seq/hisat2/logs

for r1 in ${READDIR}/*_R1.trimmed.fq.gz
do
    sample=$(basename "$r1" _R1.trimmed.fq.gz)

    echo "Processing ${sample} at $(date)"

    hisat2 \
        -p 16 \
        -x ${INDEX} \
        -1 ${READDIR}/${sample}_R1.trimmed.fq.gz \
        -2 ${READDIR}/${sample}_R2.trimmed.fq.gz \
        2> ${LOGDIR}/${sample}.hisat2.log \
    | samtools sort -@ 16 \
        -o ${OUTDIR}/${sample}.sorted.bam

    samtools index ${OUTDIR}/${sample}.sorted.bam

    echo "Finished ${sample} at $(date)"
done
