##
install.packages('tidyverse')

## %>% is only present in tidyverse, use control+shift+m as a shortcut for it

## 1. read file 'cleaned_bird_data.csv' 
clean_bird <- read.csv(file = 'Data/cleaned_bird_data.csv')
## 2. calculate average of egg size
###Option 1
clean_bird$Egg_mass %>% mean(na.rm = T)
###Option 2
mean(clean_bird$Egg_mass, na.rm = T)
###Option 3
clean_bird %>% pluck('Egg_mass') %>% mean(na.rm = T)
## 3. save birds with egg size > average 
abv_avg_egg <- clean_bird %>% filter(Egg_mass > 21.784)
View(abv_avg_egg)
## 4. save into a .csv in your laptop
write.csv(abv_avg_egg, 'abv_avg_egg_cleaned_bird_data.csv')
## 5. read this csv file back to R again
read.csv(file = 'abv_avg_egg_cleaned_bird_data.csv')