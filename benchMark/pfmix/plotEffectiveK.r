rm(list = ls())
true.prop = read.csv("true.prop.4strains.csv", header=T)
deploid.prop = read.csv("deploid.prop.4strains.csv", header=T)
pfmix.prop = read.csv("pfmix.prop.4strains.csv", header=T)

compute.effective.k <- function (prop){
    return(1/sum(prop^2))
}


pdf("trueVsInferredEffK.pdf", width = 8, height = 8)
par(mar=c(5.1,5.1,2.1,2.1))

plot(c(0.9,3.1), c(0.9,3.1), type="n", xlab = "True effective K", ylab = "Inferred effective K", cex.lab= 2, cex.axis= 1.4)
#jitterOff = 3

sampleI = 1
mypch = c(rep(10,6), rep(11,3), rep(7,18))

for ( sampleI in 1:27 ){
    points(compute.effective.k(true.prop[sampleI,]), compute.effective.k(pfmix.prop[sampleI,]), cex = 2, col = 'blue', pch = 16, lwd = 2)
    points(compute.effective.k(true.prop[sampleI,]), compute.effective.k(deploid.prop[sampleI,]), cex = 2, col = 'red', pch = 16, lwd = 2)


}
legend("topleft", legend = c("DEploid", "pfmix"), text.col = c("red", "blue"), cex=2, pch = 16, col = c("red", "blue"))
#axis(1, at=1:3,labels=1:3, las=1, lwd = 1, cex=2, cex.axis=1.4)
#axis(2, at=1:3,labels=1:3, las=2, lwd = 1, cex=2, cex.axis=1.4)
#legend("topleft", legend = c("DEploid", "COIL"), text.col = c("red", "blue"), cex=2)
#legend("bottomright", legend = paste("Mix of", c("3D7/Dd2", "7G8/Dd2/HB3", "7G8/HB3")), pch = c(10,11,7), cex=1.6, pt.lwd=2)

lines(c(0,10), c(0,10), lty=2)
#lines(c(0,1), c(0.02,1.02), lty=2, col="grey", lwd = .5)
#lines(c(0,1), c(-0.02,0.98), lty=2, col="grey", lwd = .5)
#actualPlot()
dev.off()

