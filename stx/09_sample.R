# 09_sample.R

spc <- readRDS("dat/indat/spc.rds")

table(spc$sex)
prop.table(table(spc$sex)) *100

summary(spc$edad)
sd(spc$edad)

summary()




#STAI prueba


stai <- read.delim("C:/Users/anamr/Desktop/stai.txt", encoding="UTF-8")


stai$s1 <- (5-stai$s11) + stai$s12 + stai$s13 + (5-stai$s14) + (5-stai$s15) + stai$s16

stai$s2 <- (5-stai$s21) + stai$s22 + stai$s23 + (5-stai$s24) + (5-stai$s25) + stai$s26


stai$s2 - stai$s1

stai <- stai[,c("id", "s1", "s2")]


spc <- merge(spc, stai, by = "id")

anova(lm(amp.su ~ eg * s2, data = spc))
anova(lm(amp.sw ~ eg * s2, data = spc))
anova(lm(tr50.su ~ eg * s2, data = spc))
