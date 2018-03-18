README.txt

ASSIGNMENT #03
Student Name: Akshay Nalwaya 
Student ID: 200159155

This file includes the instructions for compiling and running the code written as a solution for Assignment#03.

Libraries Used:
	- ggplot2
	- gridExtra
	- data.table
	- biglm

Functions present in the file:

CoinFlip()
Arguments - -N/A-
Output - Proportion of tails after 10000 trials
Plot - Graph for variation of cumulative proportion of tails when repeating the experiment multiple times.
Description - This function contains the solution to problem 1 of the assignment. It simulates coin tossing experiment 10000 times with Heads as 0 and Tails as 1 and returns the cumulative proportion of tails after the experiment.


CLT <- function(populationDistribution, sampleSize, numberOfSamples)
Arguments -
	populationDistribution: The type of population distribution
	sampleSize: The size of samples to be taken
	numberOfSamples: Number of samples to be taken
Output - Mean and Standard Error
Plot - Graph to prove the mean of samples follow a normal distribution when size of samples is sufficiently large.
Description - CLT() contains solution to problem 2 of the assignment. It takes a random sample based on the type of distribution given and then taken samples of size specified in function call, repeating this for the number of samples given.
Then, mean of all the samples is taken and graph is plotted for it. It is observed that these values follow a normal distribution.


SLR()
Arguments - -N/A-
Output - The best covariate amongst all 3 variables
Plot - 3 plots for regression of Sales for each of the variables (TV, Newspaper, radio)
Description - This function contains solution to problem 3(a) of the assignment. It plots linear regression for all the variables and computes the each of their correlation with Y (dependent variable). All the correlation values are compared and the highest one is returned, denoting the best covariate.


MLR()
Arguments - -N/A-
Output - The regression coefficients for MLR
Plot - -N/A-
Description - This function contains solution to problem 3(b) of assignment. It computes multiple linear regression model for the data and returns the intercept and coefficients.


LogisticRegression()
Arguments - -N/A-
Output - The regression coefficients for Logistic regression
Plot - -N/A-
Description - This function contains solution to problem 4 of assignment. It computes logistic regression model for the data and returns the intercept and coefficients for all the variables(X1, X2 and X3).
glm() function is used for logistic regression model generation.

LogisticRegressionImproved()
Arguments - -N/A-
Output - Accuracy of the new and old logistic model
Plot - -N/A-
Description - This function contains solution to problem 5 of assignment. It reads the same dataset as given for problem 4 and computes its accuracy. Now, it is observed that the data only contains values in form of 0 and 1, so we can use family as binomial() with link as 'logit' (by default). The accuracy is again measured and printed.


BigSLR()
Arguments - -N/A-
Output - The slope and intercept of the linear regression model
Plot - Simple regression plots for the main population and the individual samples
Description - This function contains solution to problem 6 of assignment. It reads a large dataset and fits a simple linear regression model using biglm() function and prints its intercept and slope values. Also, as a part of solution to problem 6(b), it takes samples of sizes specified in the problem gives the intercept and slope values for the fitted linear regression models on these sample.

[Code writen on RStudio - Version 1.0.153]
[Author: Akshay Nalwaya (Student ID: 200159155)]