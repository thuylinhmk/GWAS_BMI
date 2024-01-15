# GWAS
GWAS analysis with bash scripts/ command lines to run on HPC and r scripts

## Introduction
Body mass index (BMI) is a common measure of obesity and refer to excess body weight, which can be a risk factor for many diseases and chronic conditions. BMI can be considered a complex trait which is highly polygenic. Genome-wide association study (GWAS) can screen the entire genome of larger numbers of individuals to look for association between genetic variants within individuals and their disease traits or quantitative traits, which is a good model for finding potential genetic region with highly statistically significant associations. In this project, GWAS was conducted including more than 11 000 individuals is conducted for BMI and 2 binary traits to assess the contribution of single-nucleotide polymorphisms (SNPs). Hence, we can disclose some loci associated with these phenotypes of interest and determine their common associations.

## Method

Genome-wide variant data in real genotype data from the UK Biobank study was provided in binary files .bed, .bim and .fam for total 11793 individuals and more than 298 000 variants across 22 chromosomes (not including sex chromosomes).
The data for BMI and two binary traits were recorded in different files. In the binary trait’s files, case phenotype is assigned with ‘1’ and control is assigned with ‘0’. In order to match the encode system of PLINK, all control samples’ annotations are changed to ‘2’ before preforming GWAS with PLINK. Binary trait 2 has 5893 NA values which will be marked as missing values while running GWAS with PLINK

## Software

PLINK version 1.9 is used for whole-genome association analyses

## Workflow
1. Quality control
2. GWAS
3. R script: QC, Visualization
4. GRM

