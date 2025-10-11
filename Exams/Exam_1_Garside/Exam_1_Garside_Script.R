##TASK I Read the cleaned_covid_data.csv file into an R data frame. (20 pts)
cleaned_covid_df <- read.csv('cleaned_covid_data.csv') 

##TASK II  Subset the data set to just show states that begin with “A” and save this as an object called A_states. (20 pts)
###Use the tidyverse suite of packages
###Selecting rows where the state starts with “A” is tricky (you can use the grepl() function or just a vector of those states if you prefer)
library(tidyverse)
A_states <- cleaned_covid_df %>% 
  filter(grepl(pattern = '^A', Province_State))
View(A_states)

##TASK III Create a plot of that subset showing Deaths over time, with a separate facet for each state. (20 pts)
###Create a scatterplot
###Add loess curves WITHOUT standard error shading
###Keep scales “free” in each facet
A_State_Deaths_Plot <- A_states %>%
  mutate(Last_Update = as.Date(Last_Update)) %>% 
  ggplot(aes(x = Last_Update,
             y = Deaths)) +
  geom_point() +
  geom_smooth(method = 'loess', se = F, color = 'blue') +
  facet_wrap(~ Province_State, scales = 'free') +
  scale_y_continuous(expand = c(0,0)) +
  labs(x = "Time",
       y = "Deaths",
       title = "A-State Covid Deaths Over Time") 

##TASK IV (Back to the full dataset) Find the “peak” of Case_Fatality_Ratio for each state and save this as a new data frame object called state_max_fatality_rate. (20 pts)
###I’m looking for a new data frame with 2 columns:
  #“Province_State”
  #“Maximum_Fatality_Ratio”
##Arrange the new data frame in descending order by Maximum_Fatality_Ratio
##This might take a few steps. Be careful about how you deal with missing values!
state_max_fatality_rate <- cleaned_covid_df %>%
  filter(!is.na(Case_Fatality_Ratio)) %>%
  group_by(Province_State) %>%
  summarise(Maximum_Fatality_Ratio = max(Case_Fatality_Ratio, na.rm = T)) %>%
  arrange(desc(Maximum_Fatality_Ratio))
View(state_max_fatality_rate)


##TASK V Use that new data frame from task IV to create another plot. (20 pts)
  #X-axis is Province_State
  #Y-axis is Maximum_Fatality_Ratio
  #bar plot
  #x-axis arranged in descending order, just like the data frame (make it a factor to accomplish this)
  #X-axis labels turned to 90 deg to be readable
  #Even with this partial data set (not current), you should be able to see that (within these dates), different states had very different fatality ratios.
state_max_fatality_rate <- state_max_fatality_rate %>%
  mutate(Province_State = fct_reorder(Province_State, Maximum_Fatality_Ratio, .desc = TRUE))

Deaths_by_State_Plot <- state_max_fatality_rate %>% 
  ggplot(aes(x = Province_State,
             y = Maximum_Fatality_Ratio)) +
  geom_bar(stat = 'identity') +
  theme(axis.text.x = element_text(angle = 90)) +
  scale_y_continuous(expand = c(0,0)) +
  labs(x = 'State/Province',
       y = 'Maximum Covid Death Rate',
       title = "Peak Rate of COVID Deaths Per State")

##TASK VI (BONUS 10 pts) Using the FULL data set, plot cumulative deaths for the entire US over time
###You’ll need to read ahead a bit and use the dplyr package functions group_by() and summarize() to accomplish this
us_cumulative_deaths <- cleaned_covid_df %>% 
  mutate(Last_Update = as.Date(Last_Update)) %>%
  group_by(Last_Update) %>%
  summarise(Total_Deaths = sum(Deaths)) %>%
  arrange(Last_Update) %>%
  mutate(Cumulative_Deaths = cumsum(Total_Deaths))

Cumulative_Deaths_Plot <- us_cumulative_deaths %>% 
  ggplot(aes(x = Last_Update,
             y = Cumulative_Deaths)) +
  geom_point() +
  labs(x = 'Date',
       y = 'Cumulative Deaths',
       title = 'Total COVID Deaths Over Time') +
  scale_x_date(date_breaks = "3 month", date_labels = "%b %Y") +
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE)) +
  theme(axis.text.x = element_text(angle = 90), 
        plot.margin = margin(t = 0.25, r = 0.5, b = 0.25, l = 0.25, unit = "cm"))

