                              ***FENVID STATA***

********************************************************************
clear all
capture log close // Cierra archivos log abiertos. si no los hay el capture hace que no tire error
ssc install nombre_comando, replace // Instalación y/o actualización de comandos

*-Importación de datos 
{
pwd // Directrorio Actual
cd "nuevo\directorio" // Cambia directorio a dirección que pongamos

global palabra "Texto" // Macro util para trabajo en equipo
cd "$palabra"

use "base_formato_stata", clear // Abre base formato DTA

import excel "directorio\nombre_base.xlsx", sheet("Nombre_Hoja") cellrange(Coordenadas) firstrow

wbopendata, language(en - English) country() topics() indicator($indicadores) clear long // Esto es una API de datos que vienen del banco mundial.
}

*-Estudiando y Modificando la Base
{
describe
describe var_1 var_2 ...
count
count if condición_1 condición_2 ...

browse var_1 var_2 ...

rename nombre_original nombre_nuevo
rename (vector_nombres_original) (vector_nombres_nuevos)

drop var_1 var_2 ...
drop if condición_1 condición_2 ...

keep var_1 var_2 ...
keep if condición_1 condición_2 ...

order var_1 var_2...
order var_1 * // primero var_1 y todas las demás en el orden que estaban

sort var_1 var_2... // Ordena de manera ascendente obs en función de variables de interés

}

*-Generación de variables y etiquetas
{
label variable nombre_variable "Descripción"

generate nueva_variable = función()

label define nombre_etiqueta 1 "categoría_1" 2 "categoría_2"...
label values nombre_variable nombre_etiqueta
label list nombre_etiqueta

destring var_1, replace // Pasamos var_1 a formato numerico 
generate nueva_var=real(var_1)
replace var_1=substr(var_1, 1, 3) // Reemplaza var_1 por sus primeros 3 caracteres

encode nombre_variable, generate(nueva_variable) // Codificamos var string y pasamos a numérica

egen nueva_variable = función_ya_programada(nombre_variable), by(var_categorica)
}

*-Estadísticas Descriptivas
{
summarize var_1 var_2... 
summarize var_1 var_2..., detail
misstable sum var_1 var_2...

tab variable
tab variable, miss
tab variable [factor_de_expansión]
tab variable [factor_de_expansión] if condición_1 condición_2

tab var_1 var_2
tab var_1 var_2 [factor_de_expansión]
tab var_1 var_2 [factor_de_expansión], col nofreq
tab var_1 var_2 [factor_de_expansión], row nofreq
tab var_1 var_2 [factor_de_expansión], cell nofreq

tabstat var_1 var_2... if condición_1 condición_2... [factor_de_expansión], stats(mean p50 sd min max n ...)

latabstat var_1 var_2... if condición_1 condición_2... [factor_de_expansión], stats(mean p50 sd min max n ...)

by var_categórica : tabstat var_1 var_2..., stats()

}

*-Gráficos
{
ssc install schemepack, replace. // Para el modo oscuro de los gráficos usando ''scheme(neon)''	

graph pie [factor_de_expansión] if condición_1 condición_2, over(var_categorica) plabel(_all percent, format(%9.3g) color(black)) by(, title(texto) subtitle(texto)) by(var_grupos)

graph box var_1 var_2... [factor_de_expansión] if condición_1 condición_2, over(var_categorica) ytitle(texto) by(, title(texto) subtitle(texto) note(texto)) by(var_grupos)

graph bar (Estadística_1) var_1 (Estadística_2) var_2...[factor_de_expansión], over(pareja) by(, title(texto) subtitle(texto) note(texto)) by(var_grupos)

histogram nombre_variable if condición_1 condición_2 [factor_de_expansión], opción_distribuciones ytitle(texto) xtitle(texto) by(, title(texto)) subtitle(texto) caption(texto)) by(var_grupos)

kdensity variable if condición_1 condición_2.. [factor_de_expansión], opción_dist_normal addplot((kdensity variable if if condición_1 condición_2.. [factor_de_expansión])) ytitle(texto) xtitle(texto) title(texto) subtitle(texto) caption(texto) legend(opciónes)

quantile nombre_variable if condición_1 condición_2..., recast(forma_datos) ytitle(texto) xtitle(texto) title(texto) rplots(connect(opción_de_conexión))

twoway (scatter var_1 var_2) (lfit var_1 var_2) if condición_1 condición_2..., ytitle(texto) xtitle(texto) by(, title(texto) subtitle(texto) caption(texto)) by(var_categorica)

twoway (tsline var_1 if condición_1 condición_2, lcolor(ebblue)  lwidth(vthin) lp(dash)) if condición_1_1 condición_2_1..., xlabel(18(1)40) ylabel(0(0.1)0.7) title("titulo") subtitle("Subtítulo") xtitle("titulo_x", margin(small), angle(forty_five))  ytitle("titulo_y") caption("Fuente: Elaboración Propia") scheme(neon) graphregion(margin(medsmall) fcolor(gs2)) name(nombre_graf, replace) legend(order(1 "Chile" 2 "Argentina")) 

graph combine gra_1 gra_2, scheme(neon) graphregion(margin(medsmall) fcolor(gs2)) // Combina 2 graficos en 1
graph export nombre.png, replace // Guarda gráfico abierto como imagen en directorio

}

*-Cambio en estructura de la base
{
global datos "C:\Users\agust\Desktop\Universidad de Chile\Videos FENVID\Stata\Datos"
use "$datos/base_reshape", clear	

reshape wide variable_interes, i(var_ID) j(var_temporal)
reshape wide precio, i(Empresa) j(year)


reshape long variable_interes, i(var_ID) j(var_temporal)
reshape long precio, i(Empresa) j(year_nuevo)
}

*-Combinación y Condensasión de Bases de datos
{
global datos "C:\Users\agust\Desktop\Universidad de Chile\Videos FENVID\Stata\Datos"

merge 1:1 varid_1 varid_2... using nombre_archivo
merge m:1 varid_1 varid_2... using nombre_archivo
merge 1:m varid_1 varid_2... using nombre_archivo
merge m:m varid_1 varid_2... using nombre_archivo
h joinby
	
append using "nombre_archivo"


use "$datos/Collapse", clear
collapse (mean) edad (max) educacion (p50) ingreso, by (hogar)
tabstat edad educacion ingreso, stats(mean min max)


use "$datos/Collapse", clear
preserve
collapse (mean) edad (max) educacion (p50) ingreso, by (hogar)
tabstat edad educacion ingreso, stats(mean min max)
restore
}

