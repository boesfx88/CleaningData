#Extracting the data
path1 <- paste("./test",dir("./test"),sep="/")
subject_test <- read.table(path1[2])
X_test <- read.table(path1[3])
Y_test <- read.table(path1[4])

path2 <- paste("./train",dir("./train"),sep="/")
subject_train <- read.table(path2[2])
X_train <- read.table(path2[3])
Y_train <- read.table(path2[4])
##Done extracting

##Begin merging the data
subject_data <- rbind(subject_test,subject_train)
X_data <- rbind(X_test,X_train)
Y_data <- rbind(Y_test,Y_train)
##Done merging

##Now we only extract the mean and the standard deviation of the measurements
features <- read.table("features.txt")
logic_mean <- grepl("mean",features[,2])
logic_std <- grepl("std",features[,2])
logic_meanFreq <- grepl("meanFreq",features[,2])
index <- which((logic_mean | logic_std)&(!logic_meanFreq))
X_data <- X_data[,index]
##Done removing unnecessary variables

##Now we names the variables
names(subject_data) <- "SUBJECT"
names(Y_data) <- "ACTIVITY"
names(X_data) <- features[index,2]

Y_data <- replace(Y_data,Y_data==1,"WALKING")
Y_data <- replace(Y_data,Y_data==2,"WALKING UPSTAIRS")
Y_data <- replace(Y_data,Y_data==3,"WALKING DOWNSTAIRS")
Y_data <- replace(Y_data,Y_data==4,"SITTING")
Y_data <- replace(Y_data,Y_data==5,"STANDING")
Y_data <- replace(Y_data,Y_data==6,"LAYING")
##Done naming

dataset <- subject_data
dataset <- cbind(dataset,Y_data)
dataset <- cbind(dataset,X_data)
##And finally the merged data set is done

##This is the second tidy data 
dataset2 <- aggregate(dataset[,3:68],by=list(dataset[,1],dataset[,2]),mean)
names(dataset2)[1:2] <- c("SUBJECT","ACTIVITY")

##The last thing to do is to write that second tidy data 
write.table(dataset2,file="dataset2.txt",row.names=FALSE) 