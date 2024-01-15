library(ggplot2)
library(dplyr)
library(qqman)
library(data.table)

#quality control
miss_snp <- read.table(‘missing_ind.lmiss’, h=T)
hwe <- read.table(‘hwe_table.hwe’, h=T)
frq <- read.table(‘frequencies.frq’, h=T)
hist(miss_snp$F_MISS > 0.05)\
hist(hwe$P)
hist(frq$MAF)
snp_to_remove = unique(c(which(frq$MAF < 0.01), which(hwe$P < 0.000001), which(miss_snp$F_MISS > 0 0.05)))
file = frq[snp_to_remove, 2]
write.table(file, row.names=FALSE, col.names=FALSE, quote=FALSE, file=’remove_snp.txt’)
######
ibs <- fread(‘data_IBS.genome’)
sum(ibs$PI_HAT > 0.1875) #result = 0 -> no sample to be removed.
miss_ind <- read.table(‘missing_ind.imiss’, h=T)
het <- read.table(‘het_filter.het’, h=T)
hist(miss_ind$F_MISS)
hist(het$F)
plot(abs(het$F))
abline(h=0.05, col=”red”)
sample_to_remove = unique(c(which(abs(het$F) > 0.05), which(miss_ind$F_MISS > 0.05)))
rm_sample = het[sample_to_remove, 1:2]
write.table(rm_sample, row.names=FALSE, col.names=FALSE, file=’remove_samples.txt’)

#PCA
evec = fread(‘pca.eigenvec’)
#visualize PC1 and PC2
ggplot(evec, aes(x=V3, y=V4)) + geom_point() + xlab(“PC1”) + ylab(“PC2”)
eval = fread(‘pca.eigenval’)
eval = mutate(eval, PC=as.factor(c(1:10)))
eval = mutate(evel, PVE=V1/sum(V1))
eval %>% ggplot(aes(x=PC, y=PVE)) + geom_col() + labs(title='Variance explained')

#Q-Q plot
bmi_gwas = read.table(‘bmi_gwas_pca_adjust.assoc.linear’, h=T)
manhattan(bmi_gwas)
qq(bmi_gwas$P)
lambda_gc = qchisq(1-mean(bmi_gwas$P), 1)/qchisq(0.5, 1)
