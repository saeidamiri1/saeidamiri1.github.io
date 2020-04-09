---
title: General Hybrid Clustering.  
description: Clustering of Non-convex data.
date: 2018-03-10
author: Saeid Amiri
published: true
tags: Clustering
categories: [blog]
comments: true
---

Clustering is an unsupervised technique to find underlying structure in a dataset by grouping
data points into subsets that are as homogeneous as possible, clustering is a widely used unsupervised technique for identifying natural classes within a set of data. [Amiri et al. (2018)](https://arxiv.org/pdf/1503.01183v2.pdf) proposed a clustering technique for general clustering problems including those that have non-convex clusters. The proposed is fully nonparametric and it generates clusters for a given desired number of clusters K. They also discussed estimating the size of cluster.  

##  Clustering
The proposed clustering method is referred to as Stabilized Hybrid Clustering (SHC) and its steps is presented in Algorithm 1,

<img src="https://github.com/saeidamiri1/GHC/blob/master/algorithm1.png" width="800">

Algorithm 1 is implemented in R,  

```
SHC(x,K,B=200,knmin,knmax)
```

The arguments are: ```x``` is the observation, use the R's matrix format. ```B``` is number of run to get a stabilized clusters, we used B=200 in our computations. Concerning ```B```, run the code with different Bs and if you see huge different in result, increase the number of iterations. knmin and knmax are the minimum and maximum size of cluster to get the stabilized clustering. We used knmin=2 and knmax=n/5, where n is the sample size.  
This ```SHC()``` provides the distance matrix and the predicted cluster.  


##  Size of Cluster
[Amiri et al. (2018)](https://arxiv.org/pdf/1503.01183v2.pdf) also discussed a technique to estimate the size of clusters, it is presented in Algorithm 2,

<img src="https://github.com/saeidamiri1/GHC/blob/master/algorithm2.png" width="800">

Algorithm 2 is implemented in R,  
```
EK(observation,B=200,knmin,knmax)
```

## Source
The source of codes are available in GitHub and using the following code can be uploaded in R
```
> source('https://raw.githubusercontent.com/saeidamiri1/GHC/master/SHC.R')
```

Also load the following libraries to run the computations in parallely,

```
> library("foreach")
> library("doParallel")
```

##  Data set
To describe the codes, we used the spiral data which is a non-convex data, the following script load source, dataset and plot it,

```
> source('https://raw.githubusercontent.com/saeidamiri1/GHC/master/SHC.R')
> library("foreach")
> library("doParallel")

> datasource <- "https://github.com/saeidamiri1/GHC/blob/master/SPIRAL.RData?raw=true"
> load(url(datasource))
> Spiral
> plot(Spiral)
```
<img src="https://github.com/saeidamiri1/GHC/blob/master/Rplot.jpeg" width="300">


# Run the Cluster
Once the data and the codes are loaded in R, the clustering can be obtained using the following script

```
> knmin0<-2
> knmax0<-floor(dim(Spiral)[1]/5)
> knmax0
[1] 62
> CLUS<-SHC(Spiral,3,B=200,knmin=knmin0,knmax=knmax0)
```

The dendrogram can be also plotted,
```
> # plot the dendrogram
> plot(hclust(CLUS[[1]],method="single"),h=-1)
```

<img src="https://github.com/saeidamiri1/GHC/blob/master/Rplot01.jpeg" width="500">


The predicted clusters are also available,

```
> # print the assigned clusters to observation
> print(CLUS[[2]])
  [1] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
 [42] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
 [83] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2
[124] 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2
[165] 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2
[206] 2 2 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3
[247] 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3
[288] 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3
```

```
# plot the data with the assigned clusters
plot(Spiral,col=CLUS[[2]])
```
<img src="https://github.com/saeidamiri1/GHC/blob/master/Rplot02.jpeg" width="300">


It is of interest to run the proposed method for a cluster of #4,  the following shows the codes and the clusters,

```
> CLUS<-SHC(Spiral,4,B=200,knmin=knmin0,knmax=knmax0)
> plot(Spiral,col=CLUS[[2]])
```

<img src="https://github.com/saeidamiri1/GHC/blob/master/Rplot03.jpeg" width="300">



##  Size of clusters
 The following script shows the function of estimating the size of clusters,

```
> KCLUS<-EK(Spiral,B=200,knmin=knmin0,knmax=knmax0)
[1] 3
```

```
# plot the dendrogram
> plot(hclust(KCLUS[[1]],method="single"),h=-1)
```
<img src="https://github.com/saeidamiri1/GHC/blob/master/Rplot04.jpeg" width="500">


```
> # print the assigned clusters to observation
> print(KCLUS[[2]])
[1] 3
```


### References
[Amiri, S., Clarke, B, Clarke, J. & Koepke, H.A. (2018). A General Hybrid Clustering Technique.](https://arxiv.org/pdf/1503.01183v2.pdf)
