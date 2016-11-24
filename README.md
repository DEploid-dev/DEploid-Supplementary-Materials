# DEploid-Supplementary-Materials

Raw data can be find at [ftp://ngs.sanger.ac.uk/production/pf3k/release_5/5.1/](ftp://ngs.sanger.ac.uk/production/pf3k/release_5/5.1/). The dataset contains both indels and SNPs for all Pf3k samples. Variant data are seperated by chromosomes. The program DEploid does not handle INDELs nor multi-allelic variants. We therefore filter the data with the following command, and create a "high quality bialleic SNP" data set for chromosomes 1 to 14.

```bcftools view \
--include 'FILTER="PASS"' \
--min-alleles 2 \
--max-alleles 2 \
--types snps \
--output-file SNP_INDEL_Pf3D7_${chromNum}_v3.high_quality_biallelic_snps.vcf.gz \
--output-type z \
SNP_INDEL_Pf3D7_${chromNum}_v3.combined.filtered.vcf.gz
```

We use `vcf-subset` to select the 27 lab mixed samples (DEploid paper Table 2 for the full list) for each chromosomes. The files are then concatenated, and splited by sample names, to get files `PG0395-C.wg.vcf.gz`, `PG0396-C.wg.vcf.gz`, `PG0415-C.wg.vcf.gz` and etc.

We use the read count of the 27 lab samples to calculate the population level allele frequencies, and save in a text file `labStrains_PLAF.txt`. The file `labStrainsExclude.txt` provides a list of variant sites which has population level allele frequencies as zeros.

We use method described in DEploid paper section "Validation and Performance" to infer genotypes of strains 3D7, Dd2, HB3 and 7G8, and combine four haplotypes in file `labStrainsPanelFinal.txt`.

