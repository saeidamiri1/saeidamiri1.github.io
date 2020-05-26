library("pvclust")
data(lung)
attach(lung)
cancer<-t(lung)
cancer<-cancer[-c(1,20),]

row1<-grep("Adeno",row.names(cancer),  perl=TRUE, value=FALSE)
row2<-grep("normal",row.names(cancer), perl=TRUE, value=FALSE)
row3<-grep("SCLC",row.names(cancer),   perl=TRUE, value=FALSE)
row4<-grep("SCC",row.names(cancer),    perl=TRUE, value=FALSE)
row5<-grep("node",row.names(cancer),   perl=TRUE, value=FALSE)
row6<-grep("LCLC",row.names(cancer),   perl=TRUE, value=FALSE)
length(c(row1,row2,row3,row4,row5,row6))
dim(cancer)
cancer_class<-NULL
cancer_class[row1]<-"Adeno"
cancer_class[row2]<-"normal"
cancer_class[row3]<-"SCLC"
cancer_class[row4]<-"SCC"
cancer_class[row5]<-"node"
cancer_class[row6]<-"LCLC"
lung_cancer<-cbind(cancer_class,cancer)
write.csv2(lung_cancer,file="lung_cancer.csv",row.names = FALSE)
