library(tidyverse)
dat <- read.csv('BioLog_Plate_Data.csv')
str(dat)
dim(dat)
View(dat)

##DATA CLEANUP
###Make longer by adding "time" column and then "absorbance" column
###Add "sample type" column
clean_dat <- dat %>% 
  pivot_longer(c("Hr_24", 'Hr_48', 'Hr_144'),
               names_to = "Time",
               values_to = "Absorbance") %>% 
  mutate(Time = case_when(Time == 'Hr_24' ~ 24,
                          Time == 'Hr_48' ~ 48,
                          Time == 'Hr_144' ~ 144)) %>% 
  mutate(Sample.Type = case_when(Sample.ID == 'Clear_Creek' ~ 'Water',
                                Sample.ID == 'Waste_Water' ~ 'Water',
                                Sample.ID == 'Soil_1' ~ 'Soil',
                                Sample.ID == 'Soil_2' ~ 'Soil'))
View(clean_dat)

##PLOTS
###Matching static plot
static_plot <- clean_dat %>% 
  filter(Dilution == 0.1) %>% 
  ggplot(aes(x = Time,
             y = Absorbance,
             color = Sample.Type)) +
  geom_smooth(se = F) +
  facet_wrap(~ Substrate) +
  labs(title = "Just dilution 0.1",
       color = "Type") +
  theme_minimal()

###Matching animated plot
library(gganimate)
animated_plot <- clean_dat %>%
  filter(Substrate == "Itaconic Acid") %>%
  group_by(Sample.ID, Time, Dilution) %>%
  summarise(Mean_absorbance = mean(Absorbance)) %>%
  ggplot(aes(x = Time, 
             y = Mean_absorbance,
             color = Sample.ID)) +
  geom_line() +
  facet_wrap(~ Dilution) +
  labs(color = "Sample ID") +
  theme_minimal() +
  transition_reveal(Time)
