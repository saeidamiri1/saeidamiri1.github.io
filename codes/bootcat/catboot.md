---
layout: post
title:  "Bootstrap Categorical"
date: "2018-01-18"
published: true
tags: [r, analytics, economics]
output:
  html_document:
    keep_md: true
---





*Amiri, S., & Modarres, R. (2017). Comparison of tests of contingency tables. Journal of biopharmaceutical statistics, 1-13. Doi: 10.1080/10543406.2016.1269786.*

The bootstrap tests given in Amiri and Modarres (2017) is implemented in R and explained here.
The source of codes are stored in Github.  


```{}
##### Necessary libraries in R
> library(RCurl)
> library(MASS)
> library(boot)
### Read codes from github
> script <- getURL("https://raw.githubusercontent.com/saeidamiri1/generalcodes/master/bootcat.R", ssl.verifypeer = FALSE)
> eval(parse(text = script))
########


###########################################
###### Example used in paper
## enter data in a matrix
> m<-matrix(c(7,2,5,10,0,1),nrow=2)

> chisq.test(m)$p.value
[1] 0.06676657
Warning message:
In chisq.test(m) : Chi-squared approximation may be incorrect

> fisher.test(m)
Fisher's Exact Test for Count Data
data: m
p-value = 0.06219
alternative hypothesis: two.sided

################
##Bootsrap test
> B<-2000
> I<-dim(m)[1]
> J<-dim(m)[2]


> BX(m,B)
[1] 0.044
There were 50 or more warnings (use warnings() to see the first 50)


> BP(m,B)
[1] 0.032
There were 50 or more warnings (use warnings() to see the first 50)


###########################################
###########################################
########################################### 
> chisq.test(m)$p.value
[1] 0.815404


> fisher.test(m)
Fisher's Exact Test for Count Data

data: m
p-value = 0.8175
alternative hypothesis: two.sided

> BX(m,B)
[1] 0.8335
There were 50 or more warnings (use warnings() to see the first 50)

> BP(m,B)
[1] 0.8285
There were 50 or more warnings (use warnings() to see the first 50)
```

