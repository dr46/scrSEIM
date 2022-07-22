# ts.R

load("dat/indat/nscr.RData")
key <- read.csv("dat/key.csv")

sp1 <- merge(key, zsc1)
rm(zsc1)

# Time series by experimental group - control group


ex <- sp1[which(sp1$eg=='Exp'), ]
co <- sp1[which(sp1$eg=='Con'), ]

tex <- apply(ex[,3:362], 2, mean)
tco <- apply(co[,3:362], 2, mean)

pdf("fig/scr.pdf", width = 16, height = 9)

#windows(16,9)
par(mai = rep(1.5,4), cex = 2, mai = rep(1.7,4))

plot.ts(tco, type = "l", col = "grey", axes = F, ylab = expression(paste("SCR ", "(", mu, "S)")), xlab = "Seconds", 
     xlim = c(0,360), ylim = c(5,12), lwd = 3)
points(tex, type = "l", col = "black", lwd = 3)

axis(1, at = seq(from =0, to = 360, by = 60))
axis(2, las=2)


abline(v=120, col = "black", lwd = 2, lty = 2)
abline(v=240, col = "black", lwd = 2, lty = 2)

legend(300, 12, legend = c("Expr.", "Ctrl."), col = c("black", "grey"), lty = c(1,1),
       lwd = 3,box.lwd = "", bg = NA, cex = 0.8)

dev.off()

# Note: The plot is saved in fig folder as scr.pdf


# Analysing the time series

ex.co <- tex - tco

pdf("fig/ex_co_ts.pdf", width = 16, height = 9)

# windows(16,9)
par(cex.lab = 2, cex.axis = 1.8, mai = rep(1.5,4))

plot.ts(ex.co, type = "l", ylim = c(0,4), axes = F, 
        ylab = expression(paste(Delta, "SCR ", "(", mu, "S)")), 
        xlab = "Seconds", lwd = 3)


axis(1, at = seq(from =0, to = 360, by = 60))
axis(2, las=2)


abline(v=120, col = "black", lwd = 2, lty = 2)
abline(v=240, col = "black", lwd = 2, lty = 2)

dev.off()

# Note: The plot is saved in fig folder as ex_co_ts.pdf

sbk <- function(x){
  mea <- x$estimate
  ll <- x$conf.int[1]
  up <- x$conf.int[2]
  te <- x$statistic
  df <- x$parameter
  pv <- x$p.value
  
  sb <- c(mea, ll, up, te, df, pv)
  return(sb)
}

bk <- matrix(ncol = 6, nrow = 12)

bk[1,] <- sbk(t.test(ex.co[1:30], mu = 0))
bk[2,] <- sbk(t.test(ex.co[31:60], mu = 0))
bk[3,] <- sbk(t.test(ex.co[61:90], mu = 0))
bk[4,] <- sbk(t.test(ex.co[91:120], mu = 0))
bk[5,] <- sbk(t.test(ex.co[121:150], mu = 0))
bk[6,] <- sbk(t.test(ex.co[151:180], mu = 0))
bk[7,] <- sbk(t.test(ex.co[181:210], mu = 0))
bk[8,] <- sbk(t.test(ex.co[211:240], mu = 0))
bk[9,] <- sbk(t.test(ex.co[241:270], mu = 0))
bk[10,] <- sbk(t.test(ex.co[271:300], mu = 0))
bk[11,] <- sbk(t.test(ex.co[301:330], mu = 0))
bk[12,] <- sbk(t.test(ex.co[331:360], mu = 0))

colnames(bk) <- c("mean", "ll", "ul", "t", "df", "pv")
rownames(bk) <- c("1:30", "31:60", "61:90", "91:120",
                  "121:150", "151:180", "181:210", "211:240",
                  "241:270", "271:300", "301:330", "331:360")

xp <- c(1:4, 5.1, 6:8, 9.1, 10:12)

pdf("fig/sbk.pdf", width = 16, height = 9)

# windows(16,9)
par(mai = rep(1.5,4), cex = 2, mai = rep(1.7,4))

plot(y= bk[,1], x=xp, ylim = c(0,3.5), type = "o", pch =20, cex = 0.5, axes = F, 
     ylab = expression(paste(Delta, "SCR ", "(", mu, "S) ", "" %+-% "95% CI")), 
     xlab = "Blocks of 30 seconds", lwd=2)

arrows(x0 = xp, y0 = bk[,1], x1 = xp, y1 = bk[,2], angle = 90, length = 0.05, lwd =2)
arrows(x0 = xp, y0 = bk[,1], x1 = xp, y1 = bk[,3], angle = 90, length = 0.05, lwd =2)

axis(1, at = 1:12)
axis(2, las=2)


abline(v=5, col = "black", lwd = 2, lty = 2)
abline(v=9, col = "black", lwd = 2, lty = 2)

dev.off()

# Note: The plot is saved in fig folder as sbk.pdf


# Bayes Factors

library(BayesFactor)

bfs.l <- vector(length = 12)
bfs.m <- vector(length = 12)
bfs.w <- vector(length = 12)
bfs.u <- vector(length = 12)

bfex <- function(x, r = "medium"){
  an <- ttestBF(x, rscale = r)
  bf <- an@bayesFactor[[1]]
  return(bf)
}


