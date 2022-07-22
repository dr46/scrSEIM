# rl.R

library(ppcor)
library(effectsize)

spc <- readRDS("dat/indat/spc.rds")

spc$eg <- ifelse(spc$eg == "Con", 0, 1)
spc$amp.su <- log(spc$amp.su)
spc$amp.sw <- log(spc$amp.sw)
spc$tr50.su <- log(spc$tr50.su) 



spc$add.m <- ifelse(spc$sas > 33 & spc$sex == 0, 1, 0)
spc$add.h <- ifelse(spc$sas > 31 & spc$sex == 1, 1, 0)
spc$add <- spc$add.m + spc$add.h

sink(file = "tbl/lms.txt", append = F)

# SAS-SV components variables

anova(lm(amp.su ~ eg * add, data = spc))
anova(lm(amp.sw ~ eg * add, data = spc))
anova(lm(tr50.su ~ eg * add, data = spc))

anova(lm(amp.su ~ eg * sas, data = spc))
anova(lm(amp.sw ~ eg * sas, data = spc))
anova(lm(tr50.su ~ eg * sas, data = spc))


anova(lm(amp.su ~ eg * lc, data = spc)); F_to_eta2(3.25, df = 1, df_error = 82); pcor.test(spc$amp.su, spc$lc, spc$eg)
anova(lm(amp.sw ~ eg * lc, data = spc))
anova(lm(tr50.su ~ eg * lc, data = spc)); F_to_eta2(2.85, df = 1, df_error = 82); pcor.test(spc$tr50.su, spc$lc, spc$eg)



anova(lm(amp.su ~ eg * cd, data = spc))
anova(lm(amp.sw ~ eg * cd, data = spc))
anova(lm(tr50.su ~ eg * cd, data = spc))

anova(lm(amp.su ~ eg * ic, data = spc))
anova(lm(amp.sw ~ eg * ic, data = spc))
anova(lm(tr50.su ~ eg * ic, data = spc)); F_to_eta2(3.61, df = 1, df_error = 82); pcor.test(spc$tr50.su, spc$ic, spc$eg)

anova(lm(amp.su ~ eg * wd, data = spc))
anova(lm(amp.sw ~ eg * wd, data = spc))
anova(lm(tr50.su ~ eg * wd, data = spc))

anova(lm(amp.su ~ eg * to, data = spc))
anova(lm(amp.sw ~ eg * to, data = spc))
anova(lm(tr50.su ~ eg * to, data = spc))

# Otras variables

anova(lm(amp.su ~ eg * tt, data = spc))
anova(lm(amp.sw ~ eg * tt, data = spc))
anova(lm(tr50.su ~ eg * tt, data = spc))

anova(lm(amp.su ~ eg * rs, data = spc))
anova(lm(amp.sw ~ eg * rs, data = spc))
anova(lm(tr50.su ~ eg * rs, data = spc))

anova(lm(amp.su ~ eg * ni, data = spc))
anova(lm(amp.sw ~ eg * ni, data = spc)); F_to_eta2(2.09, df = 1, df_error = 82); pcor.test(spc$amp.sw, spc$ni, spc$eg)
anova(lm(tr50.su ~ eg * ni, data = spc))

anova(lm(amp.su ~ eg * vp, data = spc))
anova(lm(amp.sw ~ eg * vp, data = spc))
anova(lm(tr50.su ~ eg * vp, data = spc))

anova(lm(amp.su ~ eg * ju, data = spc))
anova(lm(amp.sw ~ eg * ju, data = spc))
anova(lm(tr50.su ~ eg * ju, data = spc))

anova(lm(amp.su ~ eg * em, data = spc))
anova(lm(amp.sw ~ eg * em, data = spc))
anova(lm(tr50.su ~ eg * em, data = spc))

anova(lm(amp.su ~ eg * fo, data = spc))
anova(lm(amp.sw ~ eg * fo, data = spc))
anova(lm(tr50.su ~ eg * fo, data = spc))

anova(lm(amp.su ~ eg * ll, data = spc))
anova(lm(amp.sw ~ eg * ll, data = spc))
anova(lm(tr50.su ~ eg * ll, data = spc))

anova(lm(amp.su ~ eg * pref, data = spc))
anova(lm(amp.sw ~ eg * pref, data = spc))
anova(lm(tr50.su ~ eg * pref, data = spc))

anova(lm(amp.su ~ eg * abur, data = spc))
anova(lm(amp.sw ~ eg * abur, data = spc))
anova(lm(tr50.su ~ eg * abur, data = spc)); F_to_eta2(3.55, df = 1, df_error = 82); pcor.test(spc$tr50.su, spc$abur, spc$eg)

anova(lm(amp.su ~ eg * aban, data = spc))
anova(lm(amp.sw ~ eg * aban, data = spc))
anova(lm(tr50.su ~ eg * aban, data = spc))

anova(lm(amp.su ~ eg * evitar, data = spc))
anova(lm(amp.sw ~ eg * evitar, data = spc))
anova(lm(tr50.su ~ eg * evitar, data = spc))

anova(lm(amp.su ~ eg * satisf, data = spc)); F_to_eta2(3.04, df = 1, df_error = 82); pcor.test(spc$amp.su, spc$satisf, spc$eg)
anova(lm(amp.sw ~ eg * satisf, data = spc))
anova(lm(tr50.su ~ eg * satisf, data = spc))

anova(lm(amp.su ~ eg * acep, data = spc))
anova(lm(amp.sw ~ eg * acep, data = spc))
anova(lm(tr50.su ~ eg * acep, data = spc))

anova(lm(amp.su ~ eg * asol, data = spc))
anova(lm(amp.sw ~ eg * asol, data = spc))
anova(lm(tr50.su ~ eg * asol, data = spc))

anova(lm(amp.su ~ eg * aaq * sex, data = spc))
anova(lm(amp.sw ~ eg * aaq * sex, data = spc))
anova(lm(tr50.su ~ eg * aaq * sex, data = spc))

anova(lm(amp.su ~ eg * soc.apps, data = spc))
anova(lm(amp.sw ~ eg * soc.apps, data = spc))
anova(lm(tr50.su ~ eg * soc.apps, data = spc))

sink()

rm(spc)

detach(package:effectsize,unload=TRUE)
detach(package:ppcor,unload=TRUE)






