# merge.R

cont <- read.csv2("dat/contacts.csv"); names(cont)[1] <- "id"

form <- readRDS("dat/indat/eform.rds")

# Smartphone Addiction Scores - Short Version

attach(form)

form$sas <- sav1+sav2+sav3+sav4+sav5+sav6+sav7+sav8+sav9+sav10

detach(form)

#loss of control
form$lc <- form$sav1 + form$sav8

#cognitive disturbance 
form$cd <- form$sav2 + form$sav6

#ignoring consequences
form$ic <- form$sav3 + form$sav7

#withdrawal
form$wd <- form$sav4 + form$sav5

#tolerance
form$to <- form$sav9 + form$sav10

# AAQ-II

form$aaq <- form$aa1 + form$aa2 + form$aa3 + form$aa4 + form$aa5 + form$aa6 + form$aa7


library(stringr)

# Number of active applications always active

form$face <- as.numeric(str_detect(form$not, "Facebook")) 
form$twit <- as.numeric(str_detect(form$not, "Twitter"))
form$inst <- as.numeric(str_detect(form$not, "Instagram"))
form$pint <- as.numeric(str_detect(form$not, "Pinterest"))
form$mail <- as.numeric(str_detect(form$not, "Email"))

form$soc.apps <- form$face + form$twit + form$inst + form$pint + form$mail

detach("package:stringr", unload = TRUE)


pas <- read.csv("tbl/pas.csv", sep = ";", dec = ",")

spc <- merge(form, pas, by = "id")


delete <- names(spc) %in% c("not", "sav1", "sav2", "sav3", "sav4", "sav5", 
                            "sav6", "sav7", "sav8", "sav9", "sav10",
                            "aa1", "aa2", "aa3", "aa4", "aa5", "aa6", "aa7",
                            "face", "twit", "inst", "pint", "mail") 

spc <- spc[!delete]

saveRDS(spc, "dat/indat/spc.rds")

rm(list=ls())

