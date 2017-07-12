rm(list = ls())
set.seed(3)
#sampleNames = read.table("labSampleNames", header=F, stringsAsFactors = F)$V1
#trueprop = read.csv("true.prop.csv.ordered.by.samplename", header=F)
deploid = read.table("deploid.prop.csv", header=T)
#true.eff.k = 1/rowSums(trueprop^2)
true = read.csv("true.k.csv", header=T)
coil = read.table("coil.k.txt", , header=F, skip=1)
sampleNames = coil$V1

pdf("trueVsInferredK.pdf", width = 8, height = 8)
par(mar=c(5.1,5.1,2.1,2.1))

plot(c(0.9,3.1), c(0.9,3.1), type="n", xlab = "True K", ylab = "Inferred K", cex.lab= 2, cex.axis= 1.6, xaxt = "n", yaxt="n")
jitterOff = 3

sampleI = 1
mypch = c(rep(10,6), rep(11,3), rep(7,18))
for ( sampleName in sampleNames ){
#    pfmix = read.table(paste("../pfmix/", sampleName, ".originial_pfmix.prop", sep =""), header=F)

    points(jitter(true$k[sampleI], jitterOff), jitter(sum(deploid[sampleI,-1]>0.01),jitterOff), cex = 2, col = 'red', pch = 16, lwd = 2)
#    points(jitter(true$k[sampleI], jitterOff), jitter(sum(pfmix>0),jitterOff), cex = 2, col = 'blue', pch = 20)
    points(jitter(true$k[sampleI], jitterOff), jitter(coil$V2[sampleI],jitterOff), cex = 2, col = 'blue', pch  = 16, lwd = 2)

#    points(true.eff.k[sampleI], 1/sum(pfmix^2), pch = 16, col = "blue", cex=2)
#    points(true.eff.k[sampleI], 1/sum(deploid[sampleI,-1]^2), pch = 16, col = "red", cex=2)
    sampleI = sampleI + 1
}
legend("topleft", legend = c("DEploid", "COIL"), text.col = c("red", "blue"), cex=2, pch = 16, col = c("red", "blue"))
axis(1, at=1:3,labels=1:3, las=1, lwd = 1, cex=2, cex.axis=1.4)
axis(2, at=1:3,labels=1:3, las=2, lwd = 1, cex=2, cex.axis=1.4)
#legend("topleft", legend = c("DEploid", "COIL"), text.col = c("red", "blue"), cex=2)
#legend("bottomright", legend = paste("Mix of", c("3D7/Dd2", "7G8/Dd2/HB3", "7G8/HB3")), pch = c(10,11,7), cex=1.6, pt.lwd=2)

lines(c(0,10), c(0,10), lty=2)
#lines(c(0,1), c(0.02,1.02), lty=2, col="grey", lwd = .5)
#lines(c(0,1), c(-0.02,0.98), lty=2, col="grey", lwd = .5)
#actualPlot()
dev.off()
