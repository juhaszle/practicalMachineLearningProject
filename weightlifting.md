---
title: "Coursera Practical Machine Learning Project"
author: "dr Juhasz"
subtitle: "Classifying Weight Lifitng Exercise"
output: html_document
---
##Executive summary  
**Data**: extract from the *Qualitative Activity Recognition* data collected by Velloso et al. (2013)  contains  records from sensors worn by 6 subjects during physical exercising. It has 19622 data points with 160 features.  
**Objectives**: The subjects were asked to perform barbell lifts correctly and incorrectly in 5 different ways. The goal of our project was to predict the manner (5 different ways) in which they did the exercise (classe variable) on the base of the other accelerator readings.  
**Methods**: Classification, predictive methods: Random forests, Naive bayes, linear discriminant analysis, boosting. All methods were applied with 5-fold cross-validation.  
**Resuls**: The randoms forest method yielded almost prerfect predictions appying to the holdup test set. Its accuracy exceded 99%. The Generalized Boosted Model (gbm) made predictions with accuracy more than 96%. The two further methods showed more out of sample errors. The naive Bayes' accuracy was just below 75%, but the linear discriminant analysis was not able to reach the 65%.   

## Background  
Using devices such as Jawbone Up, Nike FuelBand, and Fitbit it is now possible to collect a large amount of data about personal activity relatively inexpensively. These type of devices are part of the quantified self movement ??? a group of enthusiasts who take measurements about themselves regularly to improve their health, to find patterns in their behavior, or because they are tech geeks. One thing that people regularly do is quantify how much of a particular activity they do, but they rarely quantify how well they do it. In this project,  Velloso et al. (2013) goal was to use data from accelerometers on the belt, forearm, arm, and dumbell of 6 participants(on body approach). They were asked to perform barbell lifts correctly and incorrectly in 5 different ways.  
Six young health participants were asked to perform one set of 10 repetitions of the Unilateral Dumbbell Biceps Curl in five different fashions: exactly according to the specification (Class A), throwing the elbows to the front (Class B), lifting the dumbbell only halfway (Class C), lowering the dumbbell only halfway (Class D) and throwing the hips to the front (Class E). Class A corresponds to the specified execution of the exercise, while the other 4 classes correspond to common mistakes.  
The goal of our project was to predict the manner (5 different ways) in which they did the exercise (classe variable) on the base of the other accelerator readings (variables).  

## Exploring and cleaning dataset  
The original source of the dataset:http: //groupware.les.inf.puc-rio.br/har, but it is accessible at the Practical Machine Learning course's homepage.

```{r downloading , results='hide', cache=TRUE}
url1="https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv"
url2="https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv"
download.file(url1, destfile="pmltraining.csv")
download.file(url2, destfile="pmltesting.csv")

trainData=read.csv("pmltraining.csv")
testUltimate=read.csv("pmltesting.csv")

```
