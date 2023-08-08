---
layout: post
title:  "Probability Proportional to Size"
date: "2023-01-01"
published: true
tags: [RSS]
output:
  html_document:
    keep_md: true
---


*Amiri, S., Hassani, H., & Heravi, S. (2023). An efficient variant of Ranked Set Sampling, Probability Proportional to Size with Application to Economic Data.*


The tests discussed in Amiri et al. (2023) is implemented in R and explained here.
The source of codes are stored in Github. 


```{}
#### Generate the sample 

GenRSS<-function(Y,m,k){
a<-b<-y<-NULL
ii<-1
al<-matrix(NA,ncol=sum(m),nrow=k)
for (j in 1:sum(m)){
al[,ii]<-sample(Y,k,prob=YW,replace=T)
ii<-ii+1
}
return(al)
}

#### Get imperfect RSS
ImpRSS<-function(x,m,k){
ac<-1
ob<-list(1,2,3,4,5)
for (j in 1:k){
for(i in 1:m[j]){
if(j==1) kk<-sample(2,1)
if(j==2) kk<-sample(c(3),1)
if(j==3) kk<-sample(c(2:4),1)
if(j==4) kk<-sample(c(3:5),1)
if(j==5) kk<-sample(c(4,5),1)
bb<-c(sort(x[,ac]))[kk]
ob[[j]][i]<-bb
ac<-ac+1
}
}
return(ob)
}


#### Get perfect RSS
PerRSS<-function(x,m,k){
ac<-1
ob<-list(1,2,3,4,5)
for (j in 1:k){
for(i in 1:m[j]){
if(j==1) kk<-1
if(j==2) kk<-2
if(j==3) kk<-3
if(j==4) kk<-4
if(j==5) kk<-5
bb<-c(sort(x[,ac]))[kk]
ob[[j]][i]<-bb
ac<-ac+1
}
}
return(ob)
}

##### Calculate mean for the given sample
meanm<-function(x){
n<-length(x)
mean((x)/PW[x])/N
}


#####
Y<-seq(1,100,1)
m<-rep(5,5)
n<-sum(m)
N<-100

######### PI=I
YW<-c(rep(1,25),rep(2,25),rep(3,25),rep(4,25))
PW<-YW/sum(YW)

PPS<-RPPS_per<-RPPS_imp<-NULL
for(i in 1:10000){
PPS[i]<-meanm(sample(Y,n,prob=YW,replace=T))
RPPS_per[i]<-meanm(unlist(PerRSS(GenRSS(Y,m,5),m,5)))
RPPS_imp[i]<-meanm(unlist(ImpRSS(GenRSS(Y,m,5),m,5)))
}

c(mean(PPS),var(PPS))
c(mean(RPPS_per,na.rm=T),var(RPPS_per,na.rm=T))
c(mean(RPPS_imp,na.rm=T),var(RPPS_imp,na.rm=T))

####################### PI=II
YW<-c(rep(2,25),rep(1,25),rep(3,25),rep(4,25))
PW<-YW/sum(YW)

PPS<-RPPS_per<-RPPS_imp<-NULL
for(i in 1:10000){
PPS[i]<-meanm(sample(Y,n,prob=YW,replace=T))
RPPS_per[i]<-meanm(unlist(PerRSS(GenRSS(Y,m,5),m,5)))
RPPS_imp[i]<-meanm(unlist(ImpRSS(GenRSS(Y,m,5),m,5)))
}

c(mean(PPS),var(PPS))
c(mean(RPPS_per,na.rm=T),var(RPPS_per,na.rm=T))
c(mean(RPPS_imp,na.rm=T),var(RPPS_imp,na.rm=T))

####################### PI=III
YW<-c(rep(2,25),rep(3,25),rep(1,25),rep(4,25))
PW<-YW/sum(YW)

PPS<-RPPS_per<-RPPS_imp<-NULL
for(i in 1:10000){
PPS[i]<-meanm(sample(Y,n,prob=YW,replace=T))
RPPS_per[i]<-meanm(unlist(PerRSS(GenRSS(Y,m,5),m,5)))
RPPS_imp[i]<-meanm(unlist(ImpRSS(GenRSS(Y,m,5),m,5)))
}

c(mean(PPS),var(PPS))
c(mean(RPPS_per,na.rm=T),var(RPPS_per,na.rm=T))
c(mean(RPPS_imp,na.rm=T),var(RPPS_imp,na.rm=T))

############ PI=IV
YW<-c(rep(4,25),rep(1,25),rep(3,25),rep(2,25))
PW<-YW/sum(YW)


PPS<-RPPS_per<-RPPS_imp<-NULL
for(i in 1:10000){
PPS[i]<-meanm(sample(Y,n,prob=YW,replace=T))
RPPS_per[i]<-meanm(unlist(PerRSS(GenRSS(Y,m,5),m,5)))
RPPS_imp[i]<-meanm(unlist(ImpRSS(GenRSS(Y,m,5),m,5)))
}

c(mean(PPS),var(PPS))
c(mean(RPPS_per,na.rm=T),var(RPPS_per,na.rm=T))
c(mean(RPPS_imp,na.rm=T),var(RPPS_imp,na.rm=T))
```

