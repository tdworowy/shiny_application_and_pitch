library(caret)

install.packages("titanic")
library(titanic)
library(dplyr)
library(rattle)
titanic_train$Survived = as.factor(titanic_train$Survived)

titanic_train$Survived = as.factor(titanic_train$Survived)
titanic_train$Sex = as.factor(titanic_train$Sex)
titanic_train$Pclass = as.factor(titanic_train$Pclass)
titanic_train <-titanic_train[complete.cases(titanic_train), ]


titanic_train<-titanic_train %>%
  select(Sex, Pclass, Age,SibSp, Parch, Survived)


fit <- train(Survived ~ Pclass + Sex + Age + SibSp + Parch , method = 'rpart2', data = titanic_train, maxdepth = 5)

test <- data.frame(Pclass=1,Sex="male",Age=22)

predict(fit,test)


in_train <- createDataPartition( y = titanic_train$Survived , p = 0.75, list = FALSE)
test <- titanic_train[-in_train,]


pred <- predict(fit,test)
table(pred, test$Survived)

fancyRpartPlot(fit$finalModel)