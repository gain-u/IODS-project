#read human development
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)

#read gender ineguality
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

#dimensions
dim(hd)
dim(gii)

#structure
str(hd)
str(gii)

# summary method dispalys descriptive statistics for every variable in the dataset
summary(hd)
summary(gii)

colnames(hd)

# Rename columnS 
names(hd)[names(hd) == "Human.Development.Index..HDI."] <- "HDI"
names(hd)[names(hd) == "Expected.Years.of.Education"] <- "EYE"
names(hd)[names(hd) == "Gross.National.Income..GNI..per.Capita"] <- "GNIGC"
names(hd)[names(hd) == "Life.Expectancy.at.Birth"] <- "LEB"
names(hd)[names(hd) == "Mean.Years.of.Education"] <- "MYE"
names(hd)[names(hd) == "GNI.per.Capita.Rank.Minus.HDI.Rank"] <- "GNI_per_Cap_HDI_Ranks"

colnames(gii)

names(gii)[names(gii) == "Gender.Inequality.Index..GII."] <- "GII"
names(gii)[names(gii) == "Maternal.Mortality.Ratio"] <- "MMR"
names(gii)[names(gii) == "Adolescent.Birth.Rate"] <- "ABR"
names(gii)[names(gii) == "Percent.Representation.in.Parliament"] <- "PRP"
names(gii)[names(gii) == "Population.with.Secondary.Education..Female."] <- "PSEF"
names(gii)[names(gii) == "Population.with.Secondary.Education..Male."] <- "PSEM"
names(gii)[names(gii) == "Labour.Force.Participation.Rate..Female."] <- "LFPRF"
names(gii)[names(gii) == "Labour.Force.Participation.Rate..Male."] <- "LFPRM"

#create two new variables LabF_per_LabM, Edu2F_per_Edu2M
gii$LabF_per_LabM <- (gii$PSEF/gii$PSEM)
gii$Edu2F_per_Edu2M <-(gii$LFPRF/gii$LFPRM)
#can be do also gii <- mutate(gii, LabF_per_LabM = (PSEF/PSEM))

#Join together the two datasets with country
# access the dplyr library
library(dplyr)
# common columns to use as identifiers
join_by <- c("Country")

# join the two datasets by the selected identifiers
human <- inner_join(hd, gii, by = join_by, suffix = c(".hd", ".gii"))

# see the new column names
colnames(human)

#Save the analysis dataset to data folder
write.table(human,"G:\\OpenDataScience\\Excercise 1\\IODS-project\\data\\human.txt", sep=",")
