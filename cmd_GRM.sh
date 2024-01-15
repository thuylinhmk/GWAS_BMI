#!/bin/bash
#generate grm matrix
/data/STAT3306/gcta --bfile Data_QC/testFiltered --make-grm --autosome --thread-num 5 --out Result/test_GCTAresult
#filter twin
/data/STAT3306/gcta --grm Result/test_GCTAresult --grm-cutoff 0.8 --make-grm --thread-num 5 --out Result/test_no_twin
#filter related
/data/STAT3306/gcta --grm test_no_twin --grm-cutoff 0.05 --make-grm --thread-num 5 --out test_nr

#REML with all SNP
/data/STAT3306/gcta --reml --grm test_nr --pheno ../Phenotypes_QC/BMI_QC.phen --grm-adj 0 --covar ../covariate_sex.covar --qcovar ../covariate_age_pc5.qcovar --thread-num 5 --out nr_bmi
/data/STAT3306/gcta --reml --grm test_nr --pheno ../Phenotypes_QC/BMI_binary1.phen --prevalence 0.01 --covar ../covariate_sex.covar --qcovar ../covariate_age_pc5.qcovar --thread-num 5 --out nr_binary1
/data/STAT3306/gcta --reml --grm test_nr --pheno ../Phenotypes_QC/BMI_binary2.phen --prevalence 0.01 --covar ../covariate_sex.covar --qcovar ../covariate_age_pc5.qcovar --thread-num 5 --out nr_binary2

#separate SNPs in to group 1 and 0
awk '$3==0' Data_QC/annotation.txt > filtered_0.txt
awk '$3==1' Data_QC/annotation.txt > filtered_1.txt
cat filtered_0.txt | cut -f2 -d '"' > filtered_snp_0.txt
cat filtered_1.txt | cut -f2 -d '"' > filtered_snp_1.txt

#generate grm for each SNPs group
/data/STAT3306/gcta --bfile ../Data_QC/testFiltered --extract ../filtered_snp_0.txt --autosome \
--make-grm --keep test_nr.grm.id --thread-num 5 --out test_0
/data/STAT3306/gcta --bfile ../Data_QC/testFiltered --extract ../filtered_snp_1.txt --autosome \
--make-grm --keep test_nr.grm.id --thread-num 5 --out test_1

#create file with name file of grm for running mgrm
echo “test_0” > multi_grm_test.txt
echo “test_1” >> multi_grm_test.txt

#run genomic partition 
/data/STAT3306/gcta --reml --mgrm multi_grm_test.txt –pheno ../Phenotypes_QC/BMI_QC.phen --grm-adj 0 \
--covar ../covariate_sex.covar \
--qcovar ../covariate_age_pc5.qcovar \
--thread-num 5 \
--out multi_grm_test_bmi
/data/STAT3306/gcta --reml --mgrm multi_grm_test.txt --pheno ../Phenotypes_QC/BMI_binary1.phen --prevalence 0.01 \
--covar ../covariate_sex.covar \
--qcovar ../covariate_age_pc5.qcovar \
--thread-num 5 --out multi_grm_test_binary1

/data/STAT3306/gcta --reml --mgrm multi_grm_test.txt --pheno ../Phenotypes_QC/BMI_binary2.phen --prevalence 0.01 \
--covar ../covariate_sex.covar \
--qcovar ../covariate_age_pc5.qcovar \
--thread-num 5 --out multi_grm_test_binary2

#save multi grm results in different directory
mv multi_grm_test_* multi_grm/
