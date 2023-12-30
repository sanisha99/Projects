library(dplyr)
library(psych)
library(randomForest)
library(caret)
library(tree)

ab <- read.csv("abalone.data", header=FALSE)
View(ab)
headers <- c("sex","length","diameter","height","whole_weight"
             ,"shucked_weight","viscera_weight","shell_weight","rings")
colnames(ab) <- headers
ab$sex <- as.factor(ifelse(ab$sex=="I",0,ifelse(ab$sex=="M",1,2)))

#Fitting a model with response as number of rings
#Dividing into training and testing datasets
train <- sample(c(TRUE,FALSE),nrow(ab),replace = TRUE,prob=c(0.6,0.4))
test <- (!train)

train_dat <- ab[train,]
test_dat <- ab[test,]
# pairs.panels(ab)
#------------Best Subset Selection---------------------------------------------#

regfit.full=regsubsets(rings~.,data=train_dat, nvmax =8)
summary(regfit.full)

test.mat=model.matrix(rings~.,data=test_dat)

val.errors=rep(NA,8) # Creating a place holder

for(i in 1:8){
  coefi=coef(regfit.full,id=i)
  pred=test.mat[,names(coefi)]%*%coefi
  val.errors[i]=mean((test_dat$rings-pred)^2)
}

plot(val.errors ,type="b") 
which.min(val.errors)
min(val.errors)
coef(regfit.full ,8) #8th model is the best model
#MSE is 4.928

######### Cross-Validation Approach ########

k=10 

set.seed(1)

(folds=sample(1:k,nrow(ab),replace=TRUE))
cv.errors=matrix(NA,k,8, dimnames=list(NULL, paste(1:8))) # Place holder for errors

predict.regsubsets = function(object, newdata, id, ...){
  form=as.formula(object$call[[2]])
  mat=model.matrix(form, newdata)
  coefi=coef(object, id=id)
  xvars=names(coefi)
  mat[,xvars]%*%coefi
}

for(j in 1:k){
  best.fit=regsubsets(rings~., data=ab[folds!=j,], nvmax=8)
  
  for(i in 1:8){
    pred = predict(best.fit, ab[folds==j,], id=i)
    cv.errors[j,i] = mean( (ab$rings[folds==j]-pred)^2 )
  }
}

mean.cv.errors=apply(cv.errors, 2, mean)
which.min(mean.cv.errors)

par(mfrow=c(1,1))
plot(mean.cv.errors ,type="b") 
# We now perform best subset selection on the full data set to obtain the 10-variable model.
reg.best=regsubsets (rings~.,data=ab , nvmax=8)
coef(reg.best ,8)
min(cv.errors)
#MSE is 4.1273

#-------------------------Tree Method------------------------------------#

rings.tree <- tree(rings~.,data=train_dat)
summary(rings.tree)
plot(rings.tree)
text(rings.tree,pretty=0)

yhat <- predict(rings.tree,newdata=test_dat)
mean((yhat-test_dat$rings)^2)
#MSE is 6.113
#--------------------Random Forest---------------------------------------------#
set.seed(101)
rf.rings=randomForest(rings~.,train_dat,mtry=3,importance=TRUE)
yhat.rf.rings = predict(rf.rings,newdata=test_dat)
mean((yhat.rf.rings-test_dat$rings)^2) #test set MSE
#MSE value is 4.335

plot(rf.rings)

#variable importance
# importance(rf.rings)
varImpPlot(rf.rings)
#------------------------------------------------------------------------------#

########--------SEX as the response variable----------------####################
#------------------Tree Method------------------------------#
tree.sex <- tree(sex~.,data=train_dat)
summary(tree.sex)
plot(tree.sex)
text(tree.sex,pretty=0)
yhat.sex.tree <- predict(tree.sex,newdata = test_dat,type="class")
confusionMatrix(test_dat$sex,yhat.sex.tree)
#Accuracy - 53.35%

#------------------Random Forest-----------------------------------------#######
rf.sex=randomForest(sex~.,train_dat,mtry=3,importance=TRUE)

yhat.rf.sex = predict(rf.sex,newdata=test_dat,type="class")
confusionMatrix(test_dat$sex,yhat.rf.sex)
#Accuracy - 55.46%
plot(rf.sex)

#variable importance
# importance(rf.mac)
varImpPlot(rf.sex)
#-----------------------------------------------------------------------------###

#-------------------------PCA-------------------------------------------------###
sex <- ab$sex
ab1 <- ab %>% dplyr::select(,-sex)

sexpca <- prcomp(ab1,center=TRUE,scale=TRUE) # remove the response variable
summary(sexpca) #Summary of all the principal components

names(sexpca) #winePCA has several attributes
# sdev: standard deviation of each principal components
# rotation: the contribution of each variable to each principal component
# center: sample mean for the original variable
# scale : standard deviation of the original variable
# x : value of the PCA for every sample points



# Calculating variance per each PC
pr.var=sexpca$sdev^2
pr.var
pve=pr.var/sum(pr.var)
pve

#Scree plot
par(mfrow =c(1,2))
plot(pve, xlab="Principal Component", ylab="Proportion of Variance Explained", ylim=c(0,1),type='b')
plot(cumsum(pve), xlab="Principal Component", ylab="Cumulative Proportion of Variance Explained", ylim=c(0,1),type='b')



#Visualizing PCA
plot(sexpca)
plot(sexpca$x[,1:2], col = sex)
biplot(sexpca)

library(devtools)
#install_github("vqv/ggbiplot")
library(ggbiplot)
ggbiplot(sexpca,ellipse=TRUE,  groups=sex)
ggbiplot(sexpca,choices=c(1,2),ellipse=TRUE,  groups=sex)


