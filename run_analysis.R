library(dplyr)

# Extract column names from features list
header <- scan(paste(getwd(), "/UCI HAR Dataset/features.txt", sep = ""), what = "", sep = "\n")

# Extract training data, activities, and IDS
train_data <- read.table(paste(getwd(),"/UCI HAR Dataset/train/X_train.txt", sep = ""), header = FALSE, fill = TRUE)

train_act <- read.table(paste(getwd(),"/UCI HAR Dataset/train/y_train.txt", sep = ""), header = FALSE, fill = TRUE)

train_IDS <- read.table(paste(getwd(), "/UCI HAR Dataset/train/subject_train.txt", sep = ""), header = FALSE)

# Add train label to IDs to differentiate from test data
train_IDS <- sapply(train_IDS, paste0, "_train")

# Combine all training data into one train df with column names
train <- cbind(train_IDS, train_act, train_data)
col_names <- c("id", "activity", header)
colnames(train) <- col_names

# Extract test data, activities, and IDs
test_data <- read.table(paste(getwd(),"/UCI HAR Dataset/test/X_test.txt", sep = ""), header = FALSE, fill = TRUE)

test_act <- read.table(paste(getwd(),"/UCI HAR Dataset/test/y_test.txt", sep = ""), header = FALSE, fill = TRUE)

test_IDS <- read.table(paste(getwd(), "/UCI HAR Dataset/test/subject_test.txt", sep = ""), header = FALSE)

# Add train label to IDs to differentiate from test data
test_IDS <- sapply(test_IDS, paste0, "_test")

# Combine testing data into one dataset with column names
test <- cbind(test_IDS, test_act, test_data)
col_names <- c("id", "activity", header)
colnames(test) <- col_names

# combine training and testing data frames into one data frame
df <- rbind(train, test)

# Extract only the measurements on the mean and standard deviation in the data set

x <- c("id", "activity", "mean", "std")
keep <- grepl(paste(x, collapse= "|"), colnames(df))
df_small <- df[, keep]

# Use descriptive activity names to name the activities in the data set

act_labels <- read.table(paste(getwd(),"/UCI HAR Dataset/activity_labels.txt", sep = ""), header = FALSE, fill = TRUE)
colnames(act_labels) <- c("activity", "act_name")

df_act <- merge(df_small, act_labels, by= "activity")
df_act$activity <- NULL
df_act <- rename(df_act, activity = act_name)

# Appropriately labels the data set with descriptive variable names. 
col_names <- colnames(df_act)
col_names <- gsub("Acc", "acceleration_", col_names)
col_names <- gsub("Body", "body_", col_names)
col_names <- gsub("Gravity", "gravity_", col_names)
col_names <- gsub("Freq", "frequency_", col_names)
col_names <- gsub("[()-]", "_", col_names, fixed = TRUE)
col_names <- gsub("-", "", col_names)
col_names <- gsub("X", "x_direction", col_names)
col_names <- gsub("Y", "y_direction", col_names)
col_names <- gsub("Z", "z_direction", col_names)
col_names <- gsub("[()]", "", col_names)
col_names <- gsub("Gyro", "gyroscope_", col_names)
col_names <- gsub("Mag", "magnitude_", col_names)
col_names <- gsub("Jerk", "jerk_", col_names)
col_names <- gsub("\\d+\\s", "", col_names)
col_names <- gsub("^[t]", "time_", col_names)
col_names <- gsub("^[f]", "frequency_", col_names)
col_names <- gsub("mean", "mean_", col_names)
col_names <- gsub("std", "std_", col_names)
col_names <- gsub("\\_$", "", col_names)

colnames(df_act) <- col_names


# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

df_tidy <- df_act %>% group_by(id, activity) %>% summarize_each(funs(mean))
colnames(df_tidy) <- paste("mean", colnames(df_tidy), sep = "_")
colnames(df_tidy)[1] <- "id"
colnames(df_tidy)[2] <- "activity"

write.table(df_tidy, file = "project_data.txt", row.name = FALSE)
