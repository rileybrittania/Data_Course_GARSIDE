##1. create a dataframe using mtcars, for mpg >20 and cyl equal to 6
df_cars <- mtcars
View(df_cars)
cyl_6_mpg_20 <- df_cars[df_cars$cyl == 6 & df_cars$mpg >20,]
View(cyl_6_mpg_20)
##OR
df_6 = df_cars[df_cars$cyl == 6]

##2. in the data frame add a new column that is mpg x cyl 
df_cars$mpgxcyl <- df_cars$mpg * df_cars$cyl
View(df_cars$mpgxcyl)

##3. write a for loop to print out each row
nrow(df_cars)
rownames(df_cars)
for (row in rownames(df_cars)){print(row)}
##OR
for (i in 1:3) {print(cyl_6_mpg_20[i, ])}
##OR 
for (i in 1:nrow(df_cars)) {print(df_cars[i, ])}

##read/load data
write.csv(df_cars, 'my_wonderful_car_file.csv')

##to install a package
install.packages() 

##to load a package 
library()