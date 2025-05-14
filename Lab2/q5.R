library(dplyr)
library(ggplot2)
library(lubridate)
library(readr)

dados <- read_csv("Data/clima_cg_jp-semanal.csv")

dados <- dados %>%
  mutate(
    semana = as.Date(semana),
    mes = as.integer(mes),
    ano = as.integer(ano),
    cidade = factor(cidade)
  )

dados_q5 <- dados %>%
  filter(chuva > 0)

ggplot(dados_q5, aes(x = chuva, y = tmedia)) +
  geom_point(alpha = 0.6, color = "darkorange") +
  geom_smooth(method = "lm", se = FALSE, color = "firebrick") +
  scale_x_log10() +
  facet_wrap(~ cidade) +
  labs(title = "Relação entre chuva (log) e temperatura nas semanas com precipitação",
       x = "Chuva (mm, escala logarítmica)",
       y = "Temperatura Média (°C)") +
  theme_minimal()
