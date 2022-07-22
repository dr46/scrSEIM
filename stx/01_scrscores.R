# scrscores.R
# It computes skin conductance response averages.

# Imports SCR data 
load("dat/scr.RData")

# Mean and standard deviation in baseline

abl1 <- apply(bl1, 1, mean) # averaged baseline
sdbl1 <- sqrt(apply(bl1, 1, var)) # standard deviation baseline

# Standarized skin conductance response
zsc1 <- (sp1 - abl1) / sdbl1 

# participants ids
id <- rownames(bl1)


colnames(zsc1) <- paste("s", 1:360, sep = "")

zsc1 <- data.frame(id, zsc1)

rm(bl1, sp1, abl1, id, sdbl1)

save(zsc1, file = "dat/indat/nscr.RData")

rm(zsc1)
