# comp.R

library(effectsize)
library(BayesFactor)

spc <- readRDS("dat/indat/spc.rds")

mat <- matrix(ncol = 13, nrow = 0)
cn <- c("m.con", "m.exp", "dt.con", "dt.exp", "t", 
        "df", "p", "d", "r", "bf.l", "bf.m", "bf.w", "bf.u")
colnames(mat) <- cn

compi <- function(test, dts){
  
  vari <- test$data.name
  te <- test$statistic
  te.df <- test$parameter
  alt <- test$alternative
  pv <- test$p.value
  
  m.con <- test$estimate[[1]]
  m.exp <- test$estimate[[2]]
  dt.con <- dts[[1]]
  dt.exp <- dts[[2]]
  
  de <- t_to_d(te, te.df, paired = F, alternative = alt)$d
  ere <- t_to_r(te, te.df, paired = F, alternative = alt)$r
  bf.l <- ttest.tstat(te, n1 = 43, n2 = 43, rscale = sqrt(2)/4, simple = T)
  bf.m <- ttest.tstat(te, n1 = 43, n2 = 43, rscale = sqrt(2)/2, simple = T)
  bf.w <- ttest.tstat(te, n1 = 43, n2 = 43, rscale = 1, simple = T)
  bf.u <- ttest.tstat(te, n1 = 43, n2 = 43, rscale = sqrt(2), simple = T)
  
  fil <- c(m.con, m.exp, dt.con, dt.exp, te, te.df, pv, de, ere, bf.l, bf.m, bf.w, bf.u)
  
  mat.p <- matrix(ncol = 13)
  mat.p[1,] <- fil
  rownames(mat.p) <- vari
  return(mat.p)
  
  
}


test <- t.test(log(spc$amp.su) ~ spc$eg, alternative = "less")
dts <- tapply(log(spc$amp.su), spc$eg, sd)
mat.p <- compi(test, dts)
mat <- rbind(mat, mat.p)

test <- t.test(log(spc$amp.sw) ~ spc$eg, alternative = "less")
dts <- tapply(log(spc$amp.sw), spc$eg, sd)
mat.p <- compi(test, dts)
mat <- rbind(mat, mat.p)

test <- t.test(log(spc$rt.su) ~ spc$eg, alternative = "greater")
dts <- tapply(log(spc$rt.su), spc$eg, sd)
mat.p <- compi(test, dts)
mat <- rbind(mat, mat.p)

test <- t.test(log(spc$rt.sw) ~ spc$eg, alternative = "greater")
dts <- tapply(log(spc$rt.sw), spc$eg, sd)
mat.p <- compi(test, dts)
mat <- rbind(mat, mat.p)

test <- t.test(log(spc$tr50.su) ~ spc$eg, alternative = "less")
dts <- tapply(log(spc$tr50.su), spc$eg, sd)
mat.p <- compi(test, dts)
mat <- rbind(mat, mat.p)

test <- t.test(log(spc$tr50.sw) ~ spc$eg, alternative = "less")
dts <- tapply(log(spc$tr50.sw), spc$eg, sd)
mat.p <- compi(test, dts)
mat <- rbind(mat, mat.p)

test <- t.test(log(spc$npicos.su) ~ spc$eg, alternative = "less")
dts <- tapply(log(spc$npicos.su), spc$eg, sd)
mat.p <- compi(test, dts)
mat <- rbind(mat, mat.p)

test <- t.test(log(spc$npicos.sw) ~ spc$eg, alternative = "less")
dts <- tapply(log(spc$npicos.sw), spc$eg, sd)
mat.p <- compi(test, dts)
mat <- rbind(mat, mat.p)

write.table(round(mat,4), file = "tbl/comp.csv", sep = ";", dec = ",", 
            row.names = T, col.names = NA)


rm(list=ls())

