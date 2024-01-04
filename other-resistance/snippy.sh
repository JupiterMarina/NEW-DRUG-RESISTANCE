
results="/media/jupiter/Marina/wilson/results"
reads="/home/jupiter/Desktop/combined"
mkdir -p ${results}/snippy

#bwa index -p H37INDEX -a is /media/jupiter/Marina/wilson/NC_000962.3.fasta ###indexes the reference genome


for sample in `cat /home2/fekakembo/marina/left.txt`
do

    mkdir -p ${results}/snippy/${sample}

    snippy --cpus 5 --ram 5 --reference /media/jupiter/Marina/wilson/NC_000962.3.fasta\
	   --R1 /media/jupiter/Marina/NTRL/PTRUN/TB-READS/${sample}_R1.fastq.gz\
	   --R2 /media/jupiter/Marina/NTRL/PTRUN/TB-READS/${sample}_R1.fastq.gz\
	   --outdir  ${results}/snippy/${sample} --force\
	   --prefix ${sample}
    done 
    
    #snippy-core --ref /media/jupiter/Marina/wilson/NC_000962.3.fasta\
		

done

 # 
#--bam ${results}/bam/${sample}_sorted.bam --force\
