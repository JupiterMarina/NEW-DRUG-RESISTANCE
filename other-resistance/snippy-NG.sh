#!/bin/bash

#SBATCH --job-name=NeisseriaG
#SBATCH --nodes=1
#SBATCH --cpus-per-task=16
#SBATCH --output=./%J_NeisseriaG
#SBATCH --error=./%J_NeisseriaG.err

path="/etc/ace-data/home/jkabahita/NG/results"

results="/etc/ace-data/home/jkabahita/NG/results"
reads="/etc/ace-data/home/fkakooza/reads"
mkdir -p ${results}/snippy




for sample in `cat /etc/ace-data/home/jkabahita/NG/list.txt`
do
    if [ -f ${reads}/${sample}*1.fastq.gz ] && [ -f ${reads}/${sample}*2.fastq.gz ]
    then
	mkdir -p ${results}/snippy/${sample}
	read1=`ls ${reads}/${sample}*1.fastq.gz`
	read2=`ls  ${reads}/${sample}*2.fastq.gz`
	snippy --cpus 20  --reference /etc/ace-data/home/jkabahita/NG/CP012026.1.fasta\
	   --pe1 ${read1}\
	   --pe2 ${read2}\
	   --outdir  ${results}/snippy/${sample} --force\
	   --prefix ${sample}
    else
	echo ${sample} >> missing.txt
    fi
    
done

#folder=`ls  -p ${results}/snippy/UG*`
    
#snippy-core ${folder} --ref /etc/ace-data/home/jkabahita/NG/CP012026.1.fasta
		

#snippy --ref ~/marina/GCF_013030075.1_ASM1303007v1_genomic.gbff --outdir ../marina/snippy/ --pe1 ~/Olga_NG/UG325_S96_1.fastq.gz --pe2 ~/Olga_NG/UG325_S96_1.fastq.gz --prefix UG087 --force --cpus 45

#UG428_1.fastq.gz
