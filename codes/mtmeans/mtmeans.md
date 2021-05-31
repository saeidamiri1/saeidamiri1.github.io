---
layout: post
title:  "Meta inference"
date: "2021-05-30"
published: true
tags: [RSS]
output:
  html_document:
    keep_md: true
---





*Amiri, S. (2021). Meta inference of Heterogeneous Data Streams.
Journal of Biopharmaceutical Statistics, to be appeared *


This work aims to explore the meta inference, where data are being collected from different studies. Providing an accurate estimate of the mean from separate studies is a central aspect of the practical sciences.
The source of codes are stored in Github. 


```{}
# 
CM<-function(X){
  mean(unlist(lapply(X,mean)))
}

#poolrd mean
PM<-function(X){
  mean(unlist(X))
}

# GD estimstor
GD<-function(X){
  wgd<-(unlist(lapply(X,length))/unlist(lapply(X,var)) )
  wgd<-wgd/sum( wgd)
  sum(wgd*unlist(lapply(X,mean)))
}


#MlE estimator
MLE<-function(X){
  S00<-unlist(lapply(X,var))
  n00<-unlist(lapply(X,length))
  xba1<-unlist(lapply(X,mean))
  ML0<-function(theta){
    theta0<-0
    for( i in 1:(length(X))){
      theta0<-theta0+sum(n00[i]/2*(log(theta[i+1]^2)+S00[i]/theta[i+1]^2+(xba1[i]-theta[1])^2/theta[i+1]^2))
    }
    return(theta0)
  }
  s0<-nlm(ML0, theta <- c(mean(xba1),S00^.5), hessian=TRUE)$estimate[(1:(length(X)))+1]
  wgd<-unlist(lapply(X,length))/ s0^2
  wgd<-wgd/sum(wgd)
  sum(wgd*unlist(lapply(X,mean)))
}



#####
SV<-function(X){
  wgd<-(unlist(lapply(X,var))/unlist(lapply(X,length)))
  wgd0<-NULL
  for( i in 1:(length(X))){ wgd0[i]<-sum(wgd[-i]) }
  wgd0<-wgd0/sum(wgd0)
  sum(wgd0*unlist(lapply(X,mean)))
}



DGD<-function(X){
  xm0<-GD(X)
  var1<-function(x) sum((x-xm0)^2)/(length(x)-1)
  wgd<-(unlist(lapply(X,length))/unlist(lapply(X,var1)) )
  wgd<-wgd/sum( wgd)
  sum(wgd*unlist(lapply(X,mean)))
}

DSV<-function(X){ 
  xm0<-SV(X)
  var1<-function(x) sum((x-xm0)^2)/(length(x)-1)
  wgd<-(unlist(lapply(X,var1))/unlist(lapply(X,length)))
  wgd0<-NULL
  for( i in 1:(length(X))){ wgd0[i]<-sum(wgd[-i]) }
  wgd0<-wgd0/sum(wgd0)
  sum(wgd0*unlist(lapply(X,mean)))
}

  
  
####################
  ##################
  

VDGD<-function(X){
  bz<-NULL
  for(b in 1:500){
    z<-list()
    j<-1
    for(i in 1:length(X)){
      z[[j]]<-sample(X[[i]],replace=TRUE)
      j<-j+1
    }
    bz[b]<-DGD(z)
  }
  var(bz)
}


VDSV<-function(X){
  bz<-NULL
  for(b in 1:500){
    z<-list()
    j<-1
    for(i in 1:length(X)){
      z[[j]]<-sample(X[[i]],replace=TRUE)
      j<-j+1
    }
    bz[b]<-DSV(z)
  }
  var(bz)
}

DGDSV<-function(X){
  SL0<-which.min(c(VDGD(X),VDSV(X)))
  if(SL0==1) res0<-DGD(X)
  if(SL0==2) res0<-DSV(X)
  return(res0)
}


DGDSV<-function(X){
  v1<-VDGD(X)
  v2<-VDSV(X)
  
  res0<-DSV(X)*v1/(v1+v2) + DGD(X)*v2/(v1+v2)
  return(res0)
}


```

