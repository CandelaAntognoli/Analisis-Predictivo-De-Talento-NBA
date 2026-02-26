# 🏀 Analisis Predictivo de Talento NBA
<img width="1024" height="1024" alt="NBA" src="https://github.com/user-attachments/assets/f03a3e33-3678-42a9-8b86-ddc6481043fc" />

# 📌 Contexto del proyecto

El baloncesto profesional (NBA) utiliza métricas físicas obtenidas en el Draft Combine para evaluar el potencial de nuevos jugadores antes de invertir millones de dólares en contratos. Sin embargo, existe una alta incertidumbre sobre si estas métricas físicas (salto, velocidad, agilidad, envergadura) realmente predicen el rendimiento profesional real en cancha.
Este proyecto busca reducir el riesgo de draft busts mediante un enfoque de Data Analytics y Data Science, integrando datos físicos pre-draft con estadísticas históricas de juego.



# 🎯  Objetivo general

Analizar la relación entre las métricas físicas del Draft Combine y el rendimiento real en la NBA, construyendo una base analítica sólida que permita:

Identificar perfiles físicos con mayor probabilidad de éxito.

Comparar el impacto físico según posición.

Servir como base para análisis estadístico, modelos predictivos y dashboards.


#  🧱 Alcance del Sprint #1

Durante este primer sprint se trabajó exclusivamente en la ingeniería de datos y modelado, dejando preparada la infraestructura para los análisis posteriores.

Las tareas realizadas fueron:

Exploración, limpieza y normalización de datos en Python.

Diseño del modelo dimensional (esquema estrella).

Creación de un Data Warehouse en SQL Server.

Preparación de datos listos para análisis y visualización.

#  Diagrama estructura de datos

<img width="1536" height="1024" alt="Arquitectura NBA" src="https://github.com/user-attachments/assets/c2a12fba-9b12-4991-aa1d-de87b44d9e87" />


#  📊 Datos utilizados

Se trabajó con el dataset NBA Database (Kaggle), compuesto por:

Base SQLite histórica (desde 1946).

Tablas clave:

common_player_info → información biográfica y de carrera.

draft_combine_stats → métricas físicas pre-draft.

game y other_stats → estadísticas de partidos a nivel equipo.



# 🧹 Limpieza y normalización de datos (Python)

La limpieza y transformación se realizó íntegramente en Python (Pandas + NumPy), antes de cualquier carga a SQL, siguiendo buenas prácticas de ETL.

Principales decisiones técnicas:

Normalización de unidades:

Altura: de formato texto (pies-pulgadas) a centímetros.

Peso: de libras a kilogramos.

Conversión de tipos:

Métricas físicas y estadísticas convertidas a tipos numéricos.

Gestión de nulos:

No se imputaron valores físicos faltantes para evitar sesgos.

Se filtraron registros inválidos solo cuando afectaban claves analíticas.

Estandarización semántica:

Normalización de nombres, posiciones y claves de jugadores/equipos.

Eliminación de duplicados:

Garantizando unicidad por identificadores naturales (person_id, team_id, game_id).

Este enfoque asegura calidad analítica, trazabilidad y reproducibilidad.





# ⭐ Diseño del modelo dimensional (Esquema Estrella)

Se diseñó un modelo estrella orientado a análisis, priorizando simplicidad, escalabilidad y claridad semántica.

¿Por qué dos tablas de hechos?

El proyecto aborda dos fenómenos distintos pero relacionados:

Rendimiento físico pre-draft

Rendimiento deportivo real en partidos

Forzar ambos conceptos en una única tabla hubiese generado:

Gran cantidad de nulos.

Ambigüedad en el grano de análisis.

Dificultad para interpretar resultados.

Por ello, se optó por dos tablas de hechos.

# 🟦 Tablas de hechos FACT_COMBINE

Grano: Jugador – Temporada

Contiene:

Salto vertical

Envergadura

Agilidad

Velocidad

Fuerza

Representa el potencial físico medido antes del ingreso a la NBA.

# FACT_GAME

Grano: Partido

Métricas a nivel equipo (home / away):

Puntos

Asistencias

Pérdidas

Robos

Tapones

Plus/Minus

Representa el impacto real en cancha.

#  🟩 Tablas de dimensiones

DIM_PLAYER: datos biográficos y físicos normalizados del jugador.

DIM_TEAM: información de franquicias NBA.

DIM_DATE: dimensión temporal para análisis históricos.

MAP_PLAYER_TEAM (tabla puente):

Resuelve la relación muchos-a-muchos entre jugadores y equipos.

Mantiene la integridad histórica (from_year / to_year).

