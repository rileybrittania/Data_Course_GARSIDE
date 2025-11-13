#TASK 1; Read in data
dat <- read.csv('unicef-u5mr.csv')
View(dat)

#TASK 2: Tidy data
library(tidyverse)
clean_dat <- dat %>% 
  pivot_longer(cols = starts_with('U5MR'),
               names_to = 'Year',
               values_to = 'U5MR') %>% 
  filter(!is.na(U5MR)) %>%
  mutate(Year = as.integer(str_remove(Year, "U5MR.")))
View(clean_dat)

#TASK 3: Plot U5MR for each country over time (line plot, facet by continent)
plot_1 <- clean_dat %>% 
  ggplot(aes(x = Year, 
             y = U5MR)) +
  geom_line(aes(group = CountryName)) +
  facet_wrap(~ Continent)
plot_1

#TASK 4: Save the plot as LASTNAME_Plot_1.png
ggsave('GARSIDE_Plot_1.png', plot = plot_1)

#TASK 5: Plot mean U5MR for each continent over time (line plot, color by continent)
plot_2 <- clean_dat %>% 
  group_by(Continent, Year) %>% 
  summarise(Mean_U5MR = mean(U5MR)) %>% 
  ggplot(aes(x = Year,
             y = Mean_U5MR,
             color = Continent)) +
  geom_path()
plot_2

#TASK 6: Save the plot as LASTNAME_Plot_2.png
ggsave('GARSIDE_Plot_2.png', plot = plot_2)

#TASK 7: Create 3 models of U5MR (mod1 = Year, mod2 = Continent and Year, mod3 = Year, Continent, and interaction)
mod1 = glm(dat = clean_dat,
           formula = U5MR ~ Year)
summary(mod1)

mod2 = glm(dat = clean_dat,
           formula = U5MR ~ Year + Continent)
summary(mod2)

mod3 = glm (dat = clean_dat,
            formula = U5MR ~ Year * Continent)
summary(mod3)

#TASK 8: Compare the 3 models with respect to performance (comment which model you think is best)
library(easystats)
compare_performance(mod1, mod2, mod3) %>% plot()
##Mod3 is the best

#TASK 9: Plot the 3 models' predictions
clean_dat$pred1 <- predict(mod1, clean_dat) 
clean_dat$pred2 <- predict(mod2, clean_dat)
clean_dat$pred3 <- predict(mod3, clean_dat)
View(clean_dat)

pred_plot <- clean_dat %>% 
  pivot_longer(starts_with('pred'),
               names_to = 'Prediction',
               values_to = 'Predicted_U5MR') %>% 
  ggplot(aes(x = Year, y = Predicted_U5MR, color = Continent)) + 
  geom_line() +
  facet_wrap(~ Prediction)
pred_plot

