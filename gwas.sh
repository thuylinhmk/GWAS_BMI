#!/bin/bash


#PCA calculation
/data/STAT3306/plink --bfile data_file/data_final --pca 10 --out pca
#gwas no pca
/data/STAT3306/plink --bfile data_file/data_final --assoc --pheno ../Pdata/BMI.phen --out gwas_result/gwas_bmi_no_pca
#gwas with pca
/data/STAT3306/plink --bfile data_file/data_final --linear --covar pca.eigenvec --pheno ../Pdata/BMI.phen --out gwas_result/bmi_gwas_pca
#gwas with pca and adjust
/data/STAT3306/plink --bfile data_file/data_final --adjust \
--linear --covar pca.eigenvec --pheno ../Pdata/BMI.phen \
--out gwas_result/bmi_gwas_pca_adjus
#gwas binary trait1
/data/STAT3306/plink --bfile data_file/data_final --adjust \
--logistic --covar pca.eigenvec --pheno ../Pdata/BMI_bin1_recode.phen \
--out gwas_result/binary1/b1_gwas
#gwas binary trait2
/data/STAT3306/plink --bfile data_file/data_final --adjust \
--logistic --covar pca.eigenvec --pheno ../Pdata/BMI_bin2_recode.phen \
--out gwas_result/binary2/b2_gwas