![Diagrama Entidad Relacion drawio (2)_page-0001](https://github.com/user-attachments/assets/831598ae-1d4d-4635-af84-ac1f3f5c1045)

# 🗄️ Data Warehouse en SQL Server

Se implementó un Data Warehouse en SQL Server con el objetivo de:

Centralizar datos limpios y normalizados.

Facilitar consultas analíticas complejas.

Servir como fuente confiable para Power BI y análisis estadístico.

Decisiones clave:

Uso de claves surrogate en dimensiones.

Separación clara entre staging (Python) y almacenamiento analítico (SQL).

Diseño optimizado para joins, filtros y agregaciones.

SQL Server se utilizó exclusivamente como capa de almacenamiento analítico, evitando lógica de limpieza dentro de la base.


# 🛠️ Tecnologías utilizadas

Python: Pandas, NumPy, SQLite3

Google Colab: ejecución colaborativa y ETL

Google Drive: versionado y compartición de datos limpios

SQL Server: Data Warehouse

GitHub: control de versiones y documentación
<img width="1024" height="1024" alt="tecnologias" src="https://github.com/user-attachments/assets/adbcc56f-0848-4d44-8114-348be2dc7dda" />




# 📌 Conclusión

El Sprint #1 estableció una base sólida de ingeniería de datos, asegurando que cualquier análisis posterior se realice sobre datos confiables, interpretables y bien modelados.
La arquitectura diseñada permite escalar el proyecto hacia análisis avanzados y soporta decisiones reales de scouting deportivo basadas en datos.

# SPRINT #2

# 1️⃣ Contexto General del Proyecto (Sprint 1)

El proyecto tiene como objetivo analizar si las aptitudes físicas medidas en el NBA Draft Combine pueden anticipar el rendimiento profesional posterior de los jugadores.

Durante el Sprint 1 se trabajó en la base estructural del proyecto:

Limpieza y normalización de datos en Python.

Estandarización de tipos de datos.

Conversión de unidades (altura, peso).

Eliminación de inconsistencias y registros incompletos.

Diseño del modelo relacional en esquema estrella.

Creación de la base de datos en SQL Server (NBA_DW).

Implementación de dos tablas de hechos:

FACT_COMBINE (métricas físicas)

FACT_GAME (rendimiento profesional)

Construcción de dimensiones:

DIM_PLAYER

DIM_TEAM

DIM_DATE

El objetivo fue separar claramente métricas físicas pre-NBA de métricas de desempeño profesional, permitiendo análisis comparativos estructurados.

# 2️⃣ Construcción del Dataset Analítico 

En el segundo sprint se trabajó en Google Colab directamente sobre el archivo nba.sqlite.

Se integraron las siguientes tablas:

draft_combine_stats

common_player_info

game

team

Se realizaron:

Conversión de altura a centímetros.

Conversión de peso a kilogramos.

Unificación de claves.

Limpieza de tipos numéricos.

Eliminación de inconsistencias estructurales.

Se construyó un dataset agregado a nivel equipo histórico, promediando:

Variables físicas promedio:

Envergadura

Salto vertical

Agilidad

Altura

Peso

Variables de rendimiento promedio:

Puntos

Tapones

Robos

Plus/Minus

El dataset final quedó compuesto por:

30 equipos × 10 métricas agregadas

# 3️⃣ Análisis Exploratorio de Datos (EDA)

Se aplicaron:

Estadística descriptiva

Matriz de correlación de Pearson

Heatmaps

Gráficos de dispersión con regresión

Análisis individual por posición

# 4️⃣ Insights Principales 
🔹 1. Coherencia Física Interna

Las variables físicas (altura, peso, envergadura) presentan fuerte correlación entre sí, validando consistencia estructural del dataset.

🔹 2. Bajo Impacto del Físico Promedio en el Rendimiento Colectivo

No se encontraron correlaciones significativas entre el perfil físico promedio del equipo y su desempeño competitivo (puntos, tapones, diferencial). El físico agregado pierde poder explicativo.

🔹 3. El Rendimiento Depende Más del Juego que del Tamaño

Las métricas de rendimiento están más correlacionadas entre sí (puntos ↔ plus/minus ↔ robos) que con variables físicas.

🔹 4. Diferencias Físicas Claras por Posición

A nivel individual se observan patrones coherentes:

Centers más altos y pesados.

Guards más explosivos.

Relación fuerte entre altura y envergadura.

Relación positiva entre peso y fuerza.

No existe relación clara entre altura y salto vertical.

🔹 5. El Talento Físico No Garantiza Impacto Competitivo

Incluso un índice físico agregado mostró correlación prácticamente nula con el plus/minus promedio del equipo.

# 5️⃣  Conclusión General del Sprint #2

El análisis sugiere que:

Las métricas físicas individuales son coherentes y estructuralmente válidas, pero no emergen como predictores determinantes del éxito colectivo cuando se analizan a nivel equipo agregado.

El rendimiento competitivo parece depender más de:

Producción ofensiva

Dinámica táctica

Eficiencia de juego

Interacción colectiva

## 👥 Equipo
- Candela Paula Antognoli - Data Analyst
- Faber Garcia - Data Analyst
- Mauricio Veira Martinez - Data Analyst
- Manuel Arce- Data Analyst
