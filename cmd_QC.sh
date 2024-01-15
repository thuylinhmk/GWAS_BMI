#!/bin/bash

#snp filtering
#missing genotype -> missing geno (imiss), low genotyping snp (lmiss)
/data/STAT3306/plink --bfile ../Pdata/test --missing --out missing_ind
#Hardy-Weinberg equilibrium
/data/STAT3306/plink --bfile ../Pdata/test --hardy --out hwe_table
#low frequency minor allele
/data/STAT3306/plink --bfile ../Pdata/test --freq --out frequecie
# create a file with R containing SNPs need to be removed from above steps
#filter snps with strong correlations (prune.out to filter out)
/data/STAT3306/plink --bfile ../Pdata/test --indep-pairwise 50 5 0.2 --out data_IBD
#join 2 removed snps file text
cat data_IBD.prune.out >> remove_snp.txt
#remove snps
/data/STAT3306/plink --bfile ../Pdata/test --make-bed --exclude remove_snp.txt --out data_qc1
##############
#sample filtering
#missing genotype -> .imiss file
#outlying homosygosity values
/data/STAT3306/plink --bfile ../Pdata/test --het --out het_filter
#gender check
#no chromosome 23/X/Y -> no variance on sex chromosomes -> skip
#IBS check for samples duplicate or related samples
/data/STAT3306/plink --bfile data_qc1 --genome --out data_IBS
#using R to filtered samples: missing > 5%, outlying > 5%, ibs with PI_HAT > 0.1875 (non)
#remove samples
/data/STAT3306/plink --bfile data_qc1 --make-bed --remove remove_samples.txt --out data_final