bfs.l[1] <- bfex(ex.co[1:30], sqrt(2)/4)
bfs.l[2] <- bfex(ex.co[31:60], sqrt(2)/4)
bfs.l[3] <- bfex(ex.co[61:90], sqrt(2)/4)
bfs.l[4] <- bfex(ex.co[91:120], sqrt(2)/4)
bfs.l[5] <- bfex(ex.co[121:150], sqrt(2)/4)
bfs.l[6] <- bfex(ex.co[151:180], sqrt(2)/4)
bfs.l[7] <- bfex(ex.co[181:210], sqrt(2)/4)
bfs.l[8] <- bfex(ex.co[211:240], sqrt(2)/4)
bfs.l[9] <- bfex(ex.co[241:270], sqrt(2)/4)
bfs.l[10] <- bfex(ex.co[271:300], sqrt(2)/4)
bfs.l[11] <- bfex(ex.co[301:330], sqrt(2)/4)
bfs.l[12] <- bfex(ex.co[331:360], sqrt(2)/4)

bk <- cbind(bk,bfs.l)

bfs.m[1] <- bfex(ex.co[1:30])
bfs.m[2] <- bfex(ex.co[31:60])
bfs.m[3] <- bfex(ex.co[61:90])
bfs.m[4] <- bfex(ex.co[91:120])
bfs.m[5] <- bfex(ex.co[121:150])
bfs.m[6] <- bfex(ex.co[151:180])
bfs.m[7] <- bfex(ex.co[181:210])
bfs.m[8] <- bfex(ex.co[211:240])
bfs.m[9] <- bfex(ex.co[241:270])
bfs.m[10] <- bfex(ex.co[271:300])
bfs.m[11] <- bfex(ex.co[301:330])
bfs.m[12] <- bfex(ex.co[331:360])

bk <- cbind(bk,bfs.m)

bfs.w[1] <- bfex(ex.co[1:30], r = "wide")
bfs.w[2] <- bfex(ex.co[31:60], r = "wide")
bfs.w[3] <- bfex(ex.co[61:90], r = "wide")
bfs.w[4] <- bfex(ex.co[91:120], r = "wide")
bfs.w[5] <- bfex(ex.co[121:150], r = "wide")
bfs.w[6] <- bfex(ex.co[151:180], r = "wide")
bfs.w[7] <- bfex(ex.co[181:210], r = "wide")
bfs.w[8] <- bfex(ex.co[211:240], r = "wide")
bfs.w[9] <- bfex(ex.co[241:270], r = "wide")
bfs.w[10] <- bfex(ex.co[271:300], r = "wide")
bfs.w[11] <- bfex(ex.co[301:330], r = "wide")
bfs.w[12] <- bfex(ex.co[331:360], r = "wide")

bk <- cbind(bk,bfs.w)

bfs.u[1] <- bfex(ex.co[1:30], r = "ultrawide")
bfs.u[2] <- bfex(ex.co[31:60], r = "ultrawide")
bfs.u[3] <- bfex(ex.co[61:90], r = "ultrawide")
bfs.u[4] <- bfex(ex.co[91:120], r = "ultrawide")
bfs.u[5] <- bfex(ex.co[121:150], r = "ultrawide")
bfs.u[6] <- bfex(ex.co[151:180], r = "ultrawide")
bfs.u[7] <- bfex(ex.co[181:210], r = "ultrawide")
bfs.u[8] <- bfex(ex.co[211:240], r = "ultrawide")
bfs.u[9] <- bfex(ex.co[241:270], r = "ultrawide")
bfs.u[10] <- bfex(ex.co[271:300], r = "ultrawide")
bfs.u[11] <- bfex(ex.co[301:330], r = "ultrawide")
bfs.u[12] <- bfex(ex.co[331:360], r = "ultrawide")

bk <- cbind(bk,bfs.u)


### Comparing time series

library(TSdist)

d <- vector(length = 12)

d[1] <- CortDistance(tex[1:30], tco[1:30])
d[2] <- CortDistance(tex[31:60], tco[31:60])
d[3] <- CortDistance(tex[61:90], tco[61:90])
d[4] <- CortDistance(tex[91:120], tco[91:120])
d[5] <- CortDistance(tex[121:150], tco[121:150])
d[6] <- CortDistance(tex[151:180], tco[151:180])
d[7] <- CortDistance(tex[181:210], tco[181:210])
d[8] <- CortDistance(tex[211:240], tco[211:240])
d[9] <- CortDistance(tex[241:270], tco[241:270])
d[10] <- CortDistance(tex[271:300], tco[271:300])
d[11] <- CortDistance(tex[301:330], tco[301:330])
d[12] <- CortDistance(tex[331:360], tco[331:360])


bk <- cbind(bk, dts = d)

# Effect size r^2 from t statistics.

rr <- vector(length = 12)


r2 <- function(x, i){
  r2 <- x[i, 4]^2/(x[i, 4]^2 + bk[i, 5])
  return(r2)
}

rr[1] <- r2(bk, 1)
rr[2] <- r2(bk, 2)
rr[3] <- r2(bk, 3)
rr[4] <- r2(bk, 4)
rr[5] <- r2(bk, 5)
rr[6] <- r2(bk, 6)
rr[7] <- r2(bk, 7)
rr[8] <- r2(bk, 8)
rr[9] <- r2(bk, 9)
rr[10] <- r2(bk, 10)
rr[11] <- r2(bk, 11)
rr[12] <- r2(bk, 12)

bk <- cbind(bk, r2 = rr)

write.table(bk, file = "tbl/bk.csv", sep = ";", dec = ",", 
            row.names = T, col.names = NA)

detach("package:BayesFactor", unload = TRUE)
detach("package:TSdist", unload = TRUE)

rm(list=ls())

