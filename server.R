#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
#library(shinydashboard)
library(shinyjs)
library(MASS)
library(ISLR)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    lmLinear = reactive({
        
        fit = NULL
        linear <- input$linear
        if(linear == TRUE) {
           
            fit <- lm(medv ~ lstat, data=Boston)
        }
       
        return(fit)
    })
    
    lmIter = reactive({
        
        fit = NULL
        iter <- input$iter
        if(iter == TRUE) {
            if (input$typeIter == 'yes' )
                fit <- lm(medv ~ lstat * age, data=Boston)
            else
                fit <- lm(medv ~ lstat : age, data=Boston)
        }
        
        return(fit)
    })
    
    lmPoly = reactive({
        
        fit = NULL
        n <- input$bins 
        poly <- input$poly
        if(poly == TRUE) {
            
            fit <- lm(medv ~ poly(lstat,n) ,data = Boston)
        }
        
        return(fit)
    })
   
    output$aovSummary = renderTable({
        
        fitPoly <- lmPoly()
        fitLinear <- lmLinear()
        fitIter <- lmIter()
        
        if(!is.null(fitPoly) && !is.null(fitLinear) && !is.null(fitIter)) {
            anova(fitLinear,fitPoly,fitIter)
        } else if(!is.null(fitPoly) && !is.null(fitLinear)) {
            anova(fitPoly,fitLinear)
        } else if(!is.null(fitPoly) && !is.null(fitIter)) {
            anova(fitPoly,fitIter)
        } else if(!is.null(fitLinear) && !is.null(fitIter)) {
            anova(fitLinear,fitIter)
        }
        
    })
    
    hideShowPoly = reactive({
        
        if (input$poly == "FALSE") {
            hide(id = "bins", anim = TRUE)
        } else {
            show(id = "bins", anim = TRUE)
        }
    })
    
    hideShowIter = reactive({
        
        if (input$iter == "FALSE") {
            hide(id = "typeIter", anim = TRUE)
        } else {
            show(id = "typeIter", anim = TRUE)
        } 
        if (input$typeIter == 'yes') {
            hide(id = "noSingleTerms", anim = FALSE)
            show(id = "yesSingleTerms", anim = FALSE)
        } else {
            hide(id = "yesSingleTerms", anim = FALSE)
            show(id = "noSingleTerms", anim = FALSE)
        }
    })
    
    output$plot <- renderPlot({
        hideShowPoly()
        hideShowIter()
        plot(Boston$lstat, Boston$medv)
        
        fitLinear <- lmLinear()
        if (!is.null(fitLinear)) {
            abline(fitLinear)
        }
        
        fitPoly <- lmPoly()
        if(!is.null(fitPoly)) {
            lines(sort(Boston$lstat), fitted(fitPoly)[order(Boston$lstat)])
        }
        
        fitIter <- lmIter()
        if(!is.null(fitIter)) {
            abline(fitIter)
        }
        
    })
        

})
