library(shiny)

shinyUI(fluidPage(

    titlePanel("Would you survive Titanic?"),
    sidebarLayout(
        sidebarPanel(
                    selectInput("Class",label = "Class",choices = c(1,2,3)),
                    selectInput("sex",label = "Sex",choices = c("male","female")),
                    textInput("age","age",value=20),
                    textInput("sibSp","number of Siblings/Spouses (aboard)",value=1),
                    textInput("parch","number of Parents/Children (aboard)",value=2),
                    ),

        mainPanel(
            h3("Survive"),
            textOutput("survive"),
            h3("Dendogram"),
            plotOutput("plot"),
        )
    )
))
