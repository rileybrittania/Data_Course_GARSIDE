## 1. read file 'cleaned_bird_data.csv' 
library(tidyverse)
clean_bird <- read.csv('Data/cleaned_bird_data.csv')

## 2. calculate average of egg size
###Option 1
clean_bird$Egg_mass %>% mean(na.rm = T)
###Option 2
mean(clean_bird$Egg_mass, na.rm = T)
###Option 3
clean_bird %>% pluck('Egg_mass') %>% mean(na.rm = T)

## 3. save birds with egg size > average 
abv_avg_egg <- clean_bird %>% filter(Egg_mass > 21.8)
View(abv_avg_egg)

## 4. save into a .csv in your laptop
write.csv(abv_avg_egg, 'abv_avg_egg_cleaned_bird_data.csv', row.names = F)

## 5. read this csv file back to R again
df_from_csv <- read.csv('abv_avg_egg_cleaned_bird_data.csv')
View(df_from_csv)

##Pipe everything together? 
clean_bird %>% filter(Egg_mass > 21.8) %>% 
write.csv(abv_avg_egg, 'abv_avg_egg_cleaned_bird_data.csv', row.names = F)

##install package: palmerpenguins
install.packages('palmerpenguins')
library(palmerpenguins)

str(penguins)
dim(penguins)

df_penguin <- penguins
View(df_penguin)

##1. check column names in the dataset using tidyverse
df_penguin %>% names()

##2. calculate max, min, ...of body mass using tidyverse
df_penguin$body_mass_g %>% max(na.rm = T)
df_penguin %>% pluck('body_mass_g') %>% max(na.rm = T)

df_penguin$body_mass_g %>% min(na.rm = T)
df_penguin
min(df_penguin$body_mass_g, na.rm = T)
mean(df_penguin$body_mass_g, na.rm = T)
median(df_penguin$body_mass_g, na.rm = T)
range(df_penguin$body_mass_g, na.rm = T)


##3. save object for body mass > avg and female
df_penguin$body_mass_g %>% mean(na.rm = T)
large_female_penguin <- df_penguin %>% filter(body_mass_g > 4201.8) %>% 
  filter(sex == 'female')
##OR
large_female_penguin <- df_penguin %>% filter(body_mass_g > 4201.8 & sex == 'female')
View(large_female_penguin)

##calculate avg body mass of female penguins with bill length > 40
## and separate by species
unique(df_penguin$species)

longbill_f_species_summary <- df_penguin %>% filter(bill_depth_mm > 40 & sex == 'female') %>% 
  group_by(species) %>% summarise(avg_mass_g = mean(body_mass_g))


df_penguin %>% filter(bill_length_mm > 40 & sex == 'female') %>% 
  group_by(species) %>% summarise(avg_mass_g = mean(body_mass_g))

df_penguin %>% filter(bill_length_mm > 40 & sex == 'female') %>% 
  group_by(species, island) %>% summarise(avg_mass_g = mean(body_mass_g))

df_penguin %>% filter(bill_length_mm > 40 & sex == 'female') %>% 
  group_by(species, island, year) %>% summarise(avg_mass_g = mean(body_mass_g))

df_penguin %>% filter(bill_length_mm > 40 & sex == 'female') %>% 
  group_by(species, island, year) %>% summarise(avg_mass_g = mean(body_mass_g), max_mass_g = max(body_mass_g))

df_penguin %>% filter(bill_length_mm > 40 & sex == 'female') %>% 
  group_by(species) %>% summarise(avg_mass_g = mean(body_mass_g), sample_size = n())
