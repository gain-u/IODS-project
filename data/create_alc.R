#Gain Ulla 12.11.2020  from data source two .csv files :
# https://archive.ics.uci.edu/ml/machine-learning-databases/00320/student.zip  

#G:\OpenDataScience\Excercise 1\IODS-project\data

#url <- "https://github.com/gain-u/IODS-project/blob/master/data"

# web address for math class data
#url_math <- paste(url,"student-mat.csv", sep = "/")
#math <- read.table(url_math, sep = ";" , header=TRUE)

# read the math class questionaire data into memory
math <- read.table("G:\\OpenDataScience\\Excercise 1\\IODS-project\\data\\student-mat.csv", sep = ";" , quote="", fill=FALSE, header=TRUE)
por <- read.table("G:\\OpenDataScience\\Excercise 1\\IODS-project\\data\\student-por.csv", sep = ";" , quote="", fill=FALSE, header=TRUE)

#verify the columns
colnames(math)
colnames(por)

#Look at the dimensions of the data math
dim(math)
                  
#Look at the structure of the data math
str(math) 

#Look at the dimensions of the data por
dim(por)

#Look at the structure of the data por
str(por)     

# access the dplyr library
library(dplyr)

# common columns to use as identifiers
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")

# join the two datasets by the selected identifiers
math_por <- inner_join(math, por, by = join_by, suffix = c(".math", ".por"))

# see the new column names
colnames(math_por)

# glimpse at the data (look at the joined data)
glimpse(math_por)

# create a new data frame with only the joined columns
alc <- select(math_por, one_of(join_by))

# columns that were not used for joining the data
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]

# print out the columns not used for joining
notjoined_columns

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column  vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

# glimpse at the new combined data 
glimpse(alc)

# access the 'tidyverse' packages dplyr and ggplot2
library(dplyr); library(ggplot2)

# define a new column alc_use by combining weekday and weekend alcohol use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

# define a new logical column 'high_use'
alc <- mutate(alc, high_use = alc_use > 2)

#glimpse the data, there should be new column hing_use
glimpse(alc)
