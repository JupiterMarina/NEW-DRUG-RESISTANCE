
results="/media/jupiter/Marina/wilson/results"
reads="/media/jupiter/Marina/wilson/downloaded"


#bwa index -p H37INDEX -a is /media/jupiter/Marina/wilson/NC_000962.3.fasta ###indexes the reference genome
mkdir -p ${results}/genotyping


cd ${results}/genotyping

for sample in `cat /media/jupiter/Marina/wilson/downloaded/list.txt`
do

   tb-profiler lineage --bam /media/jupiter/Marina/wilson/results/bam/${sample}_sorted.bam\
    	--prefix ${sample} --outfmt txt --snps

    echo "   " >> ${sample}.lineage.txt

    echo "   " >> ${sample}.lineage.txt

    echo "   " >> ${sample}.lineage.txt

    echo "   " >> ${sample}.lineage.txt



    echo " SNP HITS FOR EACH LINEAGE " >> ${sample}.lineage.txt

    echo "   " >> ${sample}.lineage.txt

    echo " Lineage pos NumberofReads   " >> ${sample}.lineage.txt

    echo "   " >> ${sample}.lineage.txt

    
    cat  ${sample}.lineage.txt ${sample}.lineage.snps.txt > ${sample}_joined.txt

    enscript ${sample}_joined.txt --output=- | ps2pdf - > ${sample}.pdf
done
