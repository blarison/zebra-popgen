#!/bin/bash
#BSUB -q normal
#BSUB -o /gpfs/gpfs1/home/blarison/scripts/out/admixture.out
#BSUB -R rusage[mem=32000]
#BSUB -n 1
#BSUB -R span[hosts=1]
#BSUB -W 2:00

#plains
cd RAD/admixture

for file in wild.auto.pw.rm.po.2fs.north wild.auto.pw.rm.po.2fs.south wild.auto.pw.rm.po.2fs.lai_kid wild.auto.pw.rm.po.2fs.hlu_kru; do
        for K in {1..10}; do
                admixture -B --cv ../plink/$file.bed ${K} | tee $file.log${K}.out
                grep CV $file.log${K}.out
        done
done

for file in wild.auto.pw.rm.po.2fs.north wild.auto.pw.rm.po.2fs.south wild.auto.pw.rm.po.2fs.lai_kid wild.auto.pw.rm.po.2fs.hlu_kru; do
		echo "" > $file.CVerror
        for K in {1..10}; do
                grep CV $file.log${K}.out >> $file.CVerror
        done
done
