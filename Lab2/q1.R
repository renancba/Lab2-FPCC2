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

dados_q1 <- dados %>%
  mutate(periodo = ifelse(mes %in% c(1, 2), "Jan-Fev", "Ano Completo")) %>%
  group_by(cidade, periodo) %>%
  summarise(tmedia_media = mean(tmedia, na.rm = TRUE), .groups = "drop")

ggplot(dados_q1, aes(x = cidade, y = tmedia_media, fill = periodo)) +
  geom_col(position = position_dodge(0.9)) +
  geom_text(aes(label = round(tmedia_media, 1)), 
            position = position_dodge(0.9), 
            vjust = -0.3, size = 3) +
  labs(title = "Temperatura média por cidade (Ano vs Jan-Fev)",
       y = "Temperatura Média (°C)", fill = "Período") +
  theme_minimal()
