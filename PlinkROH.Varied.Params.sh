#!/bin/bash
#BSUB -q c7normal
#BSUB -o /gpfs/gpfs1/home/blarison/scripts/out/inbreeding04.ROH.out
#BSUB -R rusage[mem=32000]
#BSUB -n 1
#BSUB -R span[hosts=1]
#BSUB -W 6:00


cd RAD/plink

FILENAME='wild.inbreed.QC'

###RUNNING PLINK ROH WITH VARIOUS PARAMETERS
#plink defaults:
#sliding window definition
# --homozyg-window-snp 50 # try 50 and 100
# --homozyg-window-kb 5000 #leave as default
# --homozyg-window-missing 5 #keep as 2
# --homozyg-window-het 1 #try 0 and 2
# --homozyg-window-threshold 0.05 # try 0.05 and 0.20
#calling of final segments
# --homozyg-snp 100 # try 50 and 100
# --homozyg-kb 1000 # try 500 and 1000
# --homozyg-density 50 # use actual density based on pruning
# --homozyg-gap 1000 # try 500 and 1000

#NO PRUNING
#153432 SNPS
#DENS=1/(NUMSNPS/3000000)
DENS=20
SNPS=50
WINGAP=500
for HET in 0 2; do
	for THRESH in 0.05 0.20; do
		plink --bfile $FILENAME --out $FILENAME.$SNPS.$WINGAP.$HET.$THRESH --homozyg --homozyg-window-snp $SNPS --homozyg-window-kb $WINGAP --homozyg-window-missing 2 --homozyg-window-het $HET --homozyg-window-threshold $THRESH --homozyg-snp $SNPS --homozyg-kb $WINGAP --homozyg-density $DENS --homozyg-gap $WINGAP
	done
done

SNPS=100
WINGAP=1000
for HET in 0 2; do
	for THRESH in 0.05 0.20; do
		plink --bfile $FILENAME --out $FILENAME.$SNPS.$WINGAP.$HET.$THRESH --homozyg --homozyg-window-snp $SNPS --homozyg-window-kb $WINGAP --homozyg-window-missing 2 --homozyg-window-het $HET --homozyg-window-threshold $THRESH --homozyg-snp $SNPS --homozyg-kb $WINGAP --homozyg-density $DENS --homozyg-gap $WINGAP
	done
done

#VIF2 PRUNING
#101409 SNPS
#DENS=1/(NUMSNPS/3000000)

PRUNE='vif.2'
DENS=30
SNPS=50
WINGAP=500
	for HET in 0 2; do
		for THRESH in 0.05 0.20; do
			plink --bfile $FILENAME.$PRUNE --out $FILENAME.$PRUNE.$SNPS.$WINGAP.$HET.$THRESH --homozyg --homozyg-window-snp $SNPS --homozyg-window-kb $WINGAP --homozyg-window-missing 2 --homozyg-window-het $HET --homozyg-window-threshold $THRESH --homozyg-snp $SNPS --homozyg-kb $WINGAP --homozyg-density $DENS --homozyg-gap $WINGAP
	done
done

SNPS=100
WINGAP=1000
for HET in 0 2; do
	for THRESH in 0.05 0.20; do
		plink --bfile $FILENAME --out $FILENAME.$PRUNE.$SNPS.$WINGAP.$HET.$THRESH --homozyg --homozyg-window-snp $SNPS --homozyg-window-kb $WINGAP --homozyg-window-missing 2 --homozyg-window-het $HET --homozyg-window-threshold $THRESH --homozyg-snp $SNPS --homozyg-kb $WINGAP --homozyg-density $DENS --homozyg-gap $WINGAP
	done
done

