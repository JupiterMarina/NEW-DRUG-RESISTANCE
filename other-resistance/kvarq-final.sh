

path="/media/jupiter/Marina/wilson"


for i in `/media/jupiter/Marina/wilson/results/annotated_vcfs/filtered/list.txt`
do
    kvarq scan -t 6 -Q 15 -l MTBC \
	  ${path}/trim/${i}_1P.fastq.gz \
	  ${path}/results/${i}.json


    sed 's/,/\t/g' ${path}/results/${i}.csv | cut -f1,2,3,4,13 | sed 's/"//g' > ${path}/results/${i}.txt


    echo -e "sample \t \t drug \t susceptibilty \t Mtb-Lineage " > ${path}/results/holder.txt

    cut -f1,2,3,5 ${path}/results/${i}.txt  >> ${path}/results/holder.txt

    sed -i '2d' ${path}/results/holder.txt

    echo >> ${path}/results/holder.txt

    echo  " Variants discovered by Mykrobe " >> ${path}/results/holder.txt

    cut -f4 ${path}/results/${i}.txt >> ${path}/results/holder.txt

    echo >> ${path}/results/holder.txt

    echo " Results from Kvarq " >> ${path}/results/holder.txt

    kvarq illustrate -r ${path}/results/${i}.json  >> ${path}/results/holder.txt


    kvarq illustrate -l ${path}/results/${i}.json  | echo "The coverage for this sample is `grep "^totaling"`" >>  ${path}/results/holder.txt

    enscript ${path}/results/holder.txt --output=- | ps2pdf - > ${path}/results/final/${i}.pdf

done
