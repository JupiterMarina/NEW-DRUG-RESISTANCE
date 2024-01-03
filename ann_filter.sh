
###BUILDING A DATABASE FOR MYCOBACTERIUM TUBERCULOSIS#####

#config="/home/jupiter/Downloads/Compressed/snpEff_latest_core/snpEff"

directory="/media/jupiter/marina/wilson"

mkdir -p ${directory}/snpeff

#cp  ${config}/snpEff.config ${directory}/snpeff  ## makes a copy of the configuration file

mkdir -p ${directory}/snpeff/data/Mycobacterium_tuberculosis_str_H37Rv

mkdir -p ${directory}/snpeff/data/genomes

echo "Mycobacterium_tuberculosis_str_H37Rv.genome : Mycobacterium tuberculosis  str. H37Rv, complete genome" >> ${directory}/snpeff/snpEff.config


echo "    Mycobacterium_tuberculosis_str_H37Rv.chromosomes : NC_000962.3" >> ${directory}/snpeff/snpEff.config

echo "    Mycobacterium_tuberculosis_str_H37Rv.NC_000962.3.codonTable : Bacterial_and_Plant_Plastid" >>${directory}/snpeff/snpEff.config


cd ${directory}/snpeff/data/genomes


mv GCF_000195955.2_ASM19595v2_genomic.fna Mycobacterium_tuberculosis_str_H37Rv.fa


mv GCF_000195955.2_ASM19595v2_genomic.gff3 ../Mycobacterium_tuberculosis_str_H37Rv/genes.gff3


cp  ${directory}/snpeff/data/genomes/Mycobacterium_tuberculosis_str_H37Rv.fa ${directory}/snpeff/data/Mycobacterium_tuberculosis_str_H37R/sequences.fa



snpEff build -gff3 -c /media/jupiter/marina/wilson/snpeff/snpEff.config -v Mycobacterium_tuberculosis_str_H37Rv


#####snpeff to annotated vcf files dowmloaded from the server


results="/media/jupiter/Marina/project-msbt"

mkdir -p ${results}/annotated_vcfs

#config="/home/jupiter/Downloads/Compressed/snpEff_latest_core/snpEff"

for sample in `cat /media/jupiter/Marina/project-msbt/list.txt`
do

    snpEff ann  -no-downstream -no-upstream\
	   -no-utr -no-intron -o vcf\
	   -c /media/jupiter/Marina/wilson/reference/snpEff.config\
	   Mycobacterium_tuberculosis_str_H37Rv\
	   ${results}/vcfs/${sample}.vcf  >  ${results}/annotated_vcfs/${sample}_ann.vcf
done


#### The next step is filtering out of Variants in genes involved in Bedaquiline, Linezolid, Clofazimine, Delamanid and Pretomanid, refer to genes.txt for a full list of genes 



ann="/media/jupiter/Marina/project-msbt/annotated_vcfs"

mkdir -p /media/jupiter/marina/project-msbt/annotated_vcfs/linezolid

cd /media/jupiter/marina/project-msbt/annotated_vcfs/linezolid

mkdir -p ${ann}/filtered/


#echo -e POS\\tID\\tREF\\tALT\\tINFO\\tSAMPLE_ID > ${ann}/filtered/header.txt

echo -e GENE\\tVariantTYPE\\tDNAchange\\tAAchange\\tANNOTATION\\tAnno.Impact\\tSample_ID > ./header.txt

for gene in `cat /media/jupiter/marina/project-msbt/genes.txt`
do
    for sample in `cat /media/jupiter/marina/NTRL/PTRUN2022/list.txt`

    do
	if grep -v "##\|synonymous_variant" ${ann}/${sample}_ann.vcf | grep -E "${gene}"

	then

	    sed -n "/\<${gene}\>/w ./filtered.txt"  ${ann}/${sample}_ann.vcf

	    nu=`cat ./filtered.txt | wc -l`

	    for i in `seq $nu`; do echo $sample >> sample_id; done


	    cat ./filtered.txt | cut -f 8 | cut -d "|" -f 1  | cut -d ";" -f 41 | cut -d "=" -f 2  > type
	    
	    cut -f 8 ./filtered.txt | cut -d "|" -f 4  > Gene
	    cut -f 8 ./filtered.txt | cut -d "|" -f 10  > dna
	    cut -f 8 ./filtered.txt | cut -d "|" -f 11  > protein
	    cut -f 8 ./filtered.txt | cut -d "|" -f 2  > ann
	    cut -f 8 ./filtered.txt | cut -d "|" -f 3  > ann1
 
            paste  Gene type dna protein ann ann1    >> ./holder1.txt

	fi
    done

done

#paste ./holder1.txt sample_id >> ./holder1.txt

cat ./header.txt ./holder1.txt >> ./final.txt
