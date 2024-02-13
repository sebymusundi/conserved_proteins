#! /bin/bash

# Download plasmodium falciparum version 66 data cd

# input the plasmodium proteome
proteome=../Data/PlasmoDB-66_Pfalciparum3D7_AnnotatedProteins.fasta

# chromosome positions
chromosomes=(PF3D7_01 PF3D7_02 PF3D7_03  PF3D7_04 PF3D7_05 PF3D7_06 PF3D7_07 PF3D7_08 PF3D7_09 PF3D7_10 PF3D7_11 PF3D7_12 PF3D7_13 PF3D7_14)

# Loop to count the number of conserved plasmodium proteins with unknown functions

for file in ${chromosomes[@]}

do
    less ${proteome} | grep  ">" | grep -e  "${file}"| grep -e "conserved protein" -e "conserved Plasmodium protein, unknown function" | awk '{print $1}'| cut -c2-20 > ../Results/${file}.tsv
    
done

# sort protein IDs in order
cat ../Results/PF3D7_* | sort  > ../Results/unknown_proteins.tsv

# Extract the fasta sequences for the remaining proteins
seqtk subseq ../Data/PlasmoDB-66_Pfalciparum3D7_AnnotatedProteins.fasta ../Results/unknown_proteins.tsv > ../Results/unknown_proteins.fasta