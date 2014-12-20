df.activity.label <- read.csv("activity_labels.txt",
                              header = FALSE,
                              sep = " ")

df.features <- read.csv("features.txt",
                        header = FALSE,
                        sep = "",
                        colClasses = "character")
##----------TEST data sets------------------
dataset.test <- c()
df.subject.test <- read.table("test/subject_test.txt",
                              header = FALSE)

df.activity.test <- read.table("test/y_test.txt",
                               header = FALSE)
df.activity.text.test <- merge(df.activity.test,df.activity.label)
dataset.test <- cbind(df.subject.test,df.activity.text.test[2])

df.x.test <- read.table("test/X_test.txt",
                      header = FALSE,
                      sep = c(""))

dataset.test <- cbind(dataset.test,df.x.test)

##----------TRAIN data sets------------------
dataset.train <- c()
df.subject.train <- read.table("train/subject_train.txt",
                              header = FALSE)

df.activity.train <- read.table("train/y_train.txt",
                               header = FALSE)
df.activity.text.train <- merge(df.activity.train,df.activity.label)
dataset.train <- cbind(df.subject.test,df.activity.text.test[2])

df.x.test <- read.table("test/X_test.txt",
                        header = FALSE,
                        sep = c(""))

dataset.train <- cbind(dataset.train,df.x.test)

##---------Combine into 1 big data set---------------------
dataset <- rbind(dataset.test,dataset.train)
names(dataset) <- c("Subject","Activity",df.features[,2])

# Data has complete values
isComplete <- any(!is.na(dataset))

