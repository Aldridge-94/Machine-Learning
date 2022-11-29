#Demo 8-1 Support Vector Machines
#Customer data of a network provider
#A mobile network provider is facing a business problem that lot of customers are
#transitioning to other service provider. This is causing lot of losses to the business
#The company would like to understand the factors which impact the churn of customers 

setwd()
getwd()
customer_churn <- read.csv("Demo 1_ Support Vector Machines.csv")
View(customer_churn)
install.packages("dplyr")
library(dplyr)

count(customer_churn$Churn)

table(customer_churn$Churn)
#483 customers have churned "1"; 2850 have not churned "0"
str(customer_churn)

install.packages("plyr")
library(plyr)
customer_churn$Churn <- sapply(customer_churn$Churn, factor)
str(customer_churn)

#split the data
sample_split <- floor(.7 * nrow(customer_churn))
set.seed(1)
training <- sample(seq_len(nrow(customer_churn)), size = sample_split)
churn_train <- customer_churn[training, ]
churn_test <- customer_churn[-training, ]


#support vector machine (SVM)
install.packages("e1071")
library(e1071)
svm_churn <- svm(Churn ~ ., churn_train)
install.packages("caret")
library(caret)
confusionMatrix(churn_train$Churn, predict(svm_churn), positive = '1')

#test_data
Prediction <- predict(svm_churn, churn_test[-1])
Prediction_results <- table(pred=Prediction, true=churn_test[,1])
print(Prediction_results)






