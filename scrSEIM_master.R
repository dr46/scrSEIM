# scrSRASA master file 19/11/2021 - Initiated project.

# Computing SCR scores
source("stx/01_scrscores.R")
# load("dat/indat/nscr.RData") # loads the generated object

# Analysing time series for experimental and control groups
source("stx/02_ts.R")
.rs.restartR()
# read.table("tbl/bk.csv", sep = ";", header = TRUE)
# system(paste0('open "', 'fig/scr.pdf', '"'))
# system(paste0('open "', 'fig/ex_co_ts.pdf', '"'))
# system(paste0('open "', 'fig/sbk.pdf', '"'))

# Processing peak response during smartphone usage and after withdrawal
source("stx/03_scr_peaks.R")
# pas <- read.csv("tbl/pas.csv", sep = ";", dec = ",")

# Online form 
source("stx/04_eform.R")
# form <- readRDS("dat/indat/eform.rds")

# SAS-SV and AAQ-II reliability
# ---- WARNING! Running this file takes some time. It will be longer depending on your PC resources.
############### source("stx/05_reli.R")
# read.csv("tbl/reliability.csv", sep = ";", dec = ",")

# Merging electronic form data, peak analysis data and experimental participants' contacts.
source("stx/06_merge.R")
# spc <- readRDS("dat/indat/spc.rds")

source("stx/07_comp.R")
.rs.restartR()
# read.csv("tbl/comp.csv", sep = ";", dec = ",")

source("stx/08_rl.R", echo = T)
 

 
 
 
 # Analysing peak responses as a function of treatment group
 
 ......

merge form y peaks

analysing correlations and 


