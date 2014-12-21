##Functions
fileJoin <- function(...) {
  paste(..., sep="/")
}

downloadToDataDir <- function(url, dest) {
  if(!file.exists(dataDir)) { dir.create(dataDir) }
  download.file(url, dest, method="auto")
}

extractUciHarFile <- function(filePath) {
  fullFilePath <- fileJoin("UCI HAR Dataset", filePath)
  unz(uciHarZipfile, fullFilePath)
}

##Constants
dataDir <- "data"
uciHarUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
uciHarZipfile <- fileJoin(dataDir, "uci_har_dataset.zip")

if (!file.exists(uciHarZipfile)) {
  downloadToDataDir(uciHarUrl, uciHarZipfile)
}

df.activity.label <- read.csv(extractUciHarFile("activity_labels.txt"),
                              header = FALSE,
                              sep = " ")

df.features <- read.csv(extractUciHarFile("features.txt"),
                        header = FALSE,
                        sep = "",
                        colClasses = "character")

##----------TEST data sets------------------
dataset.test <- c()
dataset.test <- read.table(extractUciHarFile("test/X_test.txt"),
                        header = FALSE,
                        sep = c(""),
                        col.names = df.features[,2])

df.subject.test <- read.table(extractUciHarFile("test/subject_test.txt"),
                              header = FALSE)
dataset.test$Subject <- df.subject.test[,1]

df.activity.test <- read.table(extractUciHarFile("test/y_test.txt"),
                               header = FALSE)
dataset.test$Activity <- df.activity.test[,1]

##----------TRAIN data sets------------------
dataset.train <- c()
dataset.train <- read.table(extractUciHarFile("train/X_train.txt"),
                            header = FALSE,
                            sep = c(""),
                            col.names = df.features[,2])

df.subject.train <- read.table(extractUciHarFile("train/subject_train.txt"),
                              header = FALSE)
dataset.train$Subject <- df.subject.train[,1]
                                                            
df.activity.train <- read.table(extractUciHarFile("train/y_train.txt"),
                               header = FALSE)
dataset.train$Activity <- df.activity.train[,1]
# 
# ##---------Combine into 1 big data set---------------------
dataset <- rbind(dataset.test,dataset.train)

#rearrange columns
dataset <- dataset[, append(c("Subject","Activity" ), head(colnames(dataset), 561))]

#select variables that are mean and std only
meanstdcols <- grep("Activity|Subject|\\.mean\\.|\\.std\\.", 
                    colnames(dataset))
meanstddataset <- dataset[,meanstdcols]

require(reshape2)
require(data.table)
#creating a long list for casting
melted_data <- melt( meanstddataset, id = c("Subject","Activity"))
cast_data_mean <- dcast( melted_data, Subject + Activity ~ variable, 
                         mean )

#renaming activity
cast_data_mean$Activity <- as.factor(cast_data_mean$Activity)
levels(cast_data_mean$Activity) <- df.activity.label[,2]

write.table(cast_data_mean, 
            file = "average_result.csv",
            sep = ",",
            row.name = FALSE )