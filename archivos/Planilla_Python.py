pip install librería #En CMD, Powershell u otro terminal. Si no sirve esto usar "pip3".

## IMPORTACIÓN DE PAQUETES
import pandas as pd # Permite importar distintas bases de datos
import numpy as np  # Permite operar con números
import matplotlib as plt # Permite trabajar gráficos
import xlwings as xw # Permite trabajar y automatizar procesos en excel usando python
import time 
import os # Permite cambiar el directorio 
from itertools import count
from pathlib import Path # Permite conocer el directorio que estamos trabajando
from datetime import datetime 
from datetime import date
from datetime import timedelta
from numpy import array # Puede parecer redudante importar parte de una librería que ya llamamos, pero esto se usa por si el python se pone weon y falla. 

# IMPORTACIÓN DE DATOS
Path.cwd() # Vemos cuál es el directorio actual
os.chdir('ruta') # Cambiamos el directorio de trabajo

df = pd.read_excel("nombre_archivo.xlsx") # Crea dataframe a partir de datos xlsx o xls
df = pd.read_csv("nombre_archivo.csv",encoding="latin-1",sep=";") # Crea dataframe a partir de datos csv, separando columnas por ;

# ESTUDIANDO LA BASE DE DATOS
df.info(verbose=False) # Da el número de filas, columnas y tipo de variables
df.describe() # Da estadísticos generales de cada variable
df.head(10) # Selecciona las primeras 10 observaciones
df.tail(10) # Selecciona las últimas 10 observaciones 
df.shape[0] # Cuenta el número de filas 
df.shape[1] # Cuenta el número de columnas 
df['A'].value_counts() # Cuenta el número de filas con valores únicos para la columna A
df.loc[:, ["country", 'capital']] # Captura las observaciones de las columnas donde salen los textos (para todas las filas)
df.loc[df['var1']>10, ['var1', 'var2']] # Selecciona obs que cumplan la condición para dos columnas
df.loc[1:10]["var"] # Muestra un rango de observaciones de una columna en particular
df.loc[df["var"] == "texto"] # Filtra las observaciones de una variable que tenga cierto texto 
df.loc[df["var"] > 1000000] # Filtra las observaciones de la columna que cumpla la condición
df.iloc[[1,2,3], [0,1]] # Captura las observaciones de la columna 1 y 2, de las filas 1, 2 y 3
df.iat[1, 2] # Selecciona la observación 1 de la columna 2
df.at[1, 'A'] # Selecciona la observación 1 de la columna A
df['nombre columna'] = df['nombre columna'].astype(tipo de dato al que se quiere cambiar el tipo de la columna) 
df = df.set_index('nombre columna') 
print(df.loc["4.367.282-7":"19.500.328-3"])# Muestra las observaciones que contienen esta información en el dataframe

# MODIFICANDO LA BASE DE DATOS
del df["nombre_columna"] # Elimina columna del dataframe
df = df.drop(columns=['var1', 'var2',...]) # Elimina varias columnas
df = df.drop(df.iloc[1,2,3].index) # Dropea un rango filas por índice
df = df.drop_duplicates() # Elimina filas duplicadas
df = df.dropna() # Borra las filas con missing values 
df = df.fillna(0) # Reemplaza los missing values por 0 
df["var"]=df["var"].astype("datetime64") # Cambia el formato de una columna a formato temporal
df["Area"] = df.largo*df.ancho # Genera una nueva variable en función de otras que están en la base
df["Area"] = df["Area"]*1.03 # Actualiza los valores de la columna aumentándo sus valores un 3%
df.rename(columns={'nombre_nuevo1': 'nombre_antiguo1','nombre_nuevo2':'nombre_antiguo2'},inplace=True) # Renombre de columnas por nombre
df.rename(columns={df.columns[1]: 'nombre_nuevo1', df.columns[2]: 'nombre_nuevo2'}, inplace=True) # Renombre de columnas por indice
df["nombre columna"].str.lower() # Cambiar el texto de una columna todo a minúscula
df["nombre columna"].str.upper() # Cambiar el texto de una columna todo a mayúscula

df.sort.values('var', ascending=False) # Ordena observaciones en función de una variable de manera descendente
df = df[['var1','var2', 'var3',...]] # Reordena pocas variables de la base como queramos
mysubset = ["var_1","var_2"] # Guardamos las variables que queremos poner al principio de la base 
df[sorted(df, key=lambda x: x not in mysubset)] # Corremos este código y el resto de variables mantiene su orden