*-Regresiones
{
global datos "C:\Users\agust\Desktop\Universidad de Chile\Videos FENVID\Stata\Datos"
global graficos "C:\Users\agust\Desktop\Universidad de Chile\Videos FENVID\Stata\Imágenes"
global tablas "C:\Users\agust\Desktop\Universidad de Chile\Videos FENVID\Stata\Tablas"

use "$datos/Casen 2017", clear

*Sintaxis y Exportación
regress var_dep regresores... [factor_expansión] if condicionales..., vce(opción_error_estándar) level(Nivel_confianza)

cd "$tablas"
outreg2 using nombre_archivo, formato_de_salida // txt tex word

*Variables Categóricas, Continuas e Interacciones
{
reg var_dep regresor_1 regresor_2... c.var_continua##c.var_continua [factor_expansión]
reg var_dep regresor_1 regresor_2... i.var_categorica [factor_expansión]
reg var_dep regresor_1 regresor_2... ibN°.var_categorica [factor_expansión]
reg var_dep regresor_1 regresor_2... i.var_categorica##c.var_continua [factor_expansión]
	
}

*Valores Predichos y Residuos
{
regresion
predict nueva_variable, xb // Si uno no pone ", xb" da lo mismo, el programa toma por defecto esta opción. 
predict nueva_variable, resid

}

*Margins
{
regresion
margins [factor_expansión], at(nombre_variable=(desde (delta) hasta) var_categorica=(N°_1 N°_2...))
marginsplot	
}

*Normalidad, Heterocedasticidad, Multicolinealidad, No linealidad omitida
{
sysuse auto, clear	
d 

regresion
jb variable    // Test de Jaque-Bera. Instalar jb ("ssc install jb")
sktest variable // Test de Skewness-Kurtosis
swilk variable // Test de Shapiro-Wilk

estat hettest // Test de Breusch-Pagan
imtest, white // Test de White

estat vif // Test de inflación de varianza
coldiag2 // Test de Belsey. Instalar coldiag2 ("ssc install coldiag2, replace")

estat ovtest // Test de Ramsey	
}

*Comparación de modelos
{
cd "$tablas"

regresión_1
estimates store nombre_1
regresión_2
estimates store nombre_2
...
estimates table nombre_1 nombre_2..., stats(rss r2 r2_a ll aic bic n) 

esttab nombre_1 nombre_2..., stats(rss r2 r2_a ll aic bic n, labels("R2" "R2_ajust" "log-likelihood" "Akaike" "Bayes" "Observaciones")) replace label coeflabels(variable_1 "texto_1" variable_2 "texto_2"...) title("texto_título") mtitles("modelo 1" "modelo 2"...) keep(variables_a_mostrar) 
}

*Variables Instrumentales (Próximamante)
{
*Ejemplo 13.1 del libro \Introductory Econometrics: A Modern Approach"	
use http://fmwww.bc.edu/ec-p/data/wooldridge/fertil1, clear	
reg kids educ c.age##c.age black east northcen west farm othrural town smcity i.year 

reg x z // Primera etapa
predict xgorro, xb
reg y xgorro w // Segunda etapa

ivregress 2sls var_dep var_exógenas... (var_endógena=instrumento) [factor_expansión] if condición_1 condición_2 ..., opción_primera_etapa

ivregress gmm var_dep var_exógenas... (var_endógena=instrumento) [factor_expansión] if condiciones..., opción_primera_etapa

estat firststage // Test Fortaleza de Instrumentos
estat overid	// Test sobreidentificación Instrumentos
estat endogenous // Test Endogeneidad
}

*Bootstrap (Próximamante)
{
bootstrap, reps(N°_repeticiones): reg var_dependiente regresores, opciones
estat bootstrap, all	
}
	

                             *Probit/Logit
*Modelos Binarios (Próximamante)
{
*Ejemplo 13.1 del libro \Introductory Econometrics: A Modern Approach"	
use http://fmwww.bc.edu/ec-p/data/wooldridge/fertil1, clear	

probit var_dependiente_binaria var_independientes if condicionales [factor_de_expansión] 
logit var_dependiente_binaria var_independientes if condicionales [factor_de_expansión] 

estat classification // Matriz de confusión
lsens
margins [factor_de_expansión], dydx(*) // Efecto Marginal Promedio
margins [factor_de_expansión], dydx(*) atmeans // Efecto Marginal en el Promedio
margins, dydx(*) at(var_1==N° var_2==N°...) // Efecto Marginal Persona Representativa
}


*Modelos Multinomiales (Próximamante)
{
oprobit var_dependiente_categórica var_independientes if condicionales [factor_de_expansión] 
ologit var_dependiente_categórica var_independientes if condicionales [factor_de_expansión] 	
}


                             *Cuantiles (Próximamante)
{
qreg var_dep regresores, quantile(.N°)
bsqreg var_dep regresores, quantile(.N°), reps(N°)
grqreg variable, ci				
}
				 
							 
}

