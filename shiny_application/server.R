library(shiny)


if (!require("e1071"))
    install.packages("e1071", dependencies = TRUE)

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

shinyServer(function(input, output) {
    
    titanic_train$Survived = as.factor(titanic_train$Survived)
    titanic_train$Sex = as.factor(titanic_train$Sex)
    titanic_train$Pclass = as.factor(titanic_train$Pclass)
    titanic_train <-titanic_train[complete.cases(titanic_train), ]
    
    titanic_train<-titanic_train %>%
        select(Sex, Pclass, Age,SibSp, Parch, Survived)
    
    
    fit <- train(Survived ~ Pclass + Sex + Age + SibSp + Parch, method = 'rpart2', data = titanic_train, na.action = na.omit)
    
    res <-reactive({
        test <- data.frame(Pclass=as.factor(input$Class),
                           Sex=as.factor(input$sex),
                           Age=as.numeric(input$age),
                           SibSp=as.numeric(input$sibSp),
                           Parch=as.numeric(input$parch))
        pred <- predict(fit,test)
        if(as.numeric(pred) == 1){
            return("YES") 
        }
        else {
            return("NO") 
        }
    })
    output$survive = res
    output$plot = renderPlot({fancyRpartPlot(fit$finalModel)})

})