df = df.loc[~(df["RUT"].str.contains("XXXX")) & ~(df["Nombre"].str.contains("XXXX"))] # Elimina las filas que tengan de texto "XXXX" en las variables RUT y NOMBRE
df["var"] = df["var"].str.replace("-"," ") # Se Reemplaza en la columna las observaciones que tengan un guión por un espacio. 
df = df["Nombre Apellido"].str.split(" ",expand=True) #Separa las palabras de la variable en distintas columnas 


# Gráficos
plt.style.use('dark_background') # Modo oscuro del gráfico
plt.figure(figsize=(10,6)) # Tamaño del gráfico

plt.plot(objeto_x, objeto_y, marker='o', linestyle='--', color='g', label="etiqueta serie") # Comando para gráfico genérico (series de tiempo?) 
plt.bar(Etiquetas, Valores) # Gráfico de barras
plt.pie(Valores, labels=['Etiquetas'] ) # Gráfico de Torta
plt.hist(Valores, Valores_bins, edgecolor='black') # Histograma
plt.boxplot(edades) # Gráfico de Cajas y Bigotes
plt.scatter(objeto_x, objeto_y) # Gráfico de dispersión

plt.xlabel('Texto eje X')
plt.ylabel('Texto eje Y')
plt.title("Texto título") 
plt.legend(loc='ubicación_legenda')
plt.yticks([N°1, N°2, ..., ], ["Texto1, Texto2, ..., "]) # Marcadores eje Y
plt.savefig('.png') # Guardar el gráfico
plt.show() # Mostrar el gráfico

# AUTOMATIZACIÓN EN EXCEL (XLWINGS)
xb = xw.Book("nombre_archivo.xlsx") # Abre el archivo excel. Es necesario que en la carpeta del directorio esté el archivo a abrir
hoja=xb.sheets["nombre_hoja"] # Identifica la hoja del excel 
hoja.range("A1").expand('table').copy # Copia los datos de la hoja indicada desde la celda A1

hoja_nueva=xb.sheets.add(name="nombre_hoja_nueva") # Agregamos una hoja nueva
hoja_nueva.range("A1").paste(paste='all') # Pegamos los datos que teníamos copiado previamente

hoja_nueva.range("I53").value = "=SUM(I2:I51)" # Selecciona una celda y ejecuta alguna función
hoja_nueva.range("H53").value = "Total" # Selecciona una celda y coloca algun texto
hoja_nueva.range("A1:B5").color=(154, 200, 122) # Selecciona celdas y cambia su color
hoja_nueva.range("A1").api.Font.Size=24  # Cambia el tamaño del texto de una celda en una hoja determinada 
hoja_nueva.range('D10:G11').row_height=30 # Cambia el alto de las columnas seleccionadas
hoja_nueva.range('D10:G11').column_width=30 # Cambia el ancho de las columnas seleccionadas

xb.save(str(date.today())+"Algun_texto") # Guardamos el excel poniéndole algún nombre 

# ESTADÍSTICOS
count() # Cuenta los valores no faltantes de un objeto 
sum() # Captura la suma de un objeto
min() # Captura el valor mínimo de un objeto
max() # Captura el valor máximo de un objeto
median() # Captura el valor mediano de un objeto
mean() # Captura el valor medio de un objeto
quantile([0.25, 0.75]) # Captura los quantiles de un objeto
var() # Captura la varianza de un objeto
std() # Captura la desviación estándar de un objeto
apply(funcion) # Aplica una función a una objeto

# OPERACIONES CON BASES DE DATOS 
pd.concat([df1, df2]) # Hace append de las bases, deben tener el mismo nombre las columnas
pd.concat([df1, df2], axis=1) # Hace append de las bases, si tienen columnas con distinto nombre se agregan al lado
pd.melt(df) # Hace reshape de columna a filas
df.pivot(columns='var', values='val') # Hace reshape de filas a columnas
df.join(df2) 

