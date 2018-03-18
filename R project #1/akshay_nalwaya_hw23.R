# removing variables
rm(list=ls())

require(data.table)
require(ggplot2)
require(gridExtra)
require(biglm)

#Q1 
# return: float of the cumulative proportion on tails
CoinFlip <- function(){
  flip_count <- 10000
  flip_num <- c(1:flip_count)
  # assuming 0 denotes 'Heads' and 1 denotes 'Tails'
  outcome <- sample(c(0,1),flip_count,replace = TRUE)
  coin_toss_data <- data.frame(flip_num,outcome)
  #head(coin_toss_data)
  coin_toss_data$average <- NA
  for(i in 1:flip_count){
    coin_toss_data$average[i] <- sum(coin_toss_data$outcome[1:i])/i  
  }
  #tail(coin_toss_data)
  
  simulation_plot <- ggplot(coin_toss_data,aes(x = flip_num,y = average))+
    geom_line(col="dark blue")+
    labs(x = "Number of flips", y = "Average value", title = "Coin Flip Simulation
         (Assuming 0 is Heads and 1 is Tails)")+
    theme_gray()+
    theme(panel.grid.minor = element_blank(),
          axis.line = element_line(),
          plot.title = element_text(hjust = 0.5))+
    scale_x_continuous(breaks = seq(0,10000,1000),limits = c(0,10000))+
    scale_y_continuous(breaks = seq(0,1,0.1),limits = c(0,1))+
    geom_hline(yintercept=0.5,show.legend = "Theoretical Value",col="green")
  
  print(simulation_plot)
  print(paste0("The proportion of tails is ",coin_toss_data[10000,3]))
  return(coin_toss_data[10000,3])
}

#Q2
# populationDistribution: string('uniform','normal')
# sampleSize: integer (~30)
# numberOfSamples: integer (>100)
# return: list of two variables, mean and se
CLT <- function(populationDistribution, sampleSize, numberOfSamples){

  pop_size = 10000
  sample_mean <- NULL
  result <- NULL
  result_mean <- NULL
  result_error <- NULL
  if(populationDistribution == "normal" && sampleSize > 0 && numberOfSamples > 0){
    pop_data <- rnorm(pop_size)
  }
  else if(populationDistribution == "uniform" && sampleSize > 0 && numberOfSamples > 0){
    pop_data <- runif(pop_size)
  }
  else{
    print("ERROR: One or more arguments to the function are invalid.")
  }
  
  sample_mean <- NULL
  for(i in 1:numberOfSamples){
    sample_mean[i] <- mean(sample(pop_data,sampleSize))
  }
  result_plot <- qplot(sample_mean, geom = "histogram",
                       main = paste0("       CLT Demonstration for ",populationDistribution," distribution"),
                       xlab = "Sample Mean",
                       ylab = "Frequency",
                       fill = I("grey"),
                       col = I("black"))
  print(result_plot)
  # to check if the resulting data follows normal distribution
  #qqnorm(sample_mean);qqline(sample_mean, col = 2)
  result_mean <- mean(sample_mean)
  result_error <- sd(sample_mean)
  
  # fill in the list with the mean and std you compute
  result <- list("mean"=result_mean, "se"=result_error)
  return(result)
}

#Q3a
# return: string('TV', 'Radio', 'Newspaper'), represents the covariate providing the best prediction
SLR <- function(path='../data/hw23R-Advertising.csv'){
  advt_data <- read.csv(path,header = TRUE)
  
  # SLR for sales through TV ads
  TV <- ggplot(advt_data,aes(x = TV, y = Sales))+
    geom_point()+
    geom_smooth(method = "lm")+
    theme(axis.line = element_line())
  # lm stands for "Linear Model" function
  
  # SLR for sales through radio ads
  
  Rad <- ggplot(advt_data,aes(x = Radio, y = Sales))+
    geom_point()+
    geom_smooth(method = "lm")+
    theme(axis.line = element_line())
  
  # SLR for sales through newspaper ads
  Newsp <- ggplot(advt_data,aes(x = Newspaper, y = Sales))+
    geom_point()+
    geom_smooth(method = "lm")+
    theme(axis.line = element_line())
  
  grid.arrange(TV,Rad,Newsp,ncol = 2)
  
  corr_TV <- cor(advt_data$TV,advt_data$Sales)
  corr_Rad <- cor(advt_data$Radio,advt_data$Sales)
  corr_Newsp <- cor(advt_data$Newspaper,advt_data$Sales)
  #finding the best covariate
  best_cov <- ifelse(corr_TV>=corr_Rad,ifelse(corr_TV>=corr_Newsp,'TV','Newspaper'),
                     ifelse(corr_Rad>=corr_Newsp,'Radio','Newspaper'))
  #print(paste0("Best covariate: ",best_cov))
  return(best_cov)
}

#Q3b 
# return: list of four variables, Intercept, TvCoeff, NewspaperCoeff, RadioCoeff
MLR <- function(path='../data/hw23R-Advertising.csv'){
  advt_data <- read.csv(path,header = TRUE)
  variables <- c("Sales","TV","Newspaper","Radio")
  
  #advt <- advt_data[variables]
  # finding how variables are related to one another by constructing scatter plots of 
  # all pair-wise combinations of variables in the data frame
  #plot(advt)
  
  # fitting multiple regression model with Sales as response variable and rest as explanatary 
  multiple_reg_model <- lm(formula = Sales ~ TV + Radio + Newspaper, data = advt_data)
  #multiple_reg_model
  
  # OUTPUT: y-hat = 2.938889 + 0.045 * x1 + 0.1885 * x2 - 0.001 * x3
  #summary(multiple_reg_model)
  
  # fill in the list with the coeffes you compute
  result <- list("Intercept"=coef(multiple_reg_model)[1],
                 "TVCoeff"=coef(multiple_reg_model)[2],
                 "NewspaperCoeff"=coef(multiple_reg_model)[3],
                 "RadioCoeff"=coef(multiple_reg_model)[4])
  return(result)
}

#Q4
# return: list of four variables, Intercept, X1Coeff,X2Coeff,X3Coeff
LogisticRegression <- function(path='../data/hw23R-q4data.txt'){

  q4data <- read.table(path,header = TRUE)
  logisticModel <- glm(Y~X1+X2+X3,data = q4data, family = gaussian())
  
  # fill in the list with the coeffes you compute
  result <- list("Intercept" = coef(logisticModel)[1],
                 "X1Coeff" = coef(logisticModel)[2],
                 "X2Coeff" = coef(logisticModel)[3],
                 "X3Coeff" = coef(logisticModel)[4])
  
  return(result)
}

#Q5
# return: float of training accuracy 
LogisticRegressionImproved <- function(path='../data/hw23R-q4data.txt'){
  
  q4data <- read.table(path,header = TRUE)
  
  logisticModel_original <- glm(Y~X1+X2+X3,data = q4data, family = gaussian())
  check <- NULL
  for(i in 1:66){
    if(round(logisticModel_original$fitted.values[i])==q4data$Y[i])
      check[i] <- 1
  }  
  original_accuracy <- sum(check,na.rm = TRUE)/nrow(q4data)
  print(paste0("The accuracy of original model is ",original_accuracy))
  
  logisticModel_new <- glm(Y~X1+X2+X3,data = q4data, family = binomial(link = "logit"))
  check <- NULL
  for(i in 1:66){
    if(round(logisticModel_new$fitted.values[i])==q4data$Y[i])
      check[i] <- 1
  }  
  new_accuracy <- sum(check,na.rm = TRUE)/nrow(q4data)
  print(paste0("The accuracy of new model is ",new_accuracy))
  
}

#Q6
# return: list of two variables, Intercept, xCoeff
BigSLR <- function(path='../data/slr-90m-data.csv'){
  
  q6_data <- fread(path,header = TRUE)
  #generating linear model for using biglm()
  linearModel_pop <- biglm(formula = y~x,data = q6_data)
  print(paste0("Intercept: ",coef(linearModel_pop)[1]))
  print(paste0("Slope: ",coef(linearModel_pop)[2]))
  plot(linearModel_pop,xlab = "Population",ylab = "Value",main = "Main data plot")
  abline(linearModel_pop)
  
  
  set.seed(123)
  
  #taking samples for specified percentage of dataset
  row_count <- nrow(q6_data)
  #taking 1% sample from dataset
  sample_q6_1 <- q6_data[sample(x = q6_data,size = row_count*(1/100)),]
  linearModel_sample_1 = lm(formula = y~x,data = sample_q6_1)
  print(paste0("Intercept: ",coef(linearModel_sample_1)[1]))
  print(paste0("Slope: ",coef(linearModel_sample_1)[2]))
  plot(sample_q6_1,xlab = "X",ylab = "Y")
  abline(linearModel_sample_1)
  
  #taking 2% sample from dataset
  sample_q6_2 <- q6_data[sample(x = q6_data,size = row_count*(2/100)),]
  linearModel_sample_2 = lm(formula = y~x,data = sample_q6_2)
  print(paste0("Intercept: ",coef(linearModel_sample_2)[1]))
  print(paste0("Slope: ",coef(linearModel_sample_2)[2]))
  plot(sample_q6_2,xlab = "X",ylab = "Y")
  abline(linearModel_sample_2)
  
  #taking 3% sample from dataset
  sample_q6_3 <- q6_data[sample(x = q6_data,size = row_count*(3/100)),]
  linearModel_sample_3 = lm(formula = y~x,data = sample_q6_3)
  print(paste0("Intercept: ",coef(linearModel_sample_3)[1]))
  print(paste0("Slope: ",coef(linearModel_sample_3)[2]))
  plot(sample_q6_3,xlab = "X",ylab = "Y")
  abline(linearModel_sample_3)
  
  
  #taking 4% sample from dataset
  sample_q6_4 <- q6_data[sample(x = q6_data,size = row_count*(4/100)),]
  linearModel_sample_4 = lm(formula = y~x,data = sample_q6_4)
  print(paste0("Intercept: ",coef(linearModel_sample_4)[1]))
  print(paste0("Slope: ",coef(linearModel_sample_4)[2]))
  plot(sample_q6_4,xlab = "X",ylab = "Y")
  abline(linearModel_sample_4)
  
  #taking 5% sample from dataset
  sample_q6_5 <- q6_data[sample(x = q6_data,size = row_count*(5/100)),]
  linearModel_sample_5 = lm(formula = y~x,data = sample_q6_5)
  print(paste0("Intercept: ",coef(linearModel_sample_5)[1]))
  print(paste0("Slope: ",coef(linearModel_sample_5)[2]))
  plot(sample_q6_5,xlab = "X",ylab = "Y")
  abline(linearModel_sample_5)
  
  # fill in the list with the coeffes you compute
  result <- list("Intercept"=coef(linearModel_pop)[1], "xCoeff"=coef(linearModel_pop)[2])
  return(result)
  
}

