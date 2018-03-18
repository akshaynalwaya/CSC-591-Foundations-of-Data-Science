# Install necessary packages


packages <- list('ISLR', 'dplyr','bnlearn') 
#Add all your packages here. Don't change the rest of the file, or file name
#Example: packages <- list('data.table','rpart','rgdal')


InstallAll <- function(packageName){
if(!(packageName %in% installed.packages())){
  install.packages(packageName,dependencies = T)
}
}

sapply(packages, InstallAll)