*-Series de Tiempo (Próximamente)
{
clear all
use "C:\Users\agust\Desktop\Universidad de Chile\Videos FENVID\Stata\Datos\base_precios.dta"

tsset var_id var_temporal // Seteamos var que identifica observaciones y tiempo

tsline var1 var2...  // Gráfico temporal
reg variable L.variable // L. es el operador lag

g g_dolar=100*(ln(dolar)-ln(L.dolar)) 

arima variable, arima(N° AR,N° I,N° MA) 
arima variable, ar(N° AR_1 N° AR_2...) ma(N° MA_1 N° MA_2...) // A diferencia de antes, ahora podemos estimar con gaps para AR y MA

estat ic

dfuller variable, noconstant
dfuller variable, drift
dfuller variable, trend

ac variable, name(nombre_1, replace) lags(N°) xtitle(título_eje_x) title(título_gráfico) // Gráfico de autocorrelaciones (ACF)
pac variable, name(nombre_2, replace) lags(N°) xtitle(título_eje_x) title(título_gráfico) // Gráfico de autocorrelaciones parciales (PACF)
graph combine nombre_1 nombre_2

corrgram variable, lags(N°) // Vemos el correlograma de la variable. ()
wntestq variable, lags(N°) // Testeamos si la variable es ruido blanco


}

*-Programación (Próximamente)
{

*Simulaciones 
clear all 
set more off				  
definir matriz
Número de obs
crear y definir variable temporal

forvalues m=1(1)1000{
set seed `m'
generar variables necesarias
tirar la reg del ejercicio

matrix nombre[`m',1]=_b[_cons] * Coeficiente constante 
matrix nombre[`m',2]=_b[var ind] *Coeficiente variable ind

drop variables definidas dentro del forvalues 
}

svmat nombre matriz
grafico de parámetros	

global edad_min=18 // Macro de var global
global edad_max=40 // Macro de var global

local diferencia=`edad_max'-`edad_min' // Macro de var temporal
	
putexcel set nombre_base, sheet("nombre-hoja") modify // Seteamos excel a exportar 
putexcel A1=("hola") B2=matrix(a[`k',1])  C`diferencia'=matrix(obs) // Definimos dónde y qué queremos poner
	

*FGLS
regresion 
predict residuos_originales, resid

g nuevos_residuos=funcion(residuos_originales)

reg nuevos_residuos regresores 
predict valores_predichos, xb 

g pre_ponderador=exp(valores_predichos)
g ponderador=1/valores_predichos

regresion [w=ponderador]
	
	
*NLLS
nl (var_dependiente = {forma_funcional}), initial(_b[_cons] pto_partida _b[regresor_1] pto_partida _b[regresor_2] pto_partida...) // Por defecto el punto de partida es cero.

predict ygorro, xb 
scatter var_dependiente regresor || line ygorro regresor, sort

*Sesgo de Selección (Heckman)
probit var_categorica regresores, vce(opción_error_estándar)
predict variable_gorro, xb 
g mills=normalden(variable_gorro)/normal(variable_gorro)
reg var_dep regresores mills, vce(opción_error_estándar) //Método "Manual"

heckman var_dep regresores, select(var_primera_etapa regresores) two	
	
	
if 0<1 {
display("0 es menor que 1")}	
	
set obs número
set seed número 
set matsize número
mat define A = J(número_filas,número_columnas,Valores_matriz) 
mat list A 
mat A[1,1] = r(N) // Le estoy diciendo a Stata que rellene la fila uno columna con el N de la variable respectiva.
mat A[1,2] = r(mean) // Lo mismo con la media
mat A[1,3] = r(sd) // Lo mismo con la desviacion estandar.


matrix Beta=J(1000,2,0)
forval m=1(1)1000{
preserve
bsample
reg prom_gral asistencia
matrix Beta[`m',1]=_b[_cons]
matrix Beta[`m',2]=_b[asistencia]

restore 
}
svmat Beta 
}

log c // Cierra el archivo log que creamos. Este archivo registra todo lo mostrado en la consola cuando corremos los códigos. 

