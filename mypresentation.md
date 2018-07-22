Peer-graded Assignment: Course Project: Shiny Application and Reproducible Pitch
========================================================
author: Gianluca Merendino
date: 23/07/2018
autosize: true

Introduction
========================================================

This presentation will introduce the "Comparative of different linear regression predictions" Shiny application, which was a Course Project for the Developing Data Products class of the Johns Hopkins University, hosted by Coursera.

Application Link: 
Code and data on GitHub: 

Description
========================================================

This simple test appplication shows different linear regression models.
You can compare up to three different linear models, that are
Simple linear regression
Linear regression with a non linear trasformaion of the predictors
Linear regression including an iteraction terms

For the last two you can change some paramters.
The comparison is made 'graphically' and using the ANOVA function
To see it, check some checkbox (better more than one :-))
Please note that to plot a linear regression with more variables than the two showed in the graphic (i.e. 'lm(medv ~ lstat * age, data=Boston)') is not perfecty correct, but this is only a 'test' project!
    

```r
summary(cars)
```

```
     speed           dist       
 Min.   : 4.0   Min.   :  2.00  
 1st Qu.:12.0   1st Qu.: 26.00  
 Median :15.0   Median : 36.00  
 Mean   :15.4   Mean   : 42.98  
 3rd Qu.:19.0   3rd Qu.: 56.00  
 Max.   :25.0   Max.   :120.00  
```

Functionalities
========================================================

![plot of chunk unnamed-chunk-2](mypresentation-figure/unnamed-chunk-2-1.png)

Technical details
========================================================
