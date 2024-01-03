# RESISTANCE ASSSOCIATED VARIANTS DETECTION PIPELINE
This project basically involved identification of Variants in genes implicated in resistance to new anti-TB drugs (Bedaquiline, linezolid, Clofazimine, Delamanid and Pretomanid) from TB  Whole genome sequences.  The samples were over 190 and they were collected in a national wide drug resistance survery. 
In full_pipeline.sh, the samples are trimmed using trimmomatic, then aligned to the H37Rv reference genome using BWA mem algorithm creating sam files. These sam files are then processed using samtools creating sorted bam files that are used as input for the variant calling software freebayes.
In ann_filter.sh, snpEff is used to annotate the vcf files from freebayes and a custom made script is used to filter out variants in genes so far implicated in resistance to these drugs. 
Further analysis is done in R and Python
