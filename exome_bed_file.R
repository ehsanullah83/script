library(tidyverse)
library(stringr)

exome_bed <- read.table(file = file.choose(), header = F, sep = "\t")

exome_bed1 <-  exome_bed %>% 
  select(V1, V2, V3, V4) %>% 
  mutate(gene= str_extract(V4, "\\(.*?\\)")) 
  

head(exome_bed1)         

exome_bed1$gene <- gsub("\\(|\\)", "", exome_bed1$gene)


exome_bed_file <- exome_bed1 %>% select(V1, V2, V3, gene)


write_tsv(exome_bed_file, "~/Desktop/exome_bed_file.txt")
