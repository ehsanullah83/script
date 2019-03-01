
#import omim genemap2.txt

gm0 <- read_tsv(file="~/Desktop/genemap2.tsv")

#Select data lines and required columns to omit metadata information.
gm1 <- gm0[1:16866, ] %>% select(7,9,13)

#Extract Inheritance patterns from column Phenotypes.
gm3 <- gm1 %>% 
  mutate(Inheritance1 = str_extract(Phenotypes, "Autosomal recessive")) %>% 
  mutate(Inheritance2 = str_extract(Phenotypes, "Autosomal dominant")) %>% 
  mutate(Inheritance3 = str_extract(Phenotypes, "X-linked")) %>%
  mutate(Inheritance4 = str_extract(Phenotypes, "Digenic recessive"))


# Remove NAs from columns 4 to 7.
gm4 <- as.matrix(gm3) 
indx <- which(is.na(gm4[, 4])==TRUE) 
gm4[indx, 4] = "" 
gm4 = data.frame(gm4) 

gm4 <- as.matrix(gm4) 
indx <- which(is.na(gm4[, 5])==TRUE) 
gm4[indx, 5] = "" 
gm4 = data.frame(gm4)

gm4 <- as.matrix(gm4) 
indx <- which(is.na(gm4[, 6])==TRUE) 
gm4[indx, 6] = "" 
gm4 = data.frame(gm4)

gm4 <- as.matrix(gm4) 
indx <- which(is.na(gm4[, 7])==TRUE) 
gm4[indx, 7] = "" 
gm4 = data.frame(gm4)

#Unite
gm5 <- unite(gm4, Inheritance, c(4,5,6,7), sep= "")

gm5$Inheritance <- gsub("([a-z])([A-Z])", "\\1 | \\2", gm5$Inheritance)

