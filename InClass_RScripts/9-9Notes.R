##Assignment 2, Step 4
all_csv <- list.files('Data/', pattern = '.csv')

##Assignment 2, Step 5
length(all_csv)

##Assignment 2, Step 6
df <- read.csv(file = 'Data/wingspan_vs_mass.csv')

##Assignment 2, Step 7
head(df, n = 5)

##Assignment 2, Step 8
b_files <- list.files('Data/', pattern = '^b', recursive = T)

##Assignment 2, Step 9 
for (i in b_files) {
  file_path_b <- file.path("Data", i) 
  print(readLines(file_path_b, n = 1))}

##Assignment 2, Step 10
for (i in all_csv)
{file_path_all <- file.path("Data", i)
print(readLines(file_path_all, n = 1))}

##write a loop to print out penguin, bird, fish, whale
arctic_animals <- c('penguin', 'bird', 'fish', 'whale')
for (i in arctic_animals) {
 new_sent2 <- paste('I saw a', i) 
 print(new_sent2) 
}
for (i in arctic_animals) {
  print(i)
}

## write a loop to print out numbers 1-5
one_to_five <- c(1:5)
for (i in one_to_five) {
  print(i)
}

## write a loop combining animals and numbers
for (animal in arctic_animals)
  for (number in 1:5) {
    print(animal)
    print(number)
  }

##create a new col called "fruit"
## fill in with vector fruit
dat_BIOL3100$fruit <- vec_fruit

##create a new object called 'car_4' save only cars with 4 cyl
df_cars <- mtcars
View(df_cars)
car_4 <- df_cars[df_cars$cyl == 4,]

##build a data frame from mt cars with only mpg > 20 and cyl = 4 
df_cars <- mtcars
View(df_cars)
car_4_mpg_20 <- df_cars[df_cars$cyl == 4 & df_cars$mpg >20,]
View(car_4_mpg_20) ##or car_4_mpg_20

## make a plot using two columns in df_cars
df_cars <- mtcars
plot(df_cars$mpg, df_cars$hp)

##two ways to do averages
mean(df_cars$mpg)
OR
mpg <- (df_cars$mpg)
mean(mpg)

##convert every column in mtcars to characters
df_cars$mpg = as.character(df_cars$mpg) ##repeat for every column, OR

df_cars <- mtcars
names(df_cars)
for (col in names(df_cars))
{df_cars[, col] = as.character(df_cars[, col])}
##OR
df_cars_new <- apply(df_cars, 2, as.character)



