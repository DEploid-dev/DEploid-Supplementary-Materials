## SHAPEIT

This directory contains code to infer strain haplotypes of mixed *Plasmodium falciparum* samples using [O'Connell *et al.* (2014)](#shapit)'s method.

To use `SHAPEIT`, we first split the VCF file by chromosome IDs. Each file contains SNPs of the 27 lab mixed samples. The field `FORMAT` specifies the information of each sample at every site (row), which can be `GT:AD:DP:GQ:PL` or `GT:AD:DP:GQ:PGT:PID:PL`. Regardless which format it uses, it must include the attribute `GT`, which specifies the genotype of the site. `SHAPEIT` uses the `GT` information, and phase the sequence. Note that the genotypes are inferred by GATK Best Practices ([DePristo *et al.* 2011](#gatk)).

```bash
tabix labMixed.vcf.gz
cp labMixed.vcf.gz lab.vcf.gz
gunzip -df lab.vcf.gz
head -n 10000 lab.vcf | grep "^#" >header

#split into chunks by chromosome
grep -v "^#" lab.vcf | cut -f 1 | sort | uniq | while read i;do
cat header > $i.vcf
tabix labMixed.vcf.gz $i >> $i.vcf
done
rm -f header
```

On the cluster, do the following to get the haplotypes for each sample.

```bash
while read chr; do echo ${chr}; /apps/well/shapeit/2.r790/shapeit -V tmp/${chr}.vcf -O tmp/${chr}; done < chromID

while read chr; do echo ${chr}; cat ${chr}.haps >> shape2.haps; done < chromID
```
Once the sequence data is phased, we use the following command to separate the haplotypes by samples.

```bash
cut -d ' ' -f 1,3,6,7 shape2.haps > PG0389-C.haps
cut -d ' ' -f 1,3,8,9 shape2.haps > PG0390-C.haps
cut -d ' ' -f 1,3,10,11 shape2.haps > PG0391-C.haps
cut -d ' ' -f 1,3,12,13 shape2.haps > PG0392-C.haps
cut -d ' ' -f 1,3,14,15 shape2.haps > PG0393-C.haps
cut -d ' ' -f 1,3,16,17 shape2.haps > PG0394-C.haps
cut -d ' ' -f 1,3,18,19 shape2.haps > PG0395-C.haps
cut -d ' ' -f 1,3,20,21 shape2.haps > PG0396-C.haps
cut -d ' ' -f 1,3,22,23 shape2.haps > PG0397-C.haps
cut -d ' ' -f 1,3,24,25 shape2.haps > PG0398-C.haps
cut -d ' ' -f 1,3,26,27 shape2.haps > PG0399-C.haps
cut -d ' ' -f 1,3,28,29 shape2.haps > PG0400-C.haps
cut -d ' ' -f 1,3,30,31 shape2.haps > PG0401-C.haps
cut -d ' ' -f 1,3,32,33 shape2.haps > PG0402-C.haps
cut -d ' ' -f 1,3,34,35 shape2.haps > PG0403-C.haps
cut -d ' ' -f 1,3,36,37 shape2.haps > PG0404-C.haps
cut -d ' ' -f 1,3,38,39 shape2.haps > PG0405-C.haps
cut -d ' ' -f 1,3,40,41 shape2.haps > PG0406-C.haps
cut -d ' ' -f 1,3,42,43 shape2.haps > PG0407-C.haps
cut -d ' ' -f 1,3,44,45 shape2.haps > PG0408-C.haps
cut -d ' ' -f 1,3,46,47 shape2.haps > PG0409-C.haps
cut -d ' ' -f 1,3,48,49 shape2.haps > PG0410-C.haps
cut -d ' ' -f 1,3,50,51 shape2.haps > PG0411-C.haps
cut -d ' ' -f 1,3,52,53 shape2.haps > PG0412-C.haps
cut -d ' ' -f 1,3,54,55 shape2.haps > PG0413-C.haps
cut -d ' ' -f 1,3,56,57 shape2.haps > PG0414-C.haps
cut -d ' ' -f 1,3,58,59 shape2.haps > PG0415-C.haps
```

### References
O'Connell J, Gurdasani D, Delaneau O, Pirastu N, Ulivi S, et al. (2014) A General Approach for Haplotype Phasing across the Full Spectrum of Relatedness. *PLOS Genetics* 10(4): e1004234. doi: 10.1371/journal.pgen.1004234 <a name="shapit"></a>

DePristo M, Banks E, Poplin R, Garimella K, Maguire J, Hartl C, Philippakis A, del Angel G, Rivas MA, Hanna M, McKenna A, Fennell T, Kernytsky A, Sivachenko A, Cibulskis K, Gabriel S, Altshuler D, Daly M. (2011) A framework for variation discovery and genotyping using next-generation DNA sequencing data. *Nature genetics* 43:491-498 <a name="gatk"></a>
