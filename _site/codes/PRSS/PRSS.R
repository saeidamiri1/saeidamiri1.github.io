vmean<-function (x) {
  xv <- NULL
  for (i in 1:length(x)) {
    xv[i] <- mean(x[[i]])
  }
  xv
}


#########BOR
# RSSO53

RSSPERFECT<-function (x, m, k) {
  ac <- 1
  ob <- replicate(k, list()) 
  for (j in 1:k) {
    n11<-NULL
    
    for (i in 1:1) {
      sa <- sample(1:k, k, replace = TRUE)
      
      for(k0 in 1:k){
      n11[k0] <- sum(sa == k0)
      }
      
      xx1<-replicate(k, list()) 
      for(k0 in 1:1){
      xx1[[k0]] <- sample(x[[k0]], (n11[k0]), replace = TRUE)
      }
      for(k0 in 2:k){
      xx1[[k0]] <- sample(x[[k0]], (n11[k0]), replace = TRUE)
      }
      
      ob[[j]] <- c(sort(unlist(xx1))[j])
      ac <- ac + 1
    
    }
    
    for (i in 2:m[j]) {
      sa <- sample(1:k, k, replace = TRUE)
      
      for(k0 in 1:k){
        n11[k0] <- sum(sa == k0)
      }
      
      xx1<-replicate(k, list()) 
      for(k0 in 1:1){
        xx1[[k0]] <- sample(x[[k0]], (n11[k0]), replace = TRUE)
      }
      for(k0 in 2:k){
        xx1[[k0]] <- sample(x[[k0]], (n11[k0]), replace = TRUE)
      }
      
      ob[[j]][i] <- c(sort(unlist(xx1))[j])
      ac <- ac + 1
    }  
  }
  return(ob)
}


 WW0<-function (x) {
  xr <- rank(unlist(x))
  I0 <- 0
  K <- length(x)
  n <- length(x[[1]])
  zz <- 1
  ac <- 1
 # ob2 <- list(1, 2, 3, 4, 5)

  ob2<-replicate(k, list()) 
  
  for (j in 1:k) {
    for (i in 1:1) {
      ob2[[j]] <- xr[ac]
      ac <- ac + 1
    }
  }
  
  for (j in 1:k) {
    for (i in 2:m[j]) {
      ob2[[j]][i] <- xr[ac]
      ac <- ac + 1
    }
  }
  
  
  ac <- 1
 # ob3 <- list(1, 2, 3, 4, 5)
  ob3 <-replicate(k, list()) 
  
  for (j in 1:k) {
    for (i in 1:1) {
      ob3[[j]] <- ac
      ac <- ac + 1
    }
  }
  for (j in 1:k) {
    for (i in 2:m[j]) {
      ob3[[j]][i] <- ac
      ac <- ac + 1
    }
  }
  
  aa <- 0
  for (j in 1:k) {
    aa <- aa + sum((sort(ob2[[j]]) - ob3[[j]])^2)
  }
  return(aa)
 }
 
 
 
BOR<- function (xx, B, m) {
   Tb <- NULL
   x1 <- vmean(xx)
   for (b in 1:B) {
     xxb <- RSSPERFECT(xx, m, k)
     Tb[b] <- WW0(xxb)
   }
   z0 <- sum((WW0(xx) < Tb))/(B)
   z0
 }
 

########
#######




BJTT0<-function (x) {
  I0 <- 0
  K <- length(x)
  n <- length(x[[1]])
  for (r1 in 1:(K - 1)) {
    for (r2 in (r1 + 1):K) {
      for (i in 1:(length(x[[r1]]))) {
        for (h in 1:(length(x[[r2]]))) {
          I0 <- I0 + sum(x[[r1]][i] > x[[r2]][h])
        }
      }
    }
  }
  I0
}

BJTT<-function (xx, B, m) {
  Tb <- NULL
  x1 <- vmean(xx)
  for (b in 1:B) {
    xxb <- RSSPERFECT(xx, m, k)
    Tb[b] <- BJTT0(xxb)
  }
  Tb0 <- BJTT0(xx)
  r00 <- 0
  if (quantile(Tb, 0.05, na.rm = TRUE) <= Tb0 & Tb0 <= quantile(Tb, 
                                                                0.95, na.rm = TRUE)) 
    r00 <- 1
  r00
}

########
########
########


BFOD<-function (xx, B, m){
  Tb <- NULL
  x1 <- vmean(xx)
  for (b in 1:B) {
    xxb <- RSSPERFECT(xx, m, k)
    Tb[b] <- BFOD0(xxb)
  }
  z0 <- sum((BFOD0(xx) > Tb))/(B)
  z0
}

BFOD0<-function (x) {
  xr <- rank(unlist(x))
  I0 <- 0
  K <- length(x)
  n <- length(x[[1]])
  zz <- 1
  for (r1 in 1:(K)) {
    for (i in 1:(length(x[[r1]]))) {
      I0 <- I0 + r1 * xr[zz]
      zz <- zz + 1
    }
  }
  I0
}


#######
#######
#######

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



