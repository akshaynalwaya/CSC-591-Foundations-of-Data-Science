README.txt

R-Project #2
Student Name: Akshay Nalwaya 
Student ID: 200159155

This file includes the instructions for compiling and running the code written as a solution for hw45R.

Libraries Used:
	- ISLR
	- dplyr
	- bnlearn

RUNNING THE CODE:
1. Installing the required packages:
Use the file installPackages.R to install all the required packages for this assignment.

2. Testing Q1:

Compile and call Validation_Split() function and pass the data along-with the fraction of this data that has to be used as training set, rest will be used for testing/validation.
This function will return the training set and validation set in form of a list.

It can be called in this format -
data_split <- Validation_Split(Default,0.5)

Next compile and call LogisticRegression()function to find the error fraction and it contains solutions to all the parts of ISLR Exercise 5.4 Q5
It returns the error fraction and can be called as -

validation_error <- LogisticRegression(data_split$trainingset,data_split$validation_set)
validation_error


3. Testing Q4:
Compile and call bayesian_network() function and this will plot the Bayesian network for data set and print the conditional probability tables for all the nodes.



DESCRIPTION OF FUNCTIONS USED IN THIS ASSIGNMENT:

For Question #1
Function: 
Validation_Split <- function(data, training_fraction)
Arguments - 
	data: the sample data which is to be partitioned into training and validation set
	training_fraction: fraction of sample data to be allocated for training model
Purpose -
This function partitions the sample data into training and validation sets based on the value of split chosen.
It returns a list of training set and validation set.

LogisticRegression <- function(train_data, validation_data, include_student=FALSE)
Arguments -
	train_data: dataframe, including training samples
	validation_data: dataframe, including validation samples
	include_student: boolean, indicating whether using the student variable in logistic regression
Purpose -
This function applies logistic regression on the partitioned data given by Validation_Split() function. It then applies validation set approach on this data and returns in error in model.


For Question #4

Function:
bayesian_network()
Arguments - No Arguments
It constructs a Bayesian network for given data set bn-data.csv and plots the resulting network.
It also computes conditional probability tables for all the nodes and displays them.


[Code written in RStudio - Version 1.0.153]
[Author: Akshay Nalwaya (Student ID: 200159155)]