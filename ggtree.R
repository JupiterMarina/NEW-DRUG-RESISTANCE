library(ggtree)
library(ggplot2)
library(dplyr)



meta <- read.csv(file="/home/jupiter/Downloads/Documents/meta.csv", header=TRUE, sep = ",")
Sample_ID <- paste(meta$STUDYCODE, meta$LABNO, sep="")
meta[,1] <- Sample_ID
meta <- rename(meta, Sample_ID=LABNO)
k=meta$SEQRESULT=="Results Available"
meta <- meta[k,]
dim(meta)

tree3 <- read.tree("/media/jupiter/Marina/wilson/phylogenetics/trees/T5.raxml.bestTree")
tree3$tip.label # gets the tree tip samples

tree3$tip.label  %in%  meta$Sample_ID

# The %<+% operator is used to connect the sample_data data frame to the tree file

ggtree(tree3, branch.length = "none", layout="circular", size=2) %<+% meta +
  aes(color=Region) + ggtitle("Case distribution by Region") + geom_tiplab(offset=0.5, size=3) +
  theme(legend.key.height = unit(1, "cm"), legend.key.width =unit (2, "cm"), legend.position = "right", 
        legend.text=element_text(size=rel(2))) + geom_rootpoint()

ggsave(file="/media/jupiter/Marina/wilson/phylogeny-R/circular-region.png", width=20, height=15, dpi=500)




ggtree(tree3, branch.length = "none", layout="circular", size=2) %<+% meta +
  aes(color=Region) + ggtitle("phylogenetic tree showing lineages") + geom_tiplab(offset=0.5, size=4) +
  theme(legend.key.height = unit(1, "cm"), legend.key.width =unit (2, "cm"), legend.position = "right", 
        legend.text=element_text(size=rel(2)))

ggsave(file="/media/jupiter/Marina/wilson/phylogeny-R/circular-lineage.png", width=20, height=15, dpi=500)










  
ggtree(tree3, branch.length = "none", layout="circular") %<+% meta +
  aes(color=Region) + ggtitle("phylogenetic tree showing case distrubution per region")

ggtree(tree3, branch.length = "none", layout="circular") %<+% meta +
  aes(color=Sex) + ggtitle("phylogenetic tree showing case distribution per gender") +
  geom_tiplab #+ theme()

  
  
ggtree(tree3, branch.length = "none", layout="circular") %<+% meta +
    aes(color=Sex) + geom_tiplab() + labs(title ="phylogenetic tree showing case distribution per gender" ) + theme(plot.title = element_text(size = rel(2)), legend.position = "bottom")

ggsave(file="/media/jupiter/Marina/wilson/phylogeny-R/gender2.png", width=15, height=15, dpi=500)
#creating heatmaps






lineage=data.frame(meta[,"LINEAGE"],row.names = meta$Sample_ID)

p <- ggtree(tree3, branch.length='none') %<+% meta + 
  theme(
    legend.position = "bottom",
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    plot.title = element_text(
      size = 12,
      face = "bold",
      hjust = 0.5,
      vjust = -15)) + labs(title = "resistance")

p

gheatmap(p, lineage, offset = 2, width=0.5)
ggsave(file="/media/jupiter/Marina/wilson/phylogeny-R/lineage.png", width=15, height=25, dpi=500)


p

drugs <- meta[, c("rifampicin", "isoniazid", "ethambutol", "streptomycin", "moxifloxacin", "pyrazinamide")]
drugs <- data.frame(drugs, row.names = meta$Sample_ID)

drugs <- rename(drugs, R=rifampicin,
       I=isoniazid, E=ethambutol, S=streptomycin,
       M=moxifloxacin,
       P=pyrazinamide)
#drugs <- rename(drugs, rif=rifampicin,
 #               inh=isoniazid, eth=ethambutol, str=streptomycin,
  #              mox=moxifloxacin,
   #             prz=pyrazinamide)


gheatmap(p, drugs, offset = 3, width=0.8)
ggsave(file="/media/jupiter/Marina/wilson/phylogeny-R/heat.png", width=15, height=25, dpi=500)

gzoom(p, )





lin <- levels(meta$LINEAGE)
h1 <-  gheatmap(p, lineage,                                 # we add a heatmap layer of the gender dataframe to our tree plot
                offset = 10,                               # offset shifts the heatmap to the right,
                width = 0.10,                              # width defines the width of the heatmap column,
                color = NULL,                              # color defines the boarder of the heatmap columns
                colnames = FALSE) +                               # hides column names for the heatmap
  scale_fill_manual(name = "Lineage", 
                    values = c("red", "purple","blue", "orchid3"
                               , "green", "darkorchid", "pink") ,              # define the coloring scheme and legend for gender
                    breaks = lin,
                    labels = lin ) +
  theme(legend.position = "bottom",
        legend.title = element_text(size = 12),
        legend.text = element_text(size = 10),
        legend.box = "vertical", legend.margin = margin())

h1










tree2 <- read.tree("/media/jupiter/Marina/wilson/phylogenetics/core-genes/T3.raxml.bestTree")
tree1 <- read.tree(file="/media/jupiter/Marina/wilson/phylogenetics/core-genes/T3.raxml.bestTree")
tree1 <- read.tree(file="/media/jupiter/Marina/wilson/phylogenetics/core-genes/T3.raxml.bestTree")
tree1
ggtree(tree2,branch.length="none",layout = "circular") + geom_tiplab() + geom_tippoint()

ggtree(tree1) + geom_tiplab() # adds labels to the tips
ggtree(tree1) + geom_tiplab() + geom_tippoint() # adds tip points 

ggtree(tree1, layout="circular") + ggtitle("(Phylogram) circular layout")
