url1="https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv"
url2="https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv"
download.file(url1, destfile="pmltraining.csv")
download.file(url2, destfile="pmltesting.csv")

trainData=read.csv("pmltraining.csv")
testUltimate=read.csv("pmltesting.csv")

# function finding variables with missing values
nacols <- function(x){
  y <- sapply(x, function(xx)any(is.na(xx)))
  names(y[y])
}  
# variables with missing vals
misscol<-nacols(testUltimate)

# omitting any variables containing any missing values 
library(gdata)
testUltimate=remove.vars(testUltimate, names=misscol, info=F)
trainData=remove.vars(trainData, names=misscol, info=F)
# all the cases complete
sum(complete.cases(trainData))
sum(complete.cases(testUltimate))
testUltimat<-testUltimate[,-(1:8)]
testUltimate<-testUltimate[,-(1:8)]
trainData<-trainData[,-(1:8)]

# data partitioning
library('caret')
set.seed(1)
inTrain <- createDataPartition(trainData$classe, p = 3/4, list = FALSE)
training=trainData[inTrain,]
testing=trainData[-inTrain,]

# training random forest
trcl<-trainControl(method="cv", number=5, allowParallel=T, verbose=T)
fitrf<-train(classe~.,data=training, method="rf", trControl=trcl, verbose=F)
# prediction and error statistics
predRF<-predict(fitrf, newdata=testing)
confusionMatrix(predRF, testing$classe)

# traning naive bayes
fitnb<-train(classe~.,data=training, method="nb", trControl=trcl, verbose=F)
# prediction and error statistics
predNB<-predict(fitnb, newdata=testing)
confusionMatrix(predNB, testing$classe)

# linear discriminant analysis
fitlda<-train(classe~.,data=training, method="lda", trControl=trcl, verbose=F)
predLDA<-predict(fitlda, newdata=testing)
confusionMatrix(predLDA, testing$classe)

# training boosting with trees
fitgbm<-train(classe~.,data=training, method="gbm", trControl=trcl, verbose=F)
predGBM<-predict(fitgbm, newdata=testing)
cmgbm=confusionMatrix(predGBM, testing$classe)
str(cmgbm)
cmgbm[[3]][1]
