
## Running trimmomatic and alignment and freebayes

path="/home/jkabahita/tzrun1"

results="${path}/mykrobe"

reads="${path}/trim-results"


 for i in `cat ${path}/list1.txt`
 do
     echo "now running trimmomatic"
     trimmomatic PE -threads 20 -basein ${path}/fastqz/${i}_*_R1_001.fastq.gz \
		 -trimlog trim.log -baseout ${path}/trim-results/${i}-processed.fastq.gz\
		 ILLUMINACLIP:/home/jkabahita/Sequencing_adaptors.fasta:2:30:10\
		 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
     fastqc -o ${path}/trim-results/refastqc  ${path}/trim-results/${i}-processed.fastq.gz



     #########  RUNNING MYKROBE #######

     
     conda activate mykrobe 

     mykrobe predict $sample tb \
	    -1  ${path}/trim-results/${i}-processed_1P.fastq.gz  ${path}/trim-results/${i}-processed_2P.fastq.gz \
	    --format csv --output ${results}/${sample}.csv
     
     conda deactivate


     sed 's/,/\t/g' ${results}/${sample}.csv | cut -f1,2,3,12,13 | sed 's/"//g' > ${results}/${sample}.tab

    # enscript ${results}/${sample}.tab --output=- | ps2pdf - > ${results}/final/${sample}.pfd

 done
  








