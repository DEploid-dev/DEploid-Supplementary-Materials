## COIL

This directory includes code to infer number of parasite strains in mixed *Plasmodium falciparum* samples using [Galinsky *et al.* (2015)](#coil)'s method `COIL`. This method uses genetic barcode as input, which is genotype information, to infer number of strains. First we convert the VCF to `COIL` input format, where we encode heterozygous site as "N", and missing site as ``X''.

```bash
./convert_pf3k_vcf_to_COIL_input.py labMixed.vcf.gz
```

Then submit the barcode file to [COIL](http://portals.broadinstitute.org/infect/malaria/coil//).

### References

Galinsky Kevin, Clarissa Valim, Arielle Salmier, Benoit de Thoisy, Lise Musset, Eric Legrand, Aubrey Faust, Mary Lynn Baniecki, Daouda Ndiaye, Rachel F Daniels, Daniel L Hartl, Pardis C Sabeti, Dyann F Wirth, Sarah K Volkman and Daniel E Neafsey (2015) COIL: a methodology for evaluating malarial complexity of infection using likelihood from single nucleotide polymorphism data. *Malaria Journal* 14:4. DOI: 10.1186/1475-2875-14-4. <a name="coil"></a>
