# reli.R

library(MBESS)

form <- readRDS("dat/indat/eform.rds")

# SAS-SV reliability
sas.scale <- c("sav1", "sav2", "sav3", "sav4","sav5", "sav6", "sav7", "sav8", "sav9", "sav10" )

set.seed(46)
rely.o <- ci.reliability(form[,sas.scale], type = "omega", interval.type = "perc", B = 1000)

set.seed(46)
rely.a <- ci.reliability(form[,sas.scale], type = "alpha", interval.type = "perc", B = 1000)

om <- rely.o$est
se.om <- rely.o$se
om.l <- rely.o$ci.lower
om.u <- rely.o$ci.upper

al <- rely.o$est
se.al <- rely.a$se
al.l <- rely.a$ci.lower
al.u <- rely.a$ci.upper 

est <- c(om, se.om, om.l, om.u, al, se.al, al.l, al.u)

mt <- matrix(nrow = 2, ncol = 8)

colnames(mt) <- c("omega", "omega.se", "o.ll.95.ci", "o.ul.95.ci",
                  "alpha", "alpha.se", "a.ll.95.ci", "a.ul.95.ci")
rownames(mt) <- c("sas.sv", "aaq.ii")

mt[1,] <- round(est, 2)

# AAQ-II

aaq.scale <- c("aa1", "aa2", "aa3", "aa4", "aa5", "aa6", "aa7")


set.seed(46)
rely.o <- ci.reliability(form[,aaq.scale], type = "omega", interval.type = "perc", B = 1000)

set.seed(46)
rely.a <- ci.reliability(form[,aaq.scale], type = "alpha", interval.type = "perc", B = 1000)

om <- rely.o$est
se.om <- rely.o$se
om.l <- rely.o$ci.lower
om.u <- rely.o$ci.upper

al <- rely.o$est
se.al <- rely.a$se
al.l <- rely.a$ci.lower
al.u <- rely.a$ci.upper 

est <- c(om, se.om, om.l, om.u, al, se.al, al.l, al.u)

mt[2,] <- round(est, 2)

write.table(mt, file = "tbl/reliability.csv", sep = ";", dec = ",", 
            row.names = T, col.names = NA)

rm(list=ls())
.rs.restartR()