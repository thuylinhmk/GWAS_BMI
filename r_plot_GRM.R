library(OmicKriging)
#plot grm data
grm <- read_GRMBin("test_GCTAresult.grm")
names(grm) <- c("IND_1", "IND_2", "SNP_NUM", "REL")
dim(grm)
grm.diag <- diag(grm)
head(grm.diag)
grm.off.diag <- grm[upper.tri(grm)]
#save png
pdf("GRM_diagonals.pdf")
hist(grm.diag, breaks = 2500, freq = F, xlab = "GRM diagonals", xlim = c(0.95, 1.2), main = "")
dev.off()
pdf("GRM_off_diagonals.pdf")
par(mfrow = c (1,1))
hist(grm.off.diag, breaks = 2500, freq = F, xlab = "GRM off-diagonals", main = "")
#plot of any related relationship
hist(grm.off.diag[which(grm.off.diag > 0.05)], breaks = 200, freq = F, xlab = "GRM off-diagonals", xlim = c(0.05, 0.125), main = "")
hist(grm.off.diag[which(grm.off.diag > 0.025)], breaks = 200, freq = F, xlab = "GRM off-diagonals", xlim = c(0.025, 0.125), main = "")

#load grm result
nr_bmi <- read.table("nr_bmi.hsq", h=T, fill=T)
nr_bin1 <- read.table("nr_binary1.hsq", h=T, fill=T)
nr_bin2 <- read.table("nr_binary2.hsq", h=T, fill=T)
nr_bmi
nr_bin1
nr_bin2

#load mgrm
mgrm_bmi <- read.table("multi_grm/multi_grm_test_bmi.hsq", h=T, fill=T)
mgrm_bin1 <- read.table("multi_grm/multi_grm_test_binary1.hsq", h=T, fill=T)
mgrm_bin2 <- read.table("multi_grm/multi_grm_test_binary2.hsq", h=T, fill=T)
mgrm_bmi
mgrm_bin1
mgrm_bin2
