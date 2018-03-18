# Solution to R4 - HW45R
# Student Name: Akshay NAlwaya
# Student ID: 200159155

# Q4: put your code implementation for Q4 in this file and put proper comments for
# each line of your code. 
# Ref.: https://cran.r-project.org/web/packages/bnlearn/bnlearn.pdf
#       https://rdrr.io/cran/bnlearn/man/bn.fit.html


require(bnlearn)

bayesian_network <- function(){
  
  bn_data <- read.csv("bn-data.csv")
  bn_data$X <- NULL
  #Learning the structure of this Bayesian network using a hill-climbing (HC) greedy search
  learned_struct <- hc(bn_data)
  #plotting the bayesian network
  plot(learned_struct)
  #fitting the data using learned structure
  data_fit <- bn.fit(learned_struct,bn_data)
  #displaying the conditional probability tables for each node
  for(i in 1:6)
    print(data_fit[i])
}

#calling the function to construct Bayesian network
bayesian_network()
