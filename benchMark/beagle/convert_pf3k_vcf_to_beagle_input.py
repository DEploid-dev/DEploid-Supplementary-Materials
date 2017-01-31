#!/usr/bin/env python
# USAGE: convert_pf3k_vcf_to_beagle_v3.py VCFFILE.vcf.gz

import sys
import gzip
from math import log10

def convert_info ( INFO, check_line = "" ):

    splitted_INFO = INFO.split(":")
    allele_freq = [ int(x) for x in splitted_INFO[1].split(",") ]
    ref_freq = allele_freq[0]
    alt_freq = allele_freq[1]
    error_rate = [ .01, .5, .99 ]
    gl_list = [ ( ref_freq * log10(1-x) + alt_freq * log10(x) ) for x in error_rate ]
    max_gl = max (gl_list)
    gl_list = [ round( x, 2 ) for x in gl_list ]
    #0/0:-0.03,-1.21,-5.00

    category = -1
    if ( splitted_INFO[0] == "0/0" ):
        GT = "./."
        category = 0    # REF site
    elif ( splitted_INFO[0] == "0/1" ):
        GT = "./."
        category = 1    # Het site
    elif ( splitted_INFO[0] == "1/1" ):
        GT = "./."
        category = 2    # ALT site
    elif ( splitted_INFO[0] == "./." ):
        GT = "./."  # This is different from ../convert_pf3k_vcf_to_beagle.py
        category = 3    # Missing site
    else:
        print check_line
        raise Exception ( "Undefined GENOTYPE: " + splitted_INFO[0] + ", of " + INFO )

    assert ( category != -1 )  # category must have been assigned with a value

    NEW_INFO = GT + ":" + `gl_list[0]` + "," + `gl_list[1]` + "," + `gl_list[2]`
    return NEW_INFO, category

if __name__ == "__main__":
    #current_VERSION = "." + open("VERSION","r").readline().strip()
    input_file_name = sys.argv[1]
    extra_str = sys.argv[2] if len( sys.argv ) == 3 else ""

    print "Input file : ", input_file_name

    if ( "gz" in input_file_name ):
        input_file = gzip.open( input_file_name, "r" )
        #filtered_file_name = input_file_name.strip(".vcf.gz") + extra_str  + ".pre.gl.vcf.gz"
        #filtered_output_file = gzip.open( filtered_file_name, "w" )
        output_file_name = input_file_name.strip(".vcf.gz") + extra_str  + ".gl.vcf.gz"
        output_file = gzip.open( output_file_name, "w" )
    else:
        input_file = open( input_file_name, "r" )
        #filtered_file_name = input_file_name.strip(".vcf") + extra_str  + ".pre.gl.vcf"
        #filtered_output_file = open( filtered_file_name, "w" )
        output_file_name = input_file_name.strip(".vcf") + extra_str  + ".gl.vcf"
        output_file = open( output_file_name, "w" )

    #print "Filtered file: ", filtered_file_name
    print "Output file: ", output_file_name

    for line in input_file:
        # comment lines
        if ( line[0] == "#" ):
            # write the comment lines into the output file
            output_file.write(line)
            #filtered_output_file.write ( line )
            continue

        # conversion are carried out in non-comment lines
        # sample starts from the 9th column
        fields = line.split()

        #assert ( fields[8] == "GT:DP:AD:DF:DR" )

        # replace Format by GT:GL
        fields[8] = "GT:GL"

        if len(fields[4]) > 1:
            # skip the line with multiple ALT, e.g.:
            # Pf3D7_01_v3     111774  .       G       T,A     .       PASS    .       GT:DP:AD:DF:DR  .:75:56,19,0:30,0,0:26,0,0
            continue
        elif (fields[4] == "."):
            # skip missing data
            # Pf3D7_05_v3 822827  .   G   .   .   PASS    .   GT:DP:AD:DF:DR  .:41:41:13:28
            continue

        category_count = [ 0, 0, 0, 0 ]
        # Sample starts from the 9th field til the end
        for sample_i in range(9, len(fields)):
            sample_i_info = fields[sample_i]
            ( new_sample_i_info, current_category ) = convert_info (sample_i_info, line)
            fields[sample_i] = new_sample_i_info
            category_count[current_category] += 1

        nsam = len(fields) - 9

        assert ( sum(category_count) == nsam ) # Check if all the possiblilities were considered
        newline = '\t'.join( fields )+"\n"
        output_file.write ( newline )
        #filtered_output_file.write ( line )
            #continue

        #print line, newline
        #raise Exception ( "Should never reach here!!!" )

    input_file.close()
    #filtered_output_file.close()
    output_file.close()

