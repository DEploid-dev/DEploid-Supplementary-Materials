## BEAGLE

First convert the VCF to `BEAGLE` input format

```bash
./convert_pf3k_vcf_to_beagle_input.py labMixed.vcf.gz
```

To deconvolute with `BEAGLE`:

```bash
java  -Xmx3512m -jar ~/researchDiary/beagle/beagle.r1398.jar gl=labMixed.gl.vcf.gz out=labMixed.gl.out
```

