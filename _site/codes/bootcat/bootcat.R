comb<-function(y1){
  m1 <- matrix(0, ncol = J, nrow = I)
  for (i in 1:I) {
    for (j in 1:J) {
      m1[i, j] <- sum(y1[, 1] == i & y1[, 2] == j)
    }
  }
  return(m1)
}

PDIRECT<-function(data,x) {
  ma<-comb(data)
  m1<-chisq.test(ma,correct = F)
  p0<-c(ma/sum(ma))
  me<- c(m1$expect/sum(c(m1$expect)))
  sig0<-diag(p0)-t(t(p0))%*%(t(p0))
  c(t(p0-me)%*%(ginv(sig0))%*%t(t(p0-me)))
}

BP<-function(obs,B){
  obs2<-chisq.test(obs)$expect
  re0<-NULL
  y1<-cross(obs2)
  for(b in 1:B){
    aa<-sample(sum(obs2),sum(obs2),replace=T)
    re0[b]<-PDIRECT(y1[aa,])
  }
  qq <- mean(re0 < PDIRECT(cross(obs)), na.rm = T)
  return(1 - qq)
}

#######
chi.bootDS<-function (data, x) {
  ma <- t(xtabs(~data[x, 2] + data[x, 1]))
  chisq.test(ma, correct = F)$statistic
}

cross<-function (x){
  a <- b <- NULL
  for (i in 1:I) {
    for (j in 1:J) {
      a <- c(a, rep(i, round(x[i, j])))
      b <- c(b, rep(j, round(x[i, j])))
    }
  }
  cbind(a, b)
}

BX<-function (obs, B) {
  obs2 <- chisq.test(obs)$expect
  y1 <- cross(obs2)
  res <- boot(y1, chi.bootDS, B)
  t0 <- chisq.test(obs, correct = F)$statistic
  return(mean(res$t - t0 > 0))
}

