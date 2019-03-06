# This script will parse gene inheritance information from
# omim genemap2.txt ( https://data.omim.org/downloads/WLpOojuyTTeoemLvEh7khg/genemap2.txt)
# and will parse HGNC approved symbols downloaded from https://www.genenames.org/ 
# to create an omim gene inheritance annotation file.  

#load the libraries.

library(tidyverse)

#import omim genemap2.txt from working directory.

genemap2 <- read.delim(file="genemap2.txt", header = TRUE, skip = 3)

#Select data lines and required columns. And extract words describing inheritance.
gm1 <- genemap2[1:16866, ] %>% 
  select(1,2,3,7,13) %>% 
  mutate(Inheritance1 = str_extract(Phenotypes, "Autosomal recessive")) %>% 
  mutate(Inheritance2 = str_extract(Phenotypes, "Autosomal dominant")) %>% 
  mutate(Inheritance3 = str_extract(Phenotypes, "X-linked")) %>%
  mutate(Inheritance4 = str_extract(Phenotypes, "Digenic recessive"))

# Remove NAs from columns 6 to 9.
gm2 <- as.matrix(gm1) 
indx <- which(is.na(gm2[, 6])==TRUE) 
gm2[indx, 6] = "" 
gm2  <-  data.frame(gm2) 

gm2 <- as.matrix(gm2) 
indx <- which(is.na(gm2[, 7])==TRUE) 
gm2[indx, 7] = "" 
gm2 = data.frame(gm2)

gm2 <- as.matrix(gm2) 
indx <- which(is.na(gm2[, 8])==TRUE) 
gm2[indx, 8] = "" 
gm2 = data.frame(gm2)

gm2 <- as.matrix(gm2) 
indx <- which(is.na(gm2[, 9])==TRUE) 
gm2[indx, 9] = "" 
gm2 = data.frame(gm2)

#Unite columns 6,7,8,9
gm3 <- unite(gm2, Inheritance, c(6,7,8,9), sep= "")

#substitute spaces and add a separator 

gm3$Inheritance <- gsub("([a-z])([A-Z])", "\\1 | \\2", gm3$Inheritance)


#unnest multiple gene symbols into rows. 
gm4 <- gm3 %>% mutate(Gene.Symbols = strsplit(as.character(Gene.Symbols), ",")) %>% 
  unnest(Gene.Symbols)

# import HGNC gene table from working directory

hgnc_genes <- read.delim(file='hgnc_genes.txt', header=TRUE)

# select gene symbol and aliases. 
hgnc_gs <- select(hgnc_genes, 2,9)

#change column names to match with gm4$Gene.Symbols
colnames(hgnc_gs) <- c("Gene.Symbols", "Aliases")

# right join to get the match between hgnc approved symbols and gm4$Gene.Symbols
gm5 <- gm4 %>% right_join(hgnc_gs, by = "Gene.Symbols")

# Final table, sort, clean etc.
omim_gene_inheritance <- gm5[order(gm5$Chromosome, gm5$Genomic.Position.Start), ] %>% 
  filter(Inheritance != "") %>% 
  select(1,2,3,6,5,4)

#Save output

write_tsv(omim_gene_inheritance, "omim_gene_inheritance.tsv")


