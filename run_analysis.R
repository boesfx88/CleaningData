#Extracting the data
path10 <- paste("./test",dir("./test"),sep="/")
subject_test <- read.table(path10[2])
X_test <- read.table(path10[3])
Y_test <- read.table(path10[4])

path1 <- paste("./test/Inertial Signals",dir("./test/Inertial Signals"),sep="/")
body_acc_x_test <- read.table(path1[1])
body_acc_y_test <- read.table(path1[2])
body_acc_z_test <- read.table(path1[3])
body_gyro_x_test <- read.table(path1[4])
body_gyro_y_test <- read.table(path1[5])
body_gyro_z_test <- read.table(path1[6])
total_acc_x_test <- read.table(path1[7])
total_acc_y_test <- read.table(path1[8])
total_acc_z_test <- read.table(path1[9])

path20 <- paste("./train",dir("./train"),sep="/")
subject_train <- read.table(path20[2])
X_train <- read.table(path20[3])
Y_train <- read.table(path20[4])

path2 <- paste("./train/Inertial Signals",dir("./train/Inertial Signals"),sep="/")
body_acc_x_train <- read.table(path2[1])
body_acc_y_train <- read.table(path2[2])
body_acc_z_train <- read.table(path2[3])
body_gyro_x_train <- read.table(path2[4])
body_gyro_y_train <- read.table(path2[5])
body_gyro_z_train <- read.table(path2[6])
total_acc_x_train <- read.table(path2[7])
total_acc_y_train <- read.table(path2[8])
total_acc_z_train <- read.table(path2[9])
##Done extracting

##Begin merging the data
subject_data <- rbind(subject_test,subject_train)
X_data <- rbind(X_test,X_train)
Y_data <- rbind(Y_test,Y_train)
body_acc_x_data <- rbind(body_acc_x_test,body_acc_x_train)
body_acc_y_data <- rbind(body_acc_y_test,body_acc_y_train)
body_acc_z_data <- rbind(body_acc_z_test,body_acc_z_train)
body_gyro_x_data <- rbind(body_gyro_x_test,body_gyro_x_train)
body_gyro_y_data <- rbind(body_gyro_y_test,body_gyro_y_train)
body_gyro_z_data <- rbind(body_gyro_z_test,body_gyro_z_train)
total_acc_x_data <- rbind(total_acc_x_test,total_acc_x_train)
total_acc_y_data <- rbind(total_acc_y_test,total_acc_y_train)
total_acc_z_data <- rbind(total_acc_z_test,total_acc_z_train)
##Done merging

##Now we names the variables
features <- read.table("features.txt")

names(subject_data) <- "SUBJECT"
names(Y_data) <- "ACTIVITY"
names(total_acc_x_data) <- paste("TAX",1:128)
names(total_acc_y_data) <- paste("TAY",1:128)
names(total_acc_z_data) <- paste("TAZ",1:128)
names(body_acc_x_data) <- paste("BAX",1:128)
names(body_acc_y_data) <- paste("BAY",1:128)
names(body_acc_z_data) <- paste("BAZ",1:128)
names(body_gyro_x_data) <- paste("BGX",1:128)
names(body_gyro_y_data) <- paste("BGY",1:128)
names(body_gyro_z_data) <- paste("BGZ",1:128)
names(X_data) <- features[,2]

Y_data <- replace(Y_data,Y_data==1,"WALKING")
Y_data <- replace(Y_data,Y_data==2,"WALKING UPSTAIRS")
Y_data <- replace(Y_data,Y_data==3,"WALKING DOWNSTAIRS")
Y_data <- replace(Y_data,Y_data==4,"SITTING")
Y_data <- replace(Y_data,Y_data==5,"STANDING")
Y_data <- replace(Y_data,Y_data==6,"LAYING")
#Done naming

dataset <- subject_data
dataset <- cbind(dataset,Y_data)
dataset <- cbind(dataset,total_acc_x_data)
dataset <- cbind(dataset,total_acc_y_data)
dataset <- cbind(dataset,total_acc_z_data)
dataset <- cbind(dataset,body_acc_x_data)
dataset <- cbind(dataset,body_acc_y_data)
dataset <- cbind(dataset,body_acc_z_data)
dataset <- cbind(dataset,body_gyro_x_data)
dataset <- cbind(dataset,body_gyro_y_data)
dataset <- cbind(dataset,body_gyro_z_data)
##And finally the merged data set is done

##This is the mean of the data set
mean_dataset <- apply(dataset[,3:1154],2,mean)
names(mean_dataset) <- names(dataset)[3:1154] 

##This is the standard deviation of the data set
sd_dataset <- apply(dataset[,3:1154],2,sd)
names(sd_dataset) <- names(dataset)[3:1154]

##This is the second tidy data 
dataset2 <- aggregate(dataset[,3:1154],by=list(dataset[,1],dataset[,2]),mean)
names(dataset2)[1:2] <- c("SUBJECT","ACTIVITY")

##The last thing to do is to write that second tidy data 
write.table(dataset2,file="dataset2.txt",row.names=FALSE) 