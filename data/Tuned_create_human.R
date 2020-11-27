#Gain excercise 5  date 26.11.2020 
#The 'human' dataset originates from the United Nations Development Programme. See their data page: http://hdr.undp.org/en/content/human-development-index-hdi for more information. 
#For a nice overview see also the calculating the human development indices pdf (http://hdr.undp.org/sites/default/files/hdr2015_technical_notes.pdf).
#Most of the variable names in the data have been shortened and two new variables have been computed. 
#See the meta file for the modified data here (https://raw.githubusercontent.com/TuomoNieminen/Helsinki-Open-Data-Science/master/datasets/human_meta.txt) for descriptions of the variables.

# The data combines several indicators from most countries in the world

#"Country" = Country name

# Health and knowledge

#"GNIGC" = Gross National Income per capita (GNI in DataCamp)
#"LEB" = Life expectancy at birth (Life.Exp in DC)
#"EYE" = Expected years of Education (Edu.Exp)
#"MMR" = Maternal mortality ratio (Mat.Mor)
#"ABR" = Adolescent birth rate (Ado.Birth)

# Empowerment

#"PRP" = Percent.Representation.in.Parliament Parli.F (Percetange of female representatives in parliament)
#"PSEF" = Proportion of females with at least secondary education Edu2.F
#"PSEM" = Proportion of males with at least secondary education Edu2.M
#"LFPRF" = Proportion of females in the labour force Labo.F
#"LFPRM" " Proportion of males in the labour force Labo.M

#"Edu2F_per_Edu2M" = PSEF / PSEM (Edu2.FM)
#"LabF_per_LabM" = LFPRF / LFPRM (Labo.FM in datacamp)


#Data Wragling

#read the data into memory if not done the file
#human <- read.table("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt", sep="\t", header=TRUE)
#human

human <- read.table("G:\\OpenDataScience\\Excercise 1\\IODS-project\\data\\human.txt", sep=",", header=TRUE)
human
# see the new column names
names(human)

#print summary
summary(human)

# access the stringr package
library(stringr)
library(tidyr)

# look at the structure of the GNI column in 'human'
str(human$GNIGC)

# remove the commas from GNI and print out a numeric version of it
str_replace(human$GNIGC, pattern=",", replace ="") %>% as.numeric

# columns to keep
keep <- c("Country", "PSEF", "LabF_per_LabM", "LEB", "EYE", "GNIGC", "MMR", "ABR", "PRP")

# select the 'keep' columns
human <- select(human, one_of(keep))

# print out a completeness indicator of the 'human' data
complete.cases(human)

# print out the data along with a completeness indicator as the last column
data.frame(human[-1], comp = complete.cases(human))

# filter out all rows with NA values
human_ <- filter(human, complete.cases(human))

#df[,] # select every row and every column
#df[1:5, ] # select first five rows
#df[, c(2, 5)] # select 2nd and 5th columns

# look at the last 10 observations
tail(human, 40)

# last indice we want to keep
last <- nrow(human) - 7

# choose everything until the last 7 observations
human_ <- human[1:last, ]

human
# add countries as rownames
rownames(human) <- human$Country

human

summary(human)
str(human)

#overwrite old human data
#Save the analysis dataset to data folder
#write.table(human,"G:\\OpenDataScience\\Excercise 1\\IODS-project\\data\\human.txt", sep=",")
