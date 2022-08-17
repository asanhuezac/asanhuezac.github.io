import Pandas as pd 
data = [lista de listas] 
df = pd.DataFrame(data) 
df = pd.DataFrame(data, columns=[lista nombres columnas]) 
df = pd.read_csv("nombre archivo CSV",encoding="latin-1",sep=";") 
df.dtypes() 
df["nombre columna"] 
df.loc[identificador fila] 
df.loc[identificador fila inicial: identificador fila final] 
df.loc[identificador fila fila][ "nombre columna"] 
df.loc[df['Nombre columna'] (operación lógica)] 
df["nombre nueva columna"] = valor específico 
df["nueva columna"] = (operación con otra columna del Data Frame) 
df["columna del Data Frame"] = valor específico 
df["columna del Data Frame"] = (operación con otra columna del Data Frame) 
del df["nombre columna"] 
df.describe() 
df.to_csv("nombre archivo CSV", index=false) 

df= df.rename(columns={"nombre_antiguo_columna":"nombre_nuevo_columna"}) 
df[nombre columna] = df[nombre columna].astype(tipo de dato al que se quiere cambiar el tipo de la columna) 
df = df.set_index(nombre columna) 
df.head() 
df.tail() 
df.iloc[índice de fila o rango de índices de fila] 
df = df.fillna(valor con el que se quiere reemplazar los valores NaN) 
df = df.append(df2) 
df= df.drop(df.iloc[filas o rango de filas].index)

for index,row in df.iterrows(): 
row[nombre columna] 
df["Nombre columna de tipo object"].str.(función de string) 
df["nombre columna"].str.len() 
df["nombre columna"].str[posición caracter] 
df["nombre columna"].str[posición carácter inicial:posición carácter final] 
df["nombre columna"].str.lower() 
df["nombre columna"].str.upper() 
df["nombre columna"].str.replace(x,y) 
df["nombre columna"].str.contains(x) 
df["nombre columna"].str.find(x) 
df["nombre columna"].str.split(x) 
df["nombre columna"].str.split(x,expand=True) 
df.columns = [nombres de las columnas] 
df.join(df2) 
df1.merge(df2,on=columna en específico) 
df1.merge(df2, on=RUT) 
df1.merge(df2, on=RUT) 
df1.merge(df2,on=columna en específico,how="left") 
df1.merge(df2,on=columna en específico,how="outer") 

df.loc[df['Nombre columna'] (operación lógica)] 
df.loc[(df['Nombre columna'] (operación lógica)) (&/|) (df['Nombre columna'] (operación lógica)) (&/|) … ] 
df = df.sort_values(by=(columna o lista de columnas), ascending = (True o False)) 
df.pivot(index=(columna que determinará las filas), columns=(columna que determinara las columnas), values=(columna a analizar)) 
df.pivot_table(index=(columna que determinará las filas) ,columns=(columna que determinara las columnas),values=(columna a analizar),aggfunc=(funciones de la librería numpy)) 
