library(dplyr)
library(psych)
library(randomForest)
library(caret)
library(tree)
library(glmnet)

ab <- read.csv("abalone.data", header=FALSE)
headers <- c("sex","length","diameter","height","whole_weight"
             ,"shucked_weight","viscera_weight","shell_weight","rings")
colnames(ab) <- headers
ab$sex <- as.factor(ifelse(ab$sex=="I",0,ifelse(ab$sex=="M",1,2)))

#Fitting a model with response as number of rings
#Dividing into training and testing datasets
set.seed(0)
train <- sample(c(TRUE,FALSE),nrow(ab),replace = TRUE,prob=c(0.6,0.4))
test <- (!train)

train_dat <- ab[train,]
test_dat <- ab[test,]
#pairs.panels(ab)

#------------Visualization-----------------------------------------------------#
ggplot(data=ab,aes(x=rings,y=sex,fill=sex))+
  geom_boxplot()+
  coord_flip()

ggplot(data=ab,aes(x=rings,y=sex,fill=sex))+
geom_violin()+
  coord_flip()+
  stat_summary(fun.y=median,geom = "point",shape=23,size=2,fill="red")


#------------Best Subset Selection---------------------------------------------#

regfit.full=regsubsets(rings~.,data=train_dat, nvmax =9)
summary(regfit.full)

test.mat=model.matrix(rings~.,data=test_dat)

val.errors=rep(NA,9) # Creating a place holder

for(i in 1:9){
  coefi=coef(regfit.full,id=i)
  pred=test.mat[,names(coefi)]%*%coefi
  val.errors[i]=mean((test_dat$rings-pred)^2)
}

plot(val.errors ,type="b",ylab = "Mean Squared Error",xlab="Model Number") 
title("Testing Error for Best Subset Selection")


which.min(val.errors)
min(val.errors)
coef(regfit.full ,8) #8th model is the best model
#MSE is 5.21

######### Cross-Validation Approach ########

k=10 

set.seed(1)

(folds=sample(1:k,nrow(ab),replace=TRUE))
cv.errors=matrix(NA,k,9, dimnames=list(NULL, paste(1:9))) # Place holder for errors

predict.regsubsets = function(object, newdata, id, ...){
  form=as.formula(object$call[[2]])
  mat=model.matrix(form, newdata)
  coefi=coef(object, id=id)
  xvars=names(coefi)
  mat[,xvars]%*%coefi
}

for(j in 1:k){
  best.fit=regsubsets(rings~., data=ab[folds!=j,], nvmax=9)
  
  for(i in 1:9){
    pred = predict(best.fit, ab[folds==j,], id=i)
    cv.errors[j,i] = mean( (ab$rings[folds==j]-pred)^2 )
  }
}

mean.cv.errors=apply(cv.errors, 2, mean)
which.min(mean.cv.errors)

par(mfrow=c(1,1))
plot(mean.cv.errors ,type="b",xlab="Number of Variables of the model",
     ylab="Mean Squared Error")
title("K Fold Cross Validation Mean Squared Errors")

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
#MSE is 6.08

set.seed(5454)
cv.data=cv.tree(rings.tree,FUN=prune.tree)


par(mfrow=c(1,2))
plot(cv.data$size,cv.data$dev,type="b")
plot(cv.data$k,cv.data$dev,type="b")
par(mfrow=c(1,1));

# ## selecting the optimal tree
# prune.data=prune.tree(tree1,best=6)
# plot(prune.data)
# text(prune.data,pretty=0)


## error rates
# tree.pred=predict(prune.data,test,type="class") 
#table(tree.pred,test$num)


# confusionMatrix(tree.pred,test$num)

#--------------------Random Forest---------------------------------------------#
set.seed(101)
rf.rings=randomForest(rings~.,train_dat,mtry=3,importance=TRUE)
yhat.rf.rings = predict(rf.rings,newdata=test_dat)
mean((yhat.rf.rings-test_dat$rings)^2) #test set MSE
#MSE value is 4.697

plot(rf.rings,main="Random Forest")


#variable importance
# importance(rf.rings)
varImpPlot(rf.rings)
#-------------------LASSO METHOD-----------------------------------------------#
# use the argument alpha=1 to perform lasso
x_train <- model.matrix(rings~.,data=train_dat)[,-1]
y_train <- train_dat$rings
x_test <- model.matrix(rings~.,data=test_dat)[,-1]
y_test <- test_dat$rings

set.seed (1)
cv.out=cv.glmnet(x_train,y_train,alpha=1)
plot(cv.out)
bestlam=cv.out$lambda.min
bestlam

## calculating MSE
lasso.pred=predict(lasso.mod,s=bestlam ,newx=x_test)
mean((lasso.pred-y_test)^2) # slightly larger than ridge
#5.198313
coef(cv.out)

########--------SEX as the response variable----------------####################
#------------------Tree Method------------------------------#
tree.sex <- tree(sex~.,data=train_dat)
summary(tree.sex)
plot(tree.sex)
text(tree.sex,pretty=0)
yhat.sex.tree <- predict(tree.sex,newdata = test_dat,type="class")
confusionMatrix(test_dat$sex,yhat.sex.tree)
#Accuracy - 49.57

#------------------Random Forest-----------------------------------------#######
rf.sex=randomForest(sex~.,train_dat,mtry=3,importance=TRUE)

yhat.rf.sex = predict(rf.sex,newdata=test_dat,type="class")
confusionMatrix(test_dat$sex,yhat.rf.sex)
#Accuracy - 53.64%
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


