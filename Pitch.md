Assignment: Course Project: Shiny Application and Reproducible Pitch
========================================================
author: Tomasz Dworowy
date: 11/12/2020
autosize: true

Shiny application witch use decision tree model to predict if user will survive titanic.


Required libraries
========================================================
- Caret - machine learning library
- titanic - data set
- rattle - library use to create readable dendrogram
- dplyr - data manipulation


```r
if (!require("caret"))
    install.packages("caret")
library(caret)
if (!require("titanic"))
    install.packages("titanic")
library(titanic)
if (!require("rattle"))
    install.packages("rattle")
library(rattle)
if (!require("dplyr"))
    install.packages("dplyr")
library(dplyr)
```

Data set summary
========================================================


```
  PassengerId       Survived          Pclass          Name          
 Min.   :  1.0   Min.   :0.0000   Min.   :1.000   Length:891        
 1st Qu.:223.5   1st Qu.:0.0000   1st Qu.:2.000   Class :character  
 Median :446.0   Median :0.0000   Median :3.000   Mode  :character  
 Mean   :446.0   Mean   :0.3838   Mean   :2.309                     
 3rd Qu.:668.5   3rd Qu.:1.0000   3rd Qu.:3.000                     
 Max.   :891.0   Max.   :1.0000   Max.   :3.000                     
                                                                    
     Sex                 Age            SibSp           Parch       
 Length:891         Min.   : 0.42   Min.   :0.000   Min.   :0.0000  
 Class :character   1st Qu.:20.12   1st Qu.:0.000   1st Qu.:0.0000  
 Mode  :character   Median :28.00   Median :0.000   Median :0.0000  
                    Mean   :29.70   Mean   :0.523   Mean   :0.3816  
                    3rd Qu.:38.00   3rd Qu.:1.000   3rd Qu.:0.0000  
                    Max.   :80.00   Max.   :8.000   Max.   :6.0000  
                    NA's   :177                                     
    Ticket               Fare           Cabin             Embarked        
 Length:891         Min.   :  0.00   Length:891         Length:891        
 Class :character   1st Qu.:  7.91   Class :character   Class :character  
 Mode  :character   Median : 14.45   Mode  :character   Mode  :character  
                    Mean   : 32.20                                        
                    3rd Qu.: 31.00                                        
                    Max.   :512.33                                        
                                                                          
```

Model use in application
========================================================


```r
 titanic_train$Survived = as.factor(titanic_train$Survived)
 titanic_train$Sex = as.factor(titanic_train$Sex)
 titanic_train$Pclass = as.factor(titanic_train$Pclass)
 titanic_train <-titanic_train[complete.cases(titanic_train), ]
 
 titanic_train<-titanic_train %>%
  select(Sex, Pclass, Age,SibSp, Parch, Survived)
 
 in_train <- createDataPartition( y = titanic_train$Survived , p = 0.75, list = FALSE)
 test <- titanic_train[-in_train,]

    
 fit <- train(Survived ~ Pclass + Sex + Age + SibSp + Parch, method = 'rpart2', data = titanic_train)
 fancyRpartPlot(fit$finalModel)
```

![plot of chunk unnamed-chunk-3](Pitch-figure/unnamed-chunk-3-1.png)


Model Testing
========================================================


```r
pred <- predict(fit,test)
table(pred, test$Survived)
```

```
    
pred  0  1
   0 93 19
   1 13 53
```

