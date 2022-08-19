# narrative.R

library(effectsize)
library(BayesFactor)
library(ltm)


load("dat/indat/nscr.RData")
key <- read.csv("dat/key.csv")
sp1 <- merge(key, zsc1)
rm(zsc1)
ex <- sp1[which(sp1$eg=='Exp'), ]
co <- sp1[which(sp1$eg=='Con'), ]
tex <- apply(ex[,3:362], 2, mean)
tco <- apply(co[,3:362], 2, mean)

dif <- tex-tco

t.test(dif, alternative = "g")
t_to_d(160.8, 359, paired = F, alternative = "g")
ttest.tstat(160.8, n1 = 360, n2 = 360, rscale = sqrt(2)/2, simple = T)


t.test(dif[121:151], dif[90:120], alternative = "g")
t_to_d(11.45, 41.92, paired = F, alternative = "g")

t.test(dif[241:270], dif[210:240], alternative = "g")
t_to_d(8.32, 34.28, paired = F, alternative = "g")

# correlation matrix

spc <- readRDS("dat/indat/spc.rds")

spc$amp.su <- log(spc$amp.su)
spc$amp.sw <- log(spc$amp.sw)
spc$tr50.su <- log(spc$tr50.su) 

spc$add.m <- ifelse(spc$sas > 33 & spc$sex == 0, 1, 0)
spc$add.h <- ifelse(spc$sas > 31 & spc$sex == 1, 1, 0)
spc$add <- spc$add.m + spc$add.h

x <- rcor.test(spc[c(28, 29, 32, 38, 4:26)], p.adjust = T)
correl <- round(as.matrix(x$cor.mat), 2)
p.values <- as.matrix(x$p.values)

write.csv2(correl, file = "tbl/cor.csv")
write.csv2(p.values, file = "tbl/cor-pval.csv")


cor.test(spc$sas, spc$aaq, alternative = "g")

con <- read.csv("dat/contacts.csv", sep = ";")

con <- merge(con, spc)

rcor.test(con[,c(2,31,32,35)], p.adjust = T)

rm(list = ls())
