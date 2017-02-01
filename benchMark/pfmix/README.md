## pfmix

This directory includes code to infer strain proportions ([O’Brien (2016)](#obrien)) for mixed *Plasmodium falciparum* samples. This original implementation can be found on [Github](https://github.com/jacobian1980/pfmix/), minor modification have been made in the file `mixture.funcs.r`.

The directory `altAndRef` contains all the reference and alternative allele counts saved in text files, which consist with three columns: chromosome information, position, and allele counts. To run the analysis, use the following command,

```bash
R --slave "--args sampleName numberOfStrain randomSeed" < run_pfmix.r
```

For example, to infer the strain proportions for sample `PG0389-C`, type

```bash
R --slave "--args PG0389-C 2 1" < run_pfmix.r
```

and the proportions estimate is save in file `PG0389-C.pfmix.prop`.


### References

O’Brien JD, Iqbal Z, Wendler J, Amenga-Etego L (2016) Inferring Strain Mixture within Clinical *Plasmodium falciparum* Isolates from Genomic Sequence Data. *PLOS Computational Biology* 12(6): e1004824. doi: 10.1371/journal.pcbi.1004824 <a name="obrien"></a>