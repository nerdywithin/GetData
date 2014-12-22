library(plyr)
library(stringr)

##    the following functions load the neccessary datas(test and train datas) into R objects. You have to enter
## the file address on your computer in the quotation marks instead of the text instructions

test <- read.table("put test dataset file path here")
subject.test <- read.table("put test_subject file path here")
activity.test <- read.table("put test_activity file path here")
train <- read.table("put train dataset file path here")
subject.train <- read.table("put train_subject file path here")
activity.train <- read.table("put train_activity file path here")
features <- read.table("put feature file path here")

## Before anything else lets lable the test and train dataset variable according to features

names(test) <- features$V2
names(train) <- features$V2

#moreover:
names(subject.test)[1] <- "subject"
names(subject.train)[1] <- "subject"
names(activity.test)[1] <- "activity"
names(activity.train)[1] <- "activity"


##  first of all we have to grab the columns with the means and stds. using grepl() to filter them from the
## features object and then apply that logical vector to the test.set and train.set objects to subset the
## required columns

filter <- grepl("mean|std", features$V2)
test <- test[, filter]
train <-train[, filter]

#now we have to produce another column to act as a joining point for each test and train group datasets

test$seq <- seq(along = test[,1])
subject.test$seq <- seq(along = activity.test[,1])
activity.test$seq <- seq(along = activity.test[,1])
train$seq <- seq(along = train[,1])
subject.train$seq <- seq(along = subject.train[,1])
activity.train$seq <- seq(along = activity.train[,1])

# now time to merge each dataset using plyr package join_all() function

dflist.test <- list(test, subject.test, activity.test)
dflist.train <- list(train, subject.train, activity.train)
test.merged <- join_all(dflist.test)
train.merged <- join_all(dflist.train)
test.merged <- test.merged[, c(80:82, 1:79)]
train.merged <- train.merged[, c(80:82, 1:79)]

# now in an attemp to merge the two data sets together we have to change their sequence a little bit

test.merged$seq <- seq(7353, 10299)

# time to merge

complete.data <- merge(test.merged, train.merged, all = T)

# One little last step to convert activity numbers to their descreptive labels using Regular expressions

complete.data$activity <- sub(1, "WALKING", complete.data$activity)
complete.data$activity <- sub("2", "WALKING_UPSTAIRS", complete.data$activity)
complete.data$activity <- sub("3", "WALKING_DOWNSTAIRS", complete.data$activity)
complete.data$activity <- sub("4", "SITTING", complete.data$activity)
complete.data$activity <- sub("5", "STANDING", complete.data$activity)
complete.data$activity <- sub("6", "LAYING", complete.data$activity)

##  So, finally in an attemp to run mean() function on subject-activity pairs sensor records I'm going to create
## a new variable called 'pairs' to give us the factors for pair-wise summarization of data

pairs <- paste(as.character(complete.data$subject), complete.data$activity)
pairs <- factor(pairs)

# Then I will write a function to gather the means by pairs on every column using tapply

runner <- function (DataFrame, index) {
  final <- data.frame(pairs = levels(pairs))
  count <- 0
  for ( cols in DataFrame) {
    count = count + 1
    keep <- tapply(cols, index, mean)
    keep <- as.data.frame(keep)
    names(keep)[1] <- names(DataFrame)[count]
    keep$pairs <- levels(pairs)
    final <- merge(final, keep, by = "pairs", all = T)
  }
  return(final)
}

# Let's call it!

runner(complete.data[,4:82], pairs)





