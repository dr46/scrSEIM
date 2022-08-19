---
title: 'scrSEIM: Skin Conductance Response and Social Expectation while Instant Messaging'
output:
  html_document: default
  pdf_document: default
  word_document: default
---



The scrSEIM project was created to add supplementary material to the manuscript entitled "Social Expectancy Effect while Instant Messaging as Revealed by Skin Conductance Response". This manuscript was submitted to *[Psicothema](https://www.psicothema.com/)* journal for peer review. This project is inserted in a golbal one available in this [Open Science Framework](https://osf.io/) repository: <https://osf.io/kq2jh/>

All data files and R source code are available here to reproduce graphs and statistics reported in manuscript. Any question or request about this project and its content should be addressed to the last contributor of the project.  

# **Folders**

## *dat*

It contains original data files and a folder (*indat*) to save intermediate data files.

## *stx*

It contains pieces of code to run specific ordered tasks.

## *tbl*

It contains tables summing up analyses.

## *fig*

It contains the figures produced.

# **Files**

## **Data files**

### *key.csv*

It contains experimental group assignation for each participant.

Variables and labes:

-   id: participant identification.

-   eg: experimental group assignation.

    -   Exp: experimental group. Participants into this group were induced to experience social interaction expectancy.

    -   Con: control group. Participants into this group were not induced to experience social interaction expectancy.

### *scr.RData*

It contains two R objects (matrices) where skin conductance responses can be found for each participant.

Object name and brief description.

-   bl1: base line, 120 seconds recording of skin conductance response before the distraction virtual reality task.
-   sp1: 360 seconds of skin conductance response recording after virtual reality task. During the first 120 seconds participants were in resting state, during the intermediate 120 seconds participants were using their smartphones in a typical fashion, and during the last 120 seconds participants were in resting state again.

### *nscr.RData*

It is an R data file environment containing one object. It contains standardized net skin conductance activation. To standardize, mean and standard deviation was taken from baseline record before the distraction virtual reality task. This is the name object and the labels for each variable contained in it.

-   zsc1: it is the standardized net skin conductance response for each participant during 360 seconds after the distraction virtual reality task. It contains the following variables:

    -   id: participant identification.

    -   s1 to s360: second from 1 to 360.

### *eform.rds*

It contains answers to the recruitment electronic form. These are the labels and description for each variable:

-   id: participant identification code.
-   sex: it refers to participant's self assignment to woman (0) or man (1) categories.
-   edad: age computed from birth date to experiment date.
-   tt: How much time do you spend using your smartphone? Please, express it in hours.
-   not: the apps constantly activated in participant smartphone.
-   rs: hours spent on social networks.
-   ni: hours spent on the Internet.
-   vp: hours spent watching films or series.
-   ju: hours spent gaming.
-   mu: hours spent listening to music.
-   fo: hours spent editing photographs.
-   ll: hours spent phoning.
-   pref: I prefer contacting my friends by social networks instead than in person, 0: no, 1: yes.
-   abur: I use my smartphone to avoid boredom, 0: no, 1: yes.
-   evitar: I use my smartphone to avoid negative thoughts or emotions, 0: no, 1: yes.
-   aban: Without my smartphone I will be abandoned by my friends, 0: no, 1: yes.
-   satisf: Are you satisfied with your social relations outside social networks?, 0: no, 1: yes.
-   acep: I need to feel acceptance by other people, 0: no, 1: yes.
-   asol: I sometimes feel loneliness, 0: no, 1: yes.
-   sav1 to sav10: items from the Smartphone Addiction Scale - Short Version [(SAS-SV, Kwon et al., 2013)](https://doi.org/10.1371/journal.pone.0083558).
-   aa1 to aa7: items from the Spanish version of the AAQ-II scale[(Ruiz et al., 2013)](https://doi.org/10.7334/psicothema2011.239).


### *contacts.csv*

This file contains information from participants in experimental condition. It contains the number of contacts (peop) each participant sent the message and the smartphone app (app) used (w = WhatsApp, i = Instagram).

### *pas.csv*

It contains peak analysis statistics computed after smoothing SCR time series. This is the label and description of each column:

-   id: participant identification code.
-   eg: experimental group, Exp = experimental, Con = control.
-   amp.su: peak amplitude during smartphone usage.
-   amp.sw: peak amplitude after smartphone withdrawal.
-   rt.su: peak rise time during smartphone usage.
-   rt.sw: peak rise time after smartphone withdrawal.
-   tr50.su: 50% peak recovering time during smartphone usage.
-   tr50.sw: 50% peak recovering time after smartphone withdrawal.


### *spc.rds*

It contains variables coming from *contacts.csv*, *pas.csv*, and *eform.rds* data files. Labels are inherited from those files. New variables labels and descriptions are these:

-   sas: total score for the SAS-SV scale.
-   lc: score for "loss of control" facet of the SAS-SV scale.
-   cd: score for "cognitive disturbance" facet of the SAS-SV scale.
-   ic: score for "ignoring consequences" facet of the SAS-SV scale.
-   wd: score for "withdrawal" facet of the SAS-SV scale.
-   to: score for "tolerance" facet of the SAS-SV scale.
-   aaq: total score for the AAQ-II scale.
-   soc.apps: number of social apps always connected in participant's smartphone.

## **Source code files**

### *scrSEIM_master.R*

Main source code file. It can be used to run all the analysis.

### *00_pwr.R*

It estimates sample size based on power requirements for the experiment.

### *01_scrscores.R*

It computes skin conductance response scores. It generates the *nscr.RData* data file.

### *02_ts.R*

It processes SCR time series. It generates the graphs *scr.pdf*, *ex_co_ts.pdf*, and *sbk.pdf* (see "fig" folder). It also produces the *bk.csv* table (see "tbl" folder).

### *03_scr_peaks.R*

It processes SCR time series to extract basic peak features (Vila Castellar and Guerra Muñoz, 2009). It produces the file *pas.csv* archived in *indat* folder.

### *04_eform.R*

It imports data from the electronic form (*eform.xlsx*). It produces the file *eform.rds* archived in *indat* folder.

### *05_reli.R*

It computes internal consistency statistics for the SAS-SV and AAQ-II scales. It produces the table *reliability.csv* saved in the *tbl* folder.

### *06_merge.R*

This file combines data from different sources. It combines the data from the electronic form, the data from peak analysis and data from experimental question. It produces the file *spc.rds* saved in the *indat* folder.

### *07_comp.R*

It runs analysis to compare SCR peak analysis variables in experimental and control groups. It produces the *comp.csv* file saved in the *tbl* folder.

### *08_rl.R*

This file runs several regression analysis to study the relationship between significant peak analysis variables and the rest of variables. The analysis results are saved in the file *lms.txt* in the *tbl* folder. The variable *add* is created on the go to code smpartphone addiction risk considering [Kwon et al. (2013)](https://doi.org/10.1371/journal.pone.0083558) cut-off for men and women.

### *09_sample.R*

Sample descriptive statistics.

### *10_narrative.R*

This file runs analysis complementing narrative presentation of results in the paper. It produces two additional files saved in the *tbl* folder. The file *cor.csv* contains correlation matrix of SCR peak characteristics and smartphone use pattern variables. The file *or-pval.csv* contains the pairwise p-values for correlations in *cor.csv* matrix.


## **Table files**

### *bk.csv*

It contains statistics to sum up the time series for control and experimental group. The semicolon was used to separate columns and the comma was used as the decimal delimiter. Several Bayes Factors were computed to test sensitivity to prior specification by following the recommendations provided by [Kruschke (2021)](https://doi.org/10.1038/s41562-021-01177-7). Dissimilarity between time series were computed using cross-correlation based distances [Montero and Vilar, 2014](https://doi.org/10.18637/jss.v062.i01). These are the labels for each column:

-   The first column (with no heading) refers to seconds in time series.
-   mean: mean difference favouring skin conductace response to experimental group as compared with control group.
-   ll: 95% confidence interval lower limit for mean estimation.
-   ul: 95% confidence interval upper limit for mean estimation.
-   t: $t$-value comparing the mean with the null hypothesis of zero difference.
-   df: degrees of freedom for $t$.
-   pv: p-value for $t$.
-   bfs.l: Bayes Factor comparing observed mean to zero value. Prior fixed at $\frac{\sqrt{2}}{4}$.
-   bfs.m: Bayes Bayes Factor comparing observed mean to zero value. Prior fixed at $\frac{\sqrt{2}}{2}$.
-   bfs.w: Bayes Factor comparing observed mean to zero value. Prior fixed at $1$.
-   bfs.u: Bayes Factor comparing observed mean to zero value. Prior fixed at $\sqrt{2}$.
-   dts: distance between raw points in time series for experimental group and control group considering both proximity and temporal behavior.
-   r2: $r^2$ effect size estimation based on observed $t$ and computed as $\frac{t^2}{t^2 + df}$ where $df$ refer to degrees of freedom.


### *reliablility.csv*

It contains internal consistency statistics for the SAS-SV and AAQ-II scales. These are the labels and description variables:

-   omega: McDonal's omega internal consistency coefficient.
-   omega.se: McDonal's omega internal consistency coefficient standard error.
-   o.ll.95.ci: lower limit 95% confidence interval for McDonal's omega internal consistency coefficient.
-   o.ul.95.ci: upper limit 95% confidence interval for McDonal's omega internal consistency coefficient.
-   alpha: Chronbach's apha internal consistency coefficient.
-   alpha.se: Chronbach's apha internal consistency coefficient standard error.
-   a.ll.95.ci: lower limit 95% confidence interval for Chronbach's apha internal consistency coefficient.
-   a.ul.95.ci: upper limit 95% confidence interval for Chronbach's apha internal consistency coefficient.


### *comp.csv*

It contains descriptive and inferential statistics produced when comparing SCR peak analysis variables between experimental and control group. These are the descriptions for each column.

-   First column: the first column in the table refers to the comparation performed.
-   m.con: estimated mean for control group.
-   m.exp: estimated mean for experimental group.
-   dt.con: standard deviation for control group.
-   dt.exp: standard deviation for experimental group.
-   t: $t$ statistic to compare control and experimental group.
-   df: degrees of freedom for $t$ statistic.
-   p: *p*-value for $t$ statistic.
-   d: Cohen's $d$ estimation of effect size.
-   r: Pearson's $r$ estimation of effect size.
-   bf.l to bf.u: Bayes Factors estimated considering different priors to analyse sensivity to priors as suggested by [Kruschke (2021)](https://doi.org/10.1038/s41562-021-01177-7). bfs.l sets the prior at $\frac{\sqrt{2}}{4}$ (labeled as 'narrow' or 'low'), bfs.m sets the prior at $\frac{\sqrt{2}}{2}$ (labeled as 'medium'), bfs.w sets the prior at $1$ (labeled as 'wide'), and bfs.u sets the prior at $\sqrt{2}$ (labeled as 'ultra wide').


### *lms.txt*

It contains multiple linear regression analysis to study significant peak analysis variables and the rest of variables in the study. 


## **Figure files**

### *scr.pdf*

It compares SCR for control and experimental group during 360 seconds.

### *ex_co_ts.pdf*

It is the net time series resulting from subtracting the control group time series to experimental time series.

### *sbk.pdf*

It is analogous to *ex_co_ts.pdf* but it cluster the time series into 30 seconds bins. Average SCR estimation for each block and the 95% confidence interval are plotted.



# **References**

-   Kruschke, J. K. (2021). Bayesian analysis reporting guidelines. *Nature Human Behavior*, *5*, 1282-1291. <https://doi.org/10.1038/s41562-021-01177-7>

-   Kwon, M., Kim, D. J., Cho, H. & Yang, S. (2013). The smartphone addiction scale: Development and validation of a short version for adolescents. *Plos One, 8,* (12). <https://doi.org/10.1371/journal.pone.0083558>

-   Montero, P., and Vilar, J. A. (2014). TSclust: An R package for time series clustering. *Journal of Statistical Software, 62*, (1). <https://doi.org/10.18637/jss.v062.i01>

-   Ruiz, F. J., Langer Herrera, A. I., Luciano, C., Cangas, A. J., and Beltrán, I. (2013). Measuring experiential avoidance and psychological inflexibility: The Spanish version of the Acceptance and Action Questionnaire - II. *Psicothema, 25*(1), 123-129. https://doi.org/10.7334/psicothema2011.239 

-   Vila Castellar, J., and Guerra Muñoz, P. (2009). *Introducción a la psicofisiología clínica*. Síntesis.
