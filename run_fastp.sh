#!/bin/bash

for r1 in *_R1.fq.gz
do
    sample=${r1%_R1.fq.gz}

    echo "Processing ${sample} at $(date)"

    fastp \
        -i ${sample}_R1.fq.gz \
        -I ${sample}_R2.fq.gz \
        -o fastp/${sample}_R1.trimmed.fq.gz \
        -O fastp/${sample}_R2.trimmed.fq.gz \
        -h fastp/${sample}.html \
        -j fastp/${sample}.json \
        --thread 16

    echo "Finished ${sample} at $(date)"
done
