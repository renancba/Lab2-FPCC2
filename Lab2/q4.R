library(dplyr)
library(ggplot2)
library(lubridate)
library(readr)
library(patchwork)

dados <- read_csv("Data/clima_cg_jp-semanal.csv")

dados_q4 <- dados %>%
  arrange(cidade, ano, mes, semana) %>%
  group_by(cidade) %>%
  mutate(tmedia_lag = lag(tmedia)) %>%
  ungroup() %>%
  filter(!is.na(tmedia_lag), !is.na(tmedia))

ggplot(dados_q4, aes(x = tmedia_lag, y = tmedia)) +
  geom_point(alpha = 0.6, color = "steelblue") +
  geom_smooth(method = "lm", se = FALSE, color = "darkblue") +
  facet_wrap(~ cidade) +
  labs(title = "Relação entre a temperatura de uma semana e da anterior",
       x = "Temperatura da Semana Anterior (°C)",
       y = "Temperatura Atual (°C)") +
  theme_minimal()
