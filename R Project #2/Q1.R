# Solution to R1 - HW45R
# Student Name: Akshay NAlwaya
# Student ID: 200159155

require(ISLR)
require(dplyr)

#Q1
# Inputs:
#   data: the sample data which is to be partitioned into training and validation set
#   training_fraction: fraction of sample data to be allocated for training model
# return:
#   list containing training set and validation set
Validation_Split <- function(data, training_fraction){
  
  if(training_fraction<=0 || training_fraction>=1){
    print("ERROR: Improper splitting of data.")
    print("[value should be within 0 and 1]")
    return(NULL)
  }
  #Part(b)(i). Splitting the sample set into training and validation set
  rows <- nrow(data)
  bound <- training_fraction*rows
  training_set <- slice(data,1:bound)
  validation_set <- slice(data,(bound+1):rows)
  return(list(trainingset = training_set,validation_set = validation_set))
}

# Inputs:
#   train_data: dataframe, including training samples
#   validation_data: dataframe, including validation samples
#   include_student: boolean, indicating whether using the student variable in logistic regression
# return: 
#   result: float, test error(validation error), range in [0, 1]
LogisticRegression <- function(train_data, validation_data, include_student=FALSE){
  
  # Part (a):
  # Fit a logistic regression model that uses income and balance to predict default.
  logit_model <- glm(default ~ income + balance, data = Default, family = "binomial")
  summary(logit_model)
  
  #Part (b)(ii) Fit a multiple logistic regression model using only the training
  # observations.
  train_model <- glm(default ~ income + balance, data = train_data, family = "binomial")
  train_model$coefficients
  #print(summary(train_model))
  
  if(include_student==TRUE){
    train_model <- glm(default ~ income + balance + student, data = train_data, family = "binomial")
  }

  # Part (b)(iii) Obtain a prediction of default status for each individual in
  # the validation set by computing the posterior probability of default for 
  # that individual, and classifying the individual to the default category
  # if the posterior probability is greater than 0.5
  prediction <- predict(train_model,validation_data,type = "response")
  #print(summary(prediction))
  
  # Part (b)(iv) Compute the validation set error, which is the fraction of
  # the observations in the validation set that are misclassified.
  temp <- rep("No",length(prediction))
  for(i in 1:length(temp)){
    if(prediction[i]>0.5){
      temp[i] <- "Yes"
    }
  }
  
  error <- 0
  for(i in 1:length(temp)){
    if(validation_data$default[i]!=temp[i])
      error <- error + 1
  }
  #print(error)
  result <- error/nrow(validation_data)
  return(result)
}
 
# Part (c) Repeat the process in (b) three times, using three different splits
# of the observations into a training set and a validation set. Comment
# on the results obtained.

# setting training data as 50%
data_split <- Validation_Split(Default,0.5)
validation_error <- LogisticRegression(data_split$trainingset,data_split$validation_set)
validation_error

# setting training data as 70%
data_split <- Validation_Split(Default,0.7)
validation_error <- LogisticRegression(data_split$trainingset,data_split$validation_set)
validation_error

#setting training data as 60%
data_split <- Validation_Split(Default,0.6)
validation_error <- LogisticRegression(data_split$trainingset,data_split$validation_set)
validation_error

# Part (d) Now consider a logistic regression model that predicts the probability
# of default using income, balance, and a dummy variable for student. Estimate the 
# test error for this model using the validation set approach. Comment on whether or
# not including a dummy variable for student leads to a reduction in the test error rate.

data_split <- Validation_Split(Default,0.5)
validation_error <- LogisticRegression(data_split$trainingset,data_split$validation_set,include_student = TRUE)
validation_error
