#READ IN DATA
library(tidyverse)
dat <- read.csv('Utah_Religions_by_County.csv')
View(dat)
str(dat)
dim(dat)

#CLEAN DATA
##First, let's make the data longer by narrowing down each religion name and proportion to one column
dat2 = dat %>% 
  pivot_longer(-c(County, Pop_2010, Religious, Non.Religious),
               names_to = 'Religion',
               values_to = 'Prop_Religion')
View(dat2)

##Next, let's change a couple of the column names for consistency
###(I know it's small, but it was bothering me)
dat3 <- dat2 %>%
  rename(Prop_Non_Religious = Non.Religious,
         Prop_Religious = Religious)
View(dat3)

##Finally, let's fix the proportions and get rid of all the zeros (no scientific notation, same number of decimals)
prop_cols = c('Prop_Non_Religious', 'Prop_Religious', 'Prop_Religion')
dat_final <- dat3 %>% 
mutate(across(all_of(prop_cols), ~ round(., 6))) %>% 
filter(Prop_Religion > 0)
View(dat_final)

#EXPLORE DATA
pop_plot <- dat_final %>% 
  ggplot(aes(x = County,
             y = Pop_2010)) +
  geom_bar(stat = 'identity') +
  theme(axis.text.x = element_text(angle = 90)) +
  labs(y = 'Population (2010)',
       title = 'Population vs County') +
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE))
pop_plot

religion_prop_plot <- dat_final %>% 
  ggplot(aes(x = Religion,
             y = Prop_Religion)) +
  geom_bar(stat = 'identity') +
  facet_wrap(~ County) +
  theme(axis.text.x = element_text(angle = 90)) +
  labs(title = 'Proportions of Each Religion by County',
       y = 'Proportion') 
religion_prop_plot

#ANSWERING QUESTIONS
##1. “Does population of a county correlate with the proportion of any specific religious group in that county?”
plot1 <- dat_final %>% 
  ggplot(aes(x = Pop_2010,
             y = Prop_Religion,
             color = County)) +
  geom_point() +
  facet_wrap(~ Religion) +
  theme(axis.text.x = element_text(angle = 90)) +
  labs(x = 'Population (2010)',
       y = 'Proportion',
       title = 'County Populations vs Religious Proportions') 
plot1

###There is a correlation between population and religious proportion for LDS, Catholics and Evangelicals

##2. “Does the proportion of any specific religion in a given county correlate with the proportion of non-religious people?”
plot2 <- dat_final %>% 
  ggplot(aes(x = Prop_Religion,
             y = Prop_Non_Religious,
             color = County)) +
  geom_point() +
  facet_wrap(~ Religion) +
  labs(x = 'Proportion per Religion',
       y = 'Proportion of Non-Religious',
       title = 'Proportion of Non-Religious vs Religious Proportions per County')
plot2

###There is a correlation between proportion of non-religious and religious proportion for LDS, Catholics and Evangelicals