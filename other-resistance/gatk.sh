


results="/media/jupiter/Marina/wilson/results"
reads="/home/jupiter/Desktop/combined"

mkdir ${results}/vcf-fastas
mkdir ${results}/vcf-snps


for sample in `cat /media/jupiter/Marina/wilson/try.txt`
do

    gatk SelectVariants --output ${results}/vcf-snps/${sample}.vcf\
	 --variant  ${results}/vcfs/tz/${sample}.vcf\
	 --create-output-variant-index true --reference /media/jupiter/Marina/wilson/NC_000962.3.fasta\
	 --select-type-to-include SNP
    
    gatk FastaAlternateReferenceMaker -R /media/jupiter/Marina/wilson/NC_000962.3.fasta\
	 -V ${results}/vcf-snps/${sample}.vcf --output ${results}/vcf-fastas/${sample}.fasta


done

	 
