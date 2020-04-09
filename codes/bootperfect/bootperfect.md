---
layout: post
title:  "Bootstrap of RSS"
date: "2018-01-18"
published: true
tags: [r, analytics, economics]
output:
  html_document:
    keep_md: true
---





*Amiri, S., Modarres, R., & Zwanzig, S. (2016). Tests of Perfect Judgment Ranking using Pseudo-samples.
Computational Statistics, DOI: 10.1007/s00180-016-0698-7*


The tests discussed in Amiri et al. (2016) is implemented in R and explained here.
The source of codes are stored in Github. 


```{}
library(RCurl)
### Read codes from github
script <- getURL("https://raw.githubusercontent.com/saeidamiri1/RSS/master/prss/PRSS.R", ssl.verifypeer = FALSE)
eval(parse(text = script))
########


To generate the imperfect RSS from normal(0,1) with Model V with k=5  run the 
following function that can be adopted for any k
 
impRSS<-function (m, k) {
  lambda1<-c(0,1/2,1/2)
  lambda2<-c(1/4,1/2,1/4)
  lambda3<-c(1/3,1/3,1/3)
  lambda4<-c(1/4,1/2,1/4)
  lambda5<-c(1/2,1/2,0)
  a<-b<-y<-NULL
  ii<-1
  x<-matrix(NA,ncol=sum(m),nrow=k)
  for (j in 1:sum(m)){
    x[,ii]<-rnorm(k)
    ii<-ii+1
  }

  ac <- 1
  ob <- list(1, 2, 3, 4, 5)
  for (j in 1:k) {
    for (i in 1:m[j]) {
      if(j==1) {j0<-sample(0:2,1,prob=lambda1,replace=T)}
      if(j==2) {j0<-sample(1:3,1,prob=lambda2,replace=T)}
      if(j==3) {j0<-sample(2:4,1,prob=lambda3,replace=T)}
      if(j==4) {j0<-sample(3:5,1,prob=lambda4,replace=T)}
      if(j==5) {j0<-sample(4:6,1,prob=lambda5,replace=T)}
      ob[[j]][i] <- c(sort(x[, ac]))[j0]
      ac <- ac + 1
    }
  }
  return(ob)
}


# Define your design 
> m<-c(4,3,5,6,6)
> k<-5
> B<-2000
> xx<-impRSS(m,k)

> xx
[[1]]
[1] -0.1702266 -0.4170270 -1.3925779 -2.4777095

[[2]]
[1] -0.22801938  0.49795032 -0.05232756

[[3]]
[1] -0.126019858 -0.198851288  1.238206813  0.157570629 -0.007721763

[[4]]
[1]  0.1991180 -0.1123186 -0.6911788  1.2363997 -0.3216557  0.4892485

[[5]]
[1]  0.9362383  0.5290396  0.5012376  2.1955910  2.5128868 -0.8929663




> BOR(xx, B, m)
[1] 0.003
> BFOD(xx, B, m)
[1] 0.0025
> BJTT(xx, B, m)
[1] 0
```

