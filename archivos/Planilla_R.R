
install.packages("nombre_del_paquete") # Instalación del Paquete

# Librerias útiles a cargar (llama paquetes)
library(readr) # Archivos excel, xls, xlsx
library(haven) # Archivos dta, sav, sas
library(readxl) # Archivos csv, csv2, tsv, delim
library(dplyr) # Manipulación de datos
library(stringr) # Manipulación de strings
library(ggplot2) # Gráficos
library(WDI) # Datos online del World Development Indicators
library(tidyquant) # Modela series financieras desde Yahoo Finance
library(stargazer) # Comparación de modelos en un tabla
library(mfx) # Efectos Marginales
library(tidyverse) # Megapaquete
library(janitor) 
library(kableExtra)
library(lubridate) # Trabaja con fechas
library(zoo)
library(forcats)
library(ggthemes)
library(RColorBrewer)
library(ggfittext)
library(treemapify)
library(reshape2)
library(desc)
library(skimr)
library(purr) # Realiza iteraciones
library("gapminder") # Llama datos de esta base
library(quantmod) # Permite bajar datos de yahoo finance con getsymbols
library(profvis) # Permite ver el tiempo necesario para correr cada código
library(scales) # Permite cambiar los puntos y comas de los ejes en ggplot


# Importación de Datos
Base_Excel <- read_excel("Directorio/Base_Excel")
Base_Stata <- read_dta("Directorio/Base_Stata")
Base_Csv <- read.csv("Directorio/Base_Csv")
Base_Csv <- fread("Directorio/Base_Csv", skip=N°filas, nrows=N°filas) # Lo mismo de arriba solo que con un comando más rápido. Si se usa sistem.time() se comprueba


# MANIPULANDO BASE DE DATOS 
Nombre_Data_Frame <- data.frame(Var_1,Var_2, ...) # Generando Data Frame
Sub_Data_Frame <- Data_Frame %>% select(Var_1, Var_2, ...) # Seleccionando Variables 
Data_Frame_Filtrado <- Data_Frame %>% filter(condicion_1 | Condicion_2 & Condición_3 ... ) # Filtrando Observaciones
variable := NULL # Borrar columna/variable
Data_Frame <- Data_Frame %>% select(Var_1, Var_2, ..., everything()) # Reordenamiento de columnas

data_frame <- data_frame %>% rename(nombre_nuevo1 = nombre_antiguo1, 
                                    nombre_nuevo2 = nombre_antiguo2,
                                      ...) # Renombrando Variables

data_frame$var <- "Nombre de variable"
data_frame <- data_frame %>% 
  mutate(var_nueva = funcion(de_algo)) %>% 
  mutate(var_dummy_simple = ifelse(condicion_1 | Condicion_2 & Condición_3 ... , Valor_Verdadero, Valor_Falso)) %>% 
  mutate(var_dummy_compleja = ifelse(Condición_1... , Valor_Verdadero, ifelse(Condicion_1... , Valor_Verdadero, Valor_Falso))) %>%
  mutate(var_categórica= ifelse(condicion_1... , "Texto_Verdadero",
                         ifelse(condicion_1... , "Texto_Verdadero",
                         ifelse(condicion_1... , "Texto_Verdadero", "Texto_Falso")))) %>% 
  mutate(var_existente = recode(var_existente,
                         "Etiqueta_antigua_1" = "Etiqueta_nueva_1",
                         "Etiqueta_antigua_2" = "Etiqueta_nueva_2",
                         ...)) # Generando Variables y modificando etiquetas
data_frame[N° fila, variable:="Texto_a_modificar"] # Modificación de algo puntual de una variable
data_frame[condicion_filas, var:=NA] # Modificación de variable en filas que cumplan condiciones

# ESTADÍSTICAS DESCRIPTIVAS:
mean(variable, na.rm=TRUE)
sd(variable, na.rm=TRUE)
sqrt(variable, na.rm=TRUE)
cov(variable_1,variable_2)
cor(variable_1,variable_2)
median(variable)
quantile(variable, N° de cuantil)
summary(tibble) # Todo el tibble
summary(tibble$variable) #Variable particular
batrips[condicion_1 & condicion_2, .(estadística(var), estadística(var))] # Filtra filas, y saca estadística de columnas
batrips[, .(min_duration=min(duration), max_duration=max(duration)), by=.(var1, var2, ...)]
batrips[, duration_hour := duration/3600] # Agrega nueva columna de forma eficiente usando variable existente mediente :=


# TABULACIÓN 
Data_Frame %>% 
  group_by(Var_categórica) %>% 
  summarize(Promedio = mean(Var_númerica),
            Mediana = median(Var_númerica),
            Mínimo=min(Var_númerica),
            Máximo=max(Var_númerica))

dcast(Data_Frame, Var_filas ~ Var_columnas, 
      estadística_descriptiva, 
      value.var="variable_de_la_estadística_descriptiva", 
      na.rm = TRUE)

# GRÁFICOS

hist(variable) # Histograma

