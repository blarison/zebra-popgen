#!/usr/bin/env Rscript

##NEEDS WORK TO MAKE UNIVERSAL
##NEEDS WORK TO MAKE UNIVERSAL
##NEEDS WORK TO MAKE UNIVERSAL

##useage: admixture.R admixdir plinkdir basename species maxK namecol (cap ex: Plains)

## args are basename (filename not including pathway or extension), species name for location file

setEPS()

args = commandArgs(trailingOnly=TRUE)
#args=c('/Volumes/NGSAnalysis/RAD/Admixture','/Volumes/NGSAnalysis/RAD/Plink','wild.auto.pw.rm.po.2fs.hlu_kru','Plains', 3, 1)
#admixture folder, plink folder, basename, species name, maxk, column where location name is found)
print(args)

admixdir=args[1]
plinkdir=args[2]
basename=args[3] 
species=args[4]
maxK=as.numeric(args[5])
namecol=as.numeric(args[6])

in.cv=paste(admixdir,'/',basename,'.CVerror', sep='')
cv <- read.table(in.cv, sep=' ', header=F)
cv$V3 <- row.names(cv)

print('Make CV error Plot - optimum K')
gph.cv=paste(admixdir,'/',basename,'.CVerr.eps', sep='')
postscript(gph.cv, height=3.5, width=3.5)
plot(cv$V4 ~ row.names(cv), pch=19)
lines(cv$V4 ~ row.names(cv), type = "l")
dev.off()

print('Make Ancestry Plot')
k = cv[which.min(cv$V4),]
bestK = as.numeric(k[1,3])

palette(c("cyan1","green2","orange","greenyellow","red2","cadetblue2","blue2","purple2","pink"))

###PLOT ALL
plots.out <- paste(admixdir,'/',basename,'.all.QPlots.eps', sep='')
postscript(plots.out, height=10, width=8)
par(mfrow=c(maxK,1),mar=c(0,3,1,0),oma=c(4,0,0,0))

for (K in 1:(maxK)){
	in.Q <- paste(admixdir,'/',basename,'.',K,'.Q',sep='')
	Q <- read.table(in.Q, sep=' ',header=F)
	in.fam <- paste(plinkdir,'/',basename,'.fam',sep='')
	fam <- read.table(in.fam,header=F)
	names(fam)<-c('Location','SampleID','Sire','Dam','Sex','Pheno')
	in.locs <- paste('/Volumes/NGSAnalysis/',species,'IndvLocationsGPS.txt', sep='')
	locs <- read.table(in.locs, sep='\t', header=T)
	Q.fam <- merge(Q,fam, by=0)
	Q.fam.loc <- merge(Q.fam,locs, by='SampleID')
	tbl.sort <- Q.fam.loc[order(Q.fam.loc$lat),]
	tbl.sort.print<-tbl.sort
	tbl.sort.print <- tbl.sort.print[c(1,8)]
	numind<-max(as.numeric(row.names(tbl.sort)))
	names<-tbl.sort[1:numind,namecol]
	print(names)
	tbl<-tbl.sort[c(3:(K+2))]
	barplot(t(as.matrix(tbl)), space=0.1, col=1:K,xaxt="n",xlab="", ylab="Ancestry", border=NA, las=2, names.arg=c(names))
}
dev.off()

###PLOT 3 plots centered on best K

plots.out <- paste(admixdir,'/',basename,'.3.QPlots.eps', sep='')
postscript(plots.out, height=5, width=8)
par(mfrow=c(3,1),mar=c(0,3,1,0),oma=c(1,0,0,0))

J=bestK-1
L=bestK+1

