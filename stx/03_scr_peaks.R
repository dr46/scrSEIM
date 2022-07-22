# scr_peaks.R

library(pracma)

load("dat/indat/nscr.RData")
key <- read.csv("dat/key.csv")

pa <- merge(zsc1, key, by="id")
rm(zsc1, key)

pas <- pa[, c(1,362)]

pa <- pa[,c(2:361)]




#smartphone use and post smpartphone scr - seconds 1 to 360
x <- as.matrix(pa)

mat <- matrix(ncol = 8, nrow = 86)
for(i in 1:86) {
  part <- as.vector(x[i, 1:360])
  bl1 <- mean(part[110:119])              # Base line 1
  bl2 <- mean(part[230:239])              # Base line 2
  
  kpart <-  ksmooth(time(part), part, "normal", bandwidth = 10) # Signal smoothing
  su <- kpart$y[120:229]                  # Smartphone usage
  sw <- kpart$y[240:360]                  # Smartphone withdrawal
  
  picos.su <- findpeaks(su, nups = 5)     # Smartphone usage peaks
  npicos.su <- dim(picos.su)[1]           # n of peaks during smartphone usage
  picos.sw <- findpeaks(sw, nups = 5)     # Withdrawal peaks
  npicos.sw <- dim(picos.sw)[1]           # n of peaks after withdrawal
  
  fph.su <- picos.su[1,1]                 # First peak height smartphone usage
  fph.sw <- picos.sw[1,1]                 # First peak height smartphone withdrawal
  
  amp.su <- fph.su - bl1                  # Response amplitude smartphone usage
  amp.sw <- fph.sw - bl2                  # Response amplitude smartphone withdrawal
  
  rt.su <- picos.su[1,2]                  # Rise time smartphone usage
  rt.sw <- picos.sw[1,2]                  # Rise time smartphone withdrawal
  
  ini.su.50 <- picos.su[1,2]
  crit.su <- fph.su - amp.su * 1/2
  tr50.su <- ifelse(is.na(which(su[ini.su.50:110] < crit.su)[1]), 110, which(su[ini.su.50:110] < crit.su)[1])   # Recovering time 50% smartphone usage
  ini.sw.50 <- picos.sw[1,2]
  crit.sw <- fph.sw-amp.sw *1/2
  tr50.sw <- ifelse(is.na(which(sw[ini.sw.50:120] < crit.sw)[1]), 120, which(sw[ini.sw.50:120] < crit.sw)[1])   # Recovering time 50% smartphone withdrawal
  
  mat[i,] <- c(amp.su, amp.sw, rt.su, rt.sw, tr50.su, tr50.sw, npicos.su, npicos.sw)

  }

colnames(mat) <- c("amp.su", "amp.sw", "rt.su", "rt.sw", "tr50.su", "tr50.sw", "npicos.su", "npicos.sw")

pas <- cbind(pas, mat)

write.csv2(pas, "dat/indat/pas.csv", row.names = F)

rm(list=ls())
