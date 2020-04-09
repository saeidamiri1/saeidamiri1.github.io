---
layout: post
title:  "Random RSS"
date: "2018-01-23"
published: true
tags: [r, analytics, RSS]
output:
  html_document:
    keep_md: true
---



*Amiri, S., Jozani Jafari, M., & Modarres, R. (2018). Randomly Selected Order Statistics in Ranked Set Sampling: less expensive comparable alternative to simple random sampling. Environmental and Ecological Statistics. *

The following includes the codes of RSS, RRSS and SRRSS on the data generated from the normal distribution  N(0,1)


```{}
### generate RSS with R from normal 

rss<-function(r){
x1<-NULL
for( i in 1:r){
x1[i]<-sort(rnorm(r))[i]
}
mean(x1)
}


rrss<-function(n,r){
x1<-NULL
k<-sample(n,r,replace=F)
for( i in 1:(r)){
x1[i]<-sort(rnorm(n))[k[i]]
}
mean(x1)
}




srrss<-function(n,r){
x1<-NULL
k1<-sample(c(1:(n/2)),r/2)
k2<-n+1-k1
k<-c(k1,k2)
for( i in 1:(r)){
x1[i]<-sort(rnorm(n))[k[i]]
}
mean(x1)
}


#############
n<-10
r<-6
a<-b<-c<-d<-e<-f<-NULL
for(i in 1:50000){
a[i]<-rss(r)
b[i]<-rrss(n,r)
c[i]<-srrss(n,r)
}


c(mean(a), var(a))
c(mean(b), var(b))
c(mean(c), var(c))

```