Data_Frame %>% ggplot(mapping=aes(x=Var_absicas, y=Var_ordenadas, color=Var_para_color, group=var_para_geom_line)) +
  geom_() + # (point, line, density, col, bar, boxplot, histogram) 
  geom_smooth(data=Data_Frame[Data_Frame$Varcondicion_1 & Data_Frame$Varcondicion_2, ...], method='lm', color='algún_color', se=FALSE)+ # Regresión en el gráfico
  geom_jitter() + # Se usa para boxplot. Aleatoriza los puntos en las cajas. 
  facet_wrap(~variable_categórica, ncol=N°) + # Gráfico separado por variable categórica
  xlim(N_min, N_máx) + # Valores eje absicas (sin etiqueta de valores)
  ylim(N_min, N_máx) + # Valores eje ordenadas (sin etiqueta de valores)
  scale_y_log10()+ # Escala logarítmica
  scale_x_date()+ # Escala con formato fechas
  scale_x_continuous(name="texto_eje", breaks = seq(Desde, Hasta, by=)) + # Valores que queremos que aparezcan en el eje
  theme_()+ # Tema del gráfico (minimal, dark, economist, classic ...)
  scale_colour_manual(values=c("#1b9e77", "#d95f02", "#826bb5", "#e7298a")) + # Colores personalizados para Var_colores
  coord_flip() + # Invertir los ejes del gráfico
  geom_dark() + # Modo oscuro. Se necesita el paquete "ggdark" cargado 
  labs(title = "Texto",
       subtitle = "Texto",
       x="Texto",
       y= NULL,
       caption = "Texto")+
  theme(plot.title = element_text(family = "serif", size = N°) "Elegimos el tipo de letra y tamaño"
        plot.subtitle = element_text(family = "Bookman", size = N°) "Elegimos el tipo de letra y tamaño"
        plot.caption = element_text(hjust = 1), # Ajuste de ubicación de las Notas
        axis.line = element_line(size = N°), # Elegimos grosor de ejes 
        legend.title = element_blank(), # Sin título de leyenda
        legend.position = c(0.9, 0.3)) # Posición de leyenda

# REGRESIONES 
mco <- lm(Var_dep ~ Var_ind_1 + Var_ind_2 + ..., data = Data_Frame) 
mco <- lm(Var_dep ~ 0 + Var_ind_1 + Var_ind_2 + ..., data = Data_Frame) # Modelo sin Constante
mco <- lm(Var_dep ~ 1, data = Data_Frame) # Modelo sólo con Constante

probit <- glm(Var_dep ~ Var_ind_1 + Var_ind_2 + ..., family = binomial(link = "probit"), data = Data_Frame)

probitmfx(Var_dep ~ Var_ind_1 + Var_ind_2 + ..., data = Data_Frame, atmean=FALSE) # Efecto Marginal Promedio
marginal_en_promedio <- probitmfx(Var_dep ~ Var_ind_1 + Var_ind_2 + ..., data = Data_Frame, atmean=TRUE)$mfxest # Efecto Marginal en el Promedio


# COMPARACIÓN DE MODELOS
stargazer(mco, probit, coef = list(NULL, marginal_en_promedio[,1]), 
          se = list(NULL, marginal_en_promedio[,2]), 
          type = "text",
          title = "Comparación de modelos",
          dep.var.labels = "Etiqueta Var Dependiente",
          model.numbers = FALSE,
          column.labels = c("Etiqueta_1", "Etiqueta_2",...))

# MATRICES
rbind(fila_1,fila_2,...) # Para matrices y dataframes, es un append. 
rownames(variable) <- c("fila_1","fila_2",...) # Nombre de filas
colnames(variable) <- c("columna_1","columna_2",...) # Nombre de columnas
eigen(matriz) # para calcular los valores propios (vaps) y vectores propios (veps)
diag(A) #Elementos diagonal principal matriz A 
t(A) #Traspuesta
solve(A) #Inversa
det(A) #Determinante
rowSums(A) #Suma elementos de cada fila
colSums(A) #Suma elementos de cada columna
A+B #Suma de matrices
A %*% B #Multiplicación de matrices
A*B # Multiplica elemento (i,j) de A y B respectivamente

# CÓDIGOS SUELTOS
arrange(Var_1, Var_2, desc(Var3), ...) # Orden horizontal de variables
seq(desde, hasta, delta) # Secuencia de valores
c(elemento_1,elemento_2,elemento_3,...) # agrupacion de elementos
typeof(variable) # Dice qué tipo de elemento es
length(variable) # Dice qué tan largo es el elemento
sum(variable) # Suma 
prod(variable) # Producto
cumsum(variable) #Suma acumulada. Podría usarse para contruir segmentos usando antes variables dummys. 
cumprod(variable) #Producto acumulado
paste0("texto", variable, número)  # útil para unir elementos de distinto tipo, en una frase. Se puede usar para guardar resultados en iteraciones
rep("texto", número de veces) #Repetición
is.na(variable) ##Reporta missing values de variable
na.omit(variable) ##Omitir missing values
print(version) # Muestra la versión actual del programa
microbenchmark(proceso1, proceso2, ...) # Velocidad computacional de ejecución del proceso
profvis({
codigo1
codigo2
...
}) # Permite ver el tiempo necesario para correr cada código
apply(datos, 1 (filas) 2 (columnas), estadístico) # Aplica 

sort(variable) #Orden ascendente de observaciones
sort(variable, decreasing=TRUE) #Orden descendente
round(variable, N° decimales) # Aproximación 
rnorm(N° obs, promedio, Desv_est) # Distribucion normal 
sample(c(input1, input2, ...), n°_repeticiones, replace=TRUE, prob= c(peso1, peso2,...)) # Muestreo aleatorio
difftime(end_date, start_date, units="min") # Indica el tiempo de diferencia entre dos fechas
sctest(Data_frame$Var_dep ~ Data_frame$Var_ind, type = "Chow", point = Punto_de_quiebre) # Test de Chow
grepl("texto", variable) # Busca el texto del primer argumento en el segundo argumento (variable de dataframe)

# INFO ADICIONAL
list() = .()

