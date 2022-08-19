# 09_sample.R

spc <- readRDS("dat/indat/spc.rds")

table(spc$sex)
prop.table(table(spc$sex)) *100

summary(spc$edad)
sd(spc$edad)
rm(list = ls())
