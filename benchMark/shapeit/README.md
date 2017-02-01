## SHAPEIT

To use `SHAPEIT`, we split the VCF file by chromosome IDs

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
