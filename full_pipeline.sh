#!/bin/bash

#SBATCH --job-name=full_pipeline 
#SBATCH --nodes=1
#SBATCH --cpus-per-task=16
#SBATCH --output=./%J_full_pipeline.log
#SBATCH --error=./%J_full_pipeline.err


results="/etc/ace-data/home/jkabahita/project/results"
reads="/etc/ace-data/home/jkabahita/project/reads"

mkdir -p ${results}/trim
mkdir -p ${results}/bam
mkdir -p ${results}/vcfs
mkdir -p ${results}/annotated_vcfs

bwa index -p H37INDEX -a is /etc/ace-data/home/jkabahita/project/NC_000962.3.fasta ###indexes the reference genome


for sample in `cat /etc/ace-data/home/jkabahita/project/list.txt`
do
    echo "now running trimmomatic"
    

    if trimmomatic PE -threads 16 ${reads}/${sample}_*R1* ${reads}/${sample}_*R2*\
		   -trimlog trim.log -baseout ${results}/trim/${sample}.fastq.gz\
		   ILLUMINACLIP:/media/jupiter/Marina/wilson/Sequencing_adaptors.fasta:2:30:10\
		   LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
    then
	rm ${results}/trim/${sample}_1U.fastq.gz ${results}/trim/${sample}_2U.fastq.gz
    fi

     echo "now running bwa align"


    bwa mem H37INDEX\
	${results}/trim/${sample}_1P.fastq.gz\
    	${results}/trim/${sample}_2P.fastq.gz  > ${results}/bam/${sample}.sam


    echo "now running samtools"

    

    if samtools view -h -b -@ 16  ${results}/bam/${sample}.sam -o ${results}/bam/${sample}.bam &&\
	    samtools sort ${results}/bam/${sample}.bam -o ${results}/bam/${sample}_sorted.bam -O bam -@ 16
    then
	rm  ${results}/bam/${sample}.sam
	rm  ${results}/bam/${sample}.bam
    fi
    
    
    samtools index ${results}/bam/${sample}_sorted.bam -@ 16

    echo "now running freebayes"


    freebayes -b ${results}/bam/${sample}_sorted.bam  -f /etc/ace-data/home/jkabahita/project/NC_000962.3.fasta\
	      -v ${results}/vcfs/${sample}.vcf -p 1\
	      -q 15 --min-coverage 10


done

 
	


