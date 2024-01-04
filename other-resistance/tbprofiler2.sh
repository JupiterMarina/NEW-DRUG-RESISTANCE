
path="/media/jupiter/marina/NTRL/PTRUN2023/Fastq-REAL"

mkdir -p ${path}/tbprofiler1

#mkdir -p ${path}/renamed

cd  ${path}/tbprofiler1

for i in `cat ${path}/try.txt`
do


   #mv  ${path}/fastq/${i}*_R1.fastq.gz ${path}/renamed/${i}_R1.fastq.gz
    #mv  ${path}/fastq/${i}*_R2.fastq.gz ${path}/renamed/${i}_R2.fastq.gz
    

    tb-profiler profile -t 5 -1  ${path}/fastq/${i}_R1.fastq.gz \
		-2  ${path}/fastq/${i}_R2.fastq.gz\
		-p ${i} --txt

  #  tb-profiler reformat --txt ${path}/tbprofiler1/results/${i}.results.json


done

tb-profiler collate
