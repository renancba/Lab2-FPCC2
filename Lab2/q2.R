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

dados_q2 <- dados %>%
  group_by(mes) %>%
  summarise(tmedia = mean(tmedia, na.rm = TRUE), .groups = "drop") %>%
  mutate(tipo = ifelse(mes == 6, "Festas Juninas", "Outro Mês"))

ggplot(dados_q2, aes(x = factor(mes), y = tmedia, fill = tipo)) +
  geom_col() +
  geom_text(aes(label = round(tmedia, 1)), vjust = -0.3, linewidth = 3) +
  labs(title = "Temperatura média por mês com destaque para junho",
       x = "Mês", y = "Temperatura Média (°C)", fill = "") +
  theme_minimal()
