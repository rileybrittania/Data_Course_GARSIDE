#TASK I

library(tidyverse)
library(modelr)
library(easystats)
library(broom)
library(fitdistrplus)

shroom_df <- read.csv('mushroom_growth.csv')

View(shroom_df)

#TASK II

light_plot <- shroom_df %>% 
  ggplot(aes(x = Light,
             y = GrowthRate,
             fill = Species)) +
  geom_bar(stat = 'identity', position = 'dodge', alpha = 0.5)
light_plot

nitro_plot <- shroom_df %>% 
  ggplot(aes(x = Nitrogen,
             y = GrowthRate,
             fill = Species)) +
  geom_bar(stat = 'identity', position = 'dodge', alpha = 0.5)
nitro_plot

humid_plot <- shroom_df %>% 
  ggplot(aes(x = Humidity,
             y = GrowthRate,
             fill = Species)) +
  geom_bar(stat = 'identity', position = 'dodge', alpha = 0.5)
humid_plot

temp_plot <- shroom_df %>% 
  ggplot(aes(x = Temperature,
             y = GrowthRate,
             fill = Species)) +
  geom_bar(stat = 'identity', position = 'dodge', alpha = 0.5)
temp_plot

species_plot <- shroom_df %>% 
  ggplot(aes(x = Species,
             y = GrowthRate)) +
  geom_bar(stat = 'identity', position = 'dodge', alpha = 0.5)
species_plot

#TASK III

light_mod <- glm(dat = shroom_df,
                 formula = GrowthRate ~ Light)
summary(light_mod)

nitro_mod <- glm(dat = shroom_df,
                 formula = GrowthRate ~ Nitrogen)
summary(nitro_mod)

temp_mod <- glm(dat = shroom_df,
                 formula = GrowthRate ~ Temperature)
summary(temp_mod)

light_temp_mod <- glm(dat = shroom_df,
                      formula = GrowthRate ~ Light * Temperature)
summary(light_temp_mod)

#TASK IV
mean(light_mod$residuals^2)

mean(nitro_mod$residuals^2)

mean(temp_mod$residuals^2)

mean(light_temp_mod$residuals^2)

## light_temp_mod has the lowest mean sq. error

#TASK V 
compare_performance(light_mod, nitro_mod, 
                    temp_mod, light_temp_mod) %>% plot()

## Despite having a higher mean sq. error, the light_mod performs the best

# TASK VI
pred_shroom_df <- shroom_df %>% 
  add_predictions(light_mod) 
pred_shroom_df %>% dplyr::select("GrowthRate","pred")

newdf = data.frame(Light = c(5,15,30,45,60,75,90))
pred = predict(light_mod, newdf)

hyp_preds <- data.frame(Light = newdf$Light,
                        pred = pred)

pred_shroom_df$PredictionType <- "Real"
hyp_preds$PredictionType <- "Hypothetical"
full_shroom_df <- full_join(pred_shroom_df,hyp_preds)

View(full_shroom_df)

# TASK VII
ggplot(full_shroom_df, aes(x = Light)) +
  geom_point(aes(y = GrowthRate), color = "black") +
  geom_point(aes(y = pred, color = PredictionType)) +
  theme_minimal()
