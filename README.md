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




# 📌 Resumen

El Sprint #1 estableció una base sólida de ingeniería de datos, asegurando que cualquier análisis posterior se realice sobre datos confiables, interpretables y bien modelados.
La arquitectura diseñada permite escalar el proyecto hacia análisis avanzados y soporta decisiones reales de scouting deportivo basadas en datos.

# 📊 Sprint #2 – Análisis Exploratorio (EDA)
Relación entre Perfil Físico y Rendimiento Competitivo en NBA

# 1️⃣ Objetivo del Análisis

El propósito del Sprint #2 fue explorar si las métricas físicas obtenidas en el Draft Combine guardan relación con el rendimiento profesional posterior.

La pregunta central fue:

¿El perfil físico promedio de un equipo influye en su desempeño competitivo?

Para responderla, construimos un dataset agregado por equipo que combinó métricas físicas promedio del roster con métricas de rendimiento promedio.

# 2️⃣ Métricas Analizadas
🔹 Variables físicas promedio por equipo:

Envergadura (Wingspan)

Salto vertical máximo

Tiempo de agilidad (Lane Agility)

Altura promedio

Peso promedio

Estas métricas representan dimensiones estructurales (tamaño), potencia (explosividad) y movilidad (velocidad lateral).

🔹 Variables de rendimiento:

Puntos promedio

Tapones promedio

Robos promedio

Plus/Minus promedio

Estas métricas representan impacto ofensivo, impacto defensivo y diferencial competitivo.

# 3️⃣ Comparaciones Realizadas y Justificación

Se realizaron comparaciones específicas con una lógica conceptual:

📌 Envergadura vs Tapones

Hipótesis: mayor alcance debería facilitar protección del aro.
<img width="613" height="470" alt="image" src="https://github.com/user-attachments/assets/a631dd06-be7f-4c33-ae20-9bd856acf833" />


📌 Agilidad vs Robos

Hipótesis: mayor movilidad lateral debería favorecer recuperación defensiva.
<img width="614" height="470" alt="image" src="https://github.com/user-attachments/assets/9d7a3a09-8bcc-4db9-b7bc-3783f8ea4b58" />


📌 Salto Vertical vs Plus/Minus

Hipótesis: mayor explosividad debería generar mayor impacto competitivo.
<img width="612" height="470" alt="image" src="https://github.com/user-attachments/assets/2b246cd4-1fa3-4324-a907-34a7852da8fa" />

📌 Altura vs Puntos

Hipótesis: equipos más altos podrían dominar el juego interior.
<img width="618" height="470" alt="image" src="https://github.com/user-attachments/assets/be7719b8-db14-4137-9392-7f23e154e44d" />

📌 Índice Físico Global vs Plus/Minus

Hipótesis: un mejor perfil físico agregado debería reflejarse en mejor desempeño colectivo.
<img width="612" height="470" alt="image" src="https://github.com/user-attachments/assets/faab30a0-58f5-41a5-938f-d8b59f982024" />


Además, se analizaron relaciones individuales por posición para validar coherencia estructural del dataset.

# 4️⃣ Hallazgos Principales
🔎 1. Coherencia Interna del Perfil Físico

Las métricas físicas mostraron alta correlación entre sí:

Altura ↔ Envergadura

Altura ↔ Peso

Peso ↔ Envergadura

Esto confirma consistencia estructural del dataset y valida la calidad de los datos.

🔎 2. Envergadura no predice Tapones a nivel equipo

La relación entre wingspan promedio y bloqueos fue prácticamente nula.

Esto sugiere que la defensa del aro depende más de:

Sistema defensivo

Posicionamiento

Timing

Rol táctico

Y no del tamaño promedio del roster.

🔎 3. Agilidad no explica generación de robos

La comparación entre tiempo de agilidad y robos mostró una tendencia muy débil.

Esto indica que la defensa perimetral efectiva no depende exclusivamente de la movilidad física promedio.

🔎 4. Explosividad tiene impacto limitado

El salto vertical mostró apenas una leve relación positiva con plus/minus, pero con alta dispersión.

La explosividad promedio no garantiza impacto competitivo.

🔎 5. Altura promedio no mejora producción ofensiva

Se observó incluso una leve tendencia negativa entre altura promedio y puntos.

Esto sugiere que el juego moderno prioriza:

Espaciado

Tiro exterior

Velocidad

Versatilidad

Por encima del tamaño estructural.

🔎 6. Índice Físico Global vs Impacto Competitivo

Al combinar todas las métricas físicas en un índice agregado, la relación con plus/minus fue prácticamente plana.

Conclusión:

El perfil físico promedio de un equipo no emerge como predictor significativo del rendimiento colectivo.

# 5️⃣ Análisis Individual por Posición

A nivel individual sí se observaron patrones coherentes:

Centers más altos y pesados.

Guards más explosivos.

Relación fuerte entre altura y envergadura.

Relación positiva entre peso y fuerza (bench press).

Ausencia de relación clara entre altura y salto vertical.

Esto confirma que el dataset captura correctamente la estructura física por rol, aunque esa estructura no se traduce linealmente en éxito colectivo.

# 6️⃣ Insight General del Sprint

El análisis revela que:

Las métricas físicas son coherentes estructuralmente.

No existe correlación fuerte entre perfil físico promedio y rendimiento de equipo.

El éxito competitivo está más asociado a métricas de juego que a atributos físicos agregados.

El impacto físico parece diluirse cuando se analiza a nivel colectivo.

# 7️⃣ Conclusión Estratégica

El talento físico individual es necesario para competir, pero no suficiente para explicar el éxito colectivo.

El rendimiento parece depender más de:

Sistema táctico

Eficiencia ofensiva

Dinámica defensiva

Sinergia de equipo

📊 Visualización y Dashboard (Power BI)
Esta sección del proyecto traduce los hallazgos de Python a una herramienta interactiva de toma de decisiones para scouting y análisis de tendencias.

1. Evolución del Juego: El Giro hacia la Explosividad


Métricas: Max Vertical Leap vs. to_year (2018-2023).

Análisis: El gráfico muestra una tendencia ascendente en la sumatoria del salto vertical en el último lustro.

Insight: Esta pendiente positiva valida la transición de la NBA hacia un modelo de juego basado en la versatilidad atlética y la velocidad de transición, priorizando jugadores capaces de cubrir más terreno en menos tiempo.

2. Anatomía del Atleta: Biometría y Correlación


Métricas: Height w/ Shoes (Altura) vs. Weight (Peso).

Análisis de Posición: Al filtrar por la posición de Center, se observa un desplazamiento hacia perfiles más estilizados (menor peso relativo).

Insight: Los datos confirman el fin del "pívot pesado" tradicional. El scouting moderno busca un índice de masa corporal (IMC) más eficiente que permita defender múltiples posiciones sin perder la ventaja de la altura.

3. Correlación de Envergadura (Wingspan vs. Standing Reach)


Métricas: Wingspan vs. Standing Reach.

Análisis: Existe una correlación lineal casi perfecta (R2 ≈1). Al segmentar por posiciones, los Centers se agrupan en los extremos de la diagonal.

Insight: Esta visualización permite identificar a los "Unicornios": jugadores que se salen de la norma estadística por tener una envergadura desproporcionada para su altura, factor clave para la protección del aro.

## 👥 Equipo
- Candela Paula Antognoli - Data Analyst
- Faber Garcia - Data Analyst
- Mauricio Veira Martinez - Data Analyst
- Manuel Arce- Data Analyst
