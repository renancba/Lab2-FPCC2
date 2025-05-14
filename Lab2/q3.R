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

dados_q3 <- dados %>%
  mutate(semana_data = as.Date(semana),   
         semana_num = week(semana_data))  

dados_q3_total <- dados_q3 %>%
  group_by(cidade, semana_num) %>%
  summarise(total_chuva = sum(chuva, na.rm = TRUE))

ggplot(dados_q3_total, aes(x = semana_num, y = total_chuva)) +
  geom_line(color = "#2C3E50", size = 1.2) +  
  geom_point(size = 3, color = "#E74C3C") +   
  facet_wrap(~ cidade, ncol = 1, scales = "free_y") +  
  labs(title = "Volume total de chuva por semana em cada cidade",
       x = "Semana do Ano", y = "Total de Chuva (mm)") +
  theme_minimal() +
  theme(strip.text = element_text(face = "bold", size = 12))  