df1=pd.DataFrame({'x1' : ['A', 'B', 'C'], 'x2' : [1, 2, 3]})
df2=pd.DataFrame({'x1' : ['A', 'B', 'C'], 'x3' : ['T', 'F', 'T']})
pd.merge(df1, df2, how='left', on='x1') # Junta desde df2 a df1 usando col x1. Col x3 tendrá NA en filas que no hagan match con obs de x1
pd.merge(df1, df2, how='right', on='x1') # Junta desde df1 a df2 usando col x1. Col x2 tendrá NA en filas que no hagan match con obs de x3 
pd.merge(df1, df2, how='inner', on='x1') # Junta df1 y df2 reteniendo solo aquellas obs que tengan en común en la x1. No quedarían NA en la base  
pd.merge(df1, df2, how='outer', on='x1') # Junta df1 y df2 reteniendo todas los valores de todas las filas. 

df1[df1.x1.isin(df2.x1)] # El df1 se queda solo con las observaciones que tenga match con df2 en la columna x1
df1[~df1.x1.isin(df2.x1)] # El df1 se queda solo con las observaciones que NO tenga match con df2 en la columna x1

df3=pd.DataFrame({'x1' : ['A', 'B', 'C'], 'x2' : [1, 2, 3]})
df4=pd.DataFrame({'x1' : ['B', 'C', 'D'], 'x2' : [2, 3, 4]})
pd.merge(df3, df4) # Queda con la intersección de filas (match perfecto) entre df3 y df4
pd.merge(df3, df4, how='outer') # Queda con la unión de filas entre df3 y df4, no quedan NA.
pd.merge(df3, df4, how='outer', indicator=True) # Queda con filas que aparecen en df3 y que no aparecen en df4. 

## EXPORTACIÓN
df.to_csv("nombre archivo CSV", index=false) # Exporta el dataframe a formato CSV
df.to_excel("nombre archivo CSV", index=false) # Exporta el dataframe a formato xlsx

# PROGRAMACIÓN
z = 6
if z % 2 == 0 :
print("z es divisible por 2") # Verdadero
elif z % 3 == 0 :
print("z es divisible por 3") # Dado que lo anterior es verdadero, esta parte nunca se alcanza
else :
print("z no es divisible por 2 ni por 3") # Si ninguna de las 2 condiciones anteriores se cumple, entonces me tira esta opción

phrase = ['printed', 'with', 'a', 'dash', 'in', 'between']
for word in phrase:
    print(word, end='-') # Escribe el guión entremedio de cada palabra definida


# Comandos Sueltos
data = [lista de listas] 
df = pd.DataFrame(data) # Crea un data frame a partir de las listas definidas previamente
df = pd.DataFrame(data, columns=[lista nombres columnas]) 
** # Operador de elevado
type(objeto) # Indica qué tipo de objeto es 
texto1='ab'
texto2="cd" # No importa si tiene una o dos comillas el string
resultado=texto1+texto2 # Es posible sumar objetos de texto, no solo números. Misma lógica aplica a las listas
round(número, N°_decimales) # Redondeo hacia arriba desde 0.5, Por defecto a cero decimales
len(lista / texto) # Indica el largo de la lista o string
lista.index("texto") # Muestra en qué lugar de una lista se encuentra un string determinado
lista.count(Número) # Muestra en qué lugar de una lista se encuentra un número determinado
string.replace('original', 'nuevo') # Permite editar texto en un objeto string
np.random.normal(media, desv estándar, N°_muestras) # Genera una simulación de distribución normal
date.today() # Tira la fecha de hoy
df["Nombre columna de tipo object"].str.(función de string) 
df["nombre columna"].str.len() 
df["nombre columna"].str[posición caracter] 
df["nombre columna"].str[posición carácter inicial:posición carácter final] 
df["nombre columna"].str.find(x) 
df.columns = [nombres de las columnas]
df.loc[df['Nombre columna'] (operación lógica)] 
df.loc[(df['Nombre columna'] (operación lógica)) (&/|) (df['Nombre columna'] (operación lógica)) (&/|) … ] 
df = df.sort_values(by=(columna o lista de columnas), ascending = (True o False)) 
df.pivot(index=(columna que determinará las filas), columns=(columna que determinara las columnas), values=(columna a analizar)) 
df.pivot_table(index=(columna que determinará las filas), columns=(columna que determinara las columnas),values=(columna a analizar),aggfunc=(funciones de la librería numpy)) 
help(comando) # Muestra la documentación del comando
?comando # Muestra la documentación del comando