for (K in (J:L)){
	print(K)
	in.Q <- paste(admixdir,'/',basename,'.',K,'.Q',sep='')
	Q <- read.table(in.Q, sep=' ',header=F)
	in.fam <- paste(plinkdir,'/',basename,'.fam',sep='')
	fam <- read.table(in.fam,header=F)
	names(fam)<-c('Location','SampleID','Sire','Dam','Sex','Pheno')
	in.locs <- paste('/Volumes/NGSAnalysis/',species,'IndvLocationsGPS.txt', sep='')
	locs <- read.table(in.locs, sep='\t', header=T)
	Q.fam <- merge(Q,fam, by=0)
	Q.fam.loc <- merge(Q.fam,locs, by='SampleID')
	tbl.sort <- Q.fam.loc[order(Q.fam.loc$lat),]
	tbl.sort.print<-tbl.sort
	tbl.sort.print <- tbl.sort.print[c(1,8)]
	numind<-max(as.numeric(row.names(tbl.sort)))
	names<-tbl.sort[1:numind,namecol]
	print(names)
	tbl<-tbl.sort[c(3:(K+2))]
	barplot(t(as.matrix(tbl)), space=0.1, col=1:K,xaxt="n",xlab="", ylab="Ancestry", border=NA, las=2, names.arg=names)
}
dev.off()


###PLOT bestK
plots.out <- paste(admixdir,'/',basename,'.best.QPlot.eps', sep='')
postscript(plots.out, height=3, width=8)
par(mfrow=c(1,1))
	in.Q <- paste(admixdir,'/',basename,'.',K,'.Q',sep='')
	Q <- read.table(in.Q, sep=' ',header=F)
	in.fam <- paste(plinkdir,'/',basename,'.fam',sep='')
	fam <- read.table(in.fam,header=F)
	names(fam)<-c('Location','SampleID','Sire','Dam','Sex','Pheno')
	in.locs <- paste('/Volumes/NGSAnalysis/',species,'IndvLocationsGPS.txt', sep='')
	locs <- read.table(in.locs, sep='\t', header=T)
	Q.fam <- merge(Q,fam, by=0)
	Q.fam.loc <- merge(Q.fam,locs, by='SampleID')
	tbl.sort <- Q.fam.loc[order(Q.fam.loc$lat),]
	tbl.sort.print<-tbl.sort
	tbl.sort.print <- tbl.sort.print[c(1,8)]
	numind<-max(as.numeric(row.names(tbl.sort)))
	names<-tbl.sort[1:numind,namecol]
	print(names)
	tbl<-tbl.sort[c(3:(K+2))]
	barplot(t(as.matrix(tbl)), space=0.1, col=1:K,xaxt="n",xlab="", ylab="Ancestry", border=NA, las=2, names.arg=names)
dev.off()


###GREVY'S
plots.out <- paste(admixdir,'/',basename,'.all.QPlots.eps', sep='')
postscript(plots.out, height=10, width=80)

par(mfrow=c(maxK-1,1),mar=c(0,3,1,0),oma=c(0,0,0,0))

for (K in 2:(maxK)){
	in.Q <- paste(admixdir,'/',basename,'.',K,'.Q',sep='')
	Q <- read.table(in.Q, sep=' ',header=F)
	in.fam <- paste(plinkdir,'/',basename,'.fam',sep='')
	fam <- read.table(in.fam,header=F)
	names(fam)<-c('Location','SampleID','Sire','Dam','Sex','Pheno')
	in.locs <- paste('/Volumes/NGSAnalysis/',species,'IndvLocationsGPS.txt', sep='')
	locs <- read.table(in.locs, sep='\t', header=T)
	Q.fam <- merge(Q,fam, by=0)
	Q.fam.loc <- merge(Q.fam,locs, by='SampleID')
	tbl.sort <- Q.fam.loc[order(Q.fam.loc$Location.x),]
	tbl.sort.print<-tbl.sort
	tbl.sort.print <- tbl.sort.print[c(1,8)]
	numind<-max(as.numeric(row.names(tbl.sort)))
	names<-tbl.sort[1:numind,namecol]
	print(names)
	tbl<-tbl.sort[c(3:(K+2))]
	barplot(t(as.matrix(tbl)), space=0.1, col=1:K,xaxt="n",xlab="", ylab="Ancestry", border=NA, las=2, names.arg=names)
}
dev.off()


