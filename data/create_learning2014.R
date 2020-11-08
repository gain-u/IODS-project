#Gain excercise 2 (week 45 problems of environment) date 7.11.2020 
#full learning2014 data from  http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt 

#Data Wragling

#read the data into memory
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

#Look at the dimensions of the data
dim(lrn14)

#Look at the structure of the data
str(lrn14)

#Print the data set helps to understand excercise (what columns allready exsist and what needs to be combined)
lrn14

# access the dplyr library
library(dplyr)

# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select the columns related to deep learning and create column 'deep' by averaging
deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)

# select the columns related to surface learning and create column 'surf' by averaging
surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)

# select the columns related to strategic learning and create column 'stra' by averaging
strategic_columns <-select(lrn14, one_of(strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)

# choose a handful of columns to keep
keep_columns <- c("gender","Age","Attitude","deep","stra","surf","Points")

# select the 'keep_columns' to create a new dataset
learning2014 <- select(lrn14, one_of(keep_columns))

# select rows where Points is greater than zero
learning2014 <- filter(learning2014, Points > 0)

#print to verify the result (7 variables and 166 rows)
learning2014

#Save the analysis dataset to data folder
write.csv(learning2014,"G:\\OpenDataScience\\Excercise 1\\IODS-project\\data\\learning2014.csv", row.names = FALSE)

#Read the analysis dataset from data folder
read.csv("G:\\OpenDataScience\\Excercise 1\\IODS-project\\data\\learning2014.csv", header = TRUE)

#check that the structure of the data is correct
str(learning2014)
head(learning2014)
