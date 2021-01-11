#!/bin/bash
#BSUB -q c7normal
#BSUB -o /gpfs/gpfs1/home/blarison/scripts/out/king.out
#BSUB -R rusage[mem=32000]
#BSUB -n 1
#BSUB -R span[hosts=1]
#BSUB -W 1:00

BASENAME=wild.auto.pw

cd RAD/king
king -b ../plink/$BASENAME.bed --prefix $BASENAME --kinship --ibs --sexchr 32
king -b ../plink/$BASENAME.bed --prefix $BASENAME --mds --sexchr 32
cd


