## MasigPro
library(maSigPro)
#Set directories and read files
basedir <- "/Users/terezinhasouza/Dropbox/TransQST2/WP8/5-FU_analysis/Mouse/BNI/masigpro/jejunum/"
setwd(basedir)
edesign.file <- paste0(basedir, "meta_example.txt")
data.file <- paste0(basedir, "input_example.txt")
##Read files
edesign <- read.delim(edesign.file, header = T, row.names = 1, check.names = F)
data <- read.delim(data.file, header = T, row.names = 1, check.names = F)

#Set design and run analyses
design <- make.design.matrix(edesign)
#Find significant genes
fit <- p.vector(data, design, counts = T)
#Find significant differences
tstep <- T.fit(fit)
sigs <- get.siggenes(tstep, vars="all")
sigs$summary
#Save genes from different clusters in separate files
test <- see.genes(sigs$sig.genes, k = 4) ##change k for more or less clusters
dev.copy(jpeg,filename="clusters_log.tiff")
dev.off()
clusters <- data.frame(test$cut)
profiles <- merge(sigs$sig.genes$sig.profiles, clusters, by = "row.names")
write.csv(profiles, "clusters.csv", quote = F, row.names = F)

##Plot a gene of interest
gene.interest <- 
  gene <- data[rownames(data)==gene.interest, ]
PlotGroups(gene, edesign = edesign)

