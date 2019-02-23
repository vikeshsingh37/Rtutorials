

#Today, I am going to show some examples on how to use data.table. R's data.table package is very fast and efficient. I will be using a simple data frame mtcars in this demo.
#Let's load the data and see how what it has.


data(mtcars)
head(mtcars)

#To get the size of size, R has dim command. Let's also get summary statistics and class

print(dim(mtcars))
print(summary(mtcars))
print(class(mtcars))

# So, we have a data frame of 32 rows and 11 columns in this data set. All the columns are numeric.
# I will store mtcars into a different object and start from there. Now I want to add another column to the data. I want to add avg_mpg_cg which will be mean of mpg over cyl and gear. There are several ways to do it. But my preferred approach is using data.table package.
library(data.table)
dat <- as.data.table(mtcars)
dat[,avg_mpg_cg:= mean(mpg), by = c("cyl","gear")]
head(dat)


#So, It can be in just one line! Okay, now may I dont need mpg column and want remove it.
dat[,mpg:= NULL]
head(dat)

#Boom! Done. Okay, that's cool. But wait mtcars had car names as rownames. It is not there in dat because data.table does not support rownames. But we can add a column to it.

dat[,car_names:= rownames(mtcars)]
head(dat)

#Okay. So, now I want to select only the rows where car_names has Hornet
dat[grep("Hornet",car_names)]


#Hmmm. I want Mazda too.
dat[grep(paste(c("Mazda","Hornet"),collapse="|"), car_names)]

#Let's do now something more tricky. I want to apply a function (say mean) to disp, hp and drat column and store them in new columns of dat
cols_to_work <- c("disp", "hp", "drat")
dat[,paste0(cols_to_work,"_avg"):= lapply(.SD, mean), .SDcols =cols_to_work ]
head(dat)




























