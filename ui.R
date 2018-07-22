#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinyjs)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
useShinyjs(),
    
  # Application title
  titlePanel("Comparative of different linear regression predictions"),
div(
    "This simple test appplication shows different linear regression models", 
    br(),
    "You can compare up to three different linear models, that are",
    tags$ol(
        tags$li("simple linear regression"), 
        tags$li("Linear regression with a non linear trasformaion of the predictors"), 
        tags$li("Linear regression including an iteraction terms")
    ),
    "For the last two you can change some paramters.",
    "The comparison is made 'graphically' and using the ANOVA function",
    "To see it, check some checkbox (better more than one :-))",
    br(),
    "Please note that to plot a linear regression with more variables than the two showed in the graphic (i.e. 'lm(medv ~ lstat * age, data=Boston)') is not perfecty correct, but this is only a 'test' project!",
    br(),
    br()
),

  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
        checkboxInput("linear", "Include simple linear regression", FALSE),
        strong("lm(medv ~ ., data='data = Boston')"),
        checkboxInput("poly", "Include non linear trasformation of the predictors", FALSE),
        sliderInput("bins",
                   "Vale of power 'n':",
                   min = 2,
                   max = 10,
                   value = 5),
        strong("lm(medv ~ poly(lstat,n) ,data = Boston)"),
        checkboxInput("iter", "Include iteraction terms in linear regression", FALSE),
        radioButtons("typeIter", "Include single terms:",
                     c("Yes" = "yes",
                       "No" = "no")),
        strong(id="yesSingleTerms","lm(medv ~ lstat * age, data=Boston)"),
        strong(id="noSingleTerms","lm(medv ~ lstat : age, data=Boston)")
       
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("plot"),
       h2("Output of anova function:"),
       tableOutput('aovSummary')
    )
  )
))
