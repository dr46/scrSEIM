# eform.R 
# Imports answers from electronic form

eform <- read.csv("dat/eform.csv", 
                  encoding="UTF-8", sep=";")

names(eform)[1] <- "id"


saveRDS(eform, "dat/indat/eform.rds")
rm(eform)
