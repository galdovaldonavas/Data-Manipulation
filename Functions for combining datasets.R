# Crear dataframes de ejemplo
df1 <- data.frame(
  ID = c(1, 2, 3, 4),
  Nombre = c("Ana", "Pedro", "Luisa", "Carlos"),
  Edad = c(25, 30, 22, 35)
)

df2 <- data.frame(
  ID = c(1, 2, 5, 6),
  Ciudad = c("Madrid", "Barcelona", "Sevilla", "Valencia"),
  Ocupacion = c("Ingeniera", "Doctor", "Diseñador", "Profesor")
)

print(df1)
print(df2)

# Por defecto, merge() realiza un inner join si 'all' no se especifica
# Y si las columnas con el mismo nombre se usan para la unión
inner_df <- merge(df1, df2)
print(inner_df)

# O especificar explícitamente:
inner_df_explicit <- merge(df1, df2, by = "ID")
print(inner_df_explicit)


left_df <- merge(df1, df2, by = "ID", all.x = TRUE)
print(left_df)

right_df <- merge(df1, df2, by = "ID", all.y = TRUE)
print(right_df)

full_df <- merge(df1, df2, by = "ID", all = TRUE)
print(full_df)

# CON LAS FUNCIONES DE DEPLYR

library(dplyr)



# --- Dataframes de Ejemplo ---
# df1: Información de usuarios
df_usuarios <- data.frame(
  ID_Usuario = c(1, 2, 3, 4, 5),
  Nombre = c("Ana", "Pedro", "Luisa", "Carlos", "Marta"),
  Edad = c(25, 30, 22, 35, 28)
)

# df2: Información de compras (algunos usuarios de df1, algunos nuevos)
df_compras <- data.frame(
  ID_Usuario = c(1, 2, 6, 7), # ID 1 y 2 coinciden con df_usuarios, 6 y 7 son nuevos
  Producto = c("Laptop", "Monitor", "Teclado", "Ratón"),
  Precio = c(1200, 300, 75, 40)
)

# df3: Información de actividad web (algunos usuarios de df1, algunos nuevos)
df_actividad <- data.frame(
  ID_Usuario = c(1, 3, 8, 9), # ID 1 y 3 coinciden con df_usuarios, 8 y 9 son nuevos
  Visitas = c(10, 5, 12, 7),
  Ultima_Sesion = as.Date(c("2025-07-01", "2025-06-25", "2025-07-02", "2025-06-28"))
)


print(df_usuarios)

print(df_compras)

print(df_actividad)


# Ejemplo: Usuarios que han hecho compras
inner_resultado <- df_usuarios %>%
  inner_join(df_compras, by = "ID_Usuario")
inner_resultado
# Resultado: Solo ID 1 y 2 porque son los únicos que están en df_usuarios Y df_compras.



# Ejemplo: Todos los usuarios y, si aplica, sus compras
left_resultado_compras <- df_usuarios %>%
  left_join(df_compras, by = "ID_Usuario")
left_resultado_compras
# Resultado: Todos los usuarios de df_usuarios (1,2,3,4,5).
# Los IDs 3,4,5 tendrán NA en 'Producto' y 'Precio' porque no están en df_compras.




# Ejemplo: Todas las compras y, si aplica, los datos del usuario
right_resultado <- df_usuarios %>%
  right_join(df_compras, by = "ID_Usuario")
right_resultado
# Resultado: Todas las compras de df_compras (ID 1,2,6,7).
# Los IDs 6 y 7 tendrán NA en 'Nombre' y 'Edad' porque no están en df_usuarios.





# Ejemplo: Todos los usuarios y todas las compras
full_resultado <- df_usuarios %>%
  full_join(df_compras, by = "ID_Usuario")
full_resultado
# Resultado: Incluye todos los IDs únicos de ambos (1,2,3,4,5,6,7).
# Los NAs aparecerán donde no hay información en el otro dataframe.




# Unir df_usuarios con df_compras, y luego el resultado con df_actividad
todos_los_datos_df1 <- df_usuarios %>%
  left_join(df_compras, by = "ID_Usuario") %>% # Primero unimos usuarios con compras
  left_join(df_actividad, by = "ID_Usuario")   # Luego unimos el resultado con actividad

todos_los_datos_df1
# Observa cómo se van añadiendo las columnas y los NAs aparecen donde no hay coincidencias.



# Todos los datos disponibles

todos_datos <- df_usuarios %>% 
  full_join(df_compras, by="ID_Usuario") %>% full_join(df_actividad, by ="ID_Usuario")
todos_datos


#Unir filas

rows1_2<-bind_rows(df_usuarios, df_compras)
rows1_2


#Unir columnas
#only when I have the same number of lines, and the order of the lines correspond. Otherwise we will get an error. 

# Dataframe de métricas de usuario 1
df_metricas1 <- data.frame(
  Visitas_Web = c(10, 15, 8),
  Tiempo_Sesion = c(30, 45, 20)
)

# Dataframe de métricas de usuario 2
df_metricas2 <- data.frame(
  NPS_Score = c(9, 7, 8),
  Tasa_Conversion = c(0.05, 0.08, 0.03)
)

# CUIDADO: Estas uniones solo funcionan si sabes que las filas corresponden.
# NO hay "coincidencia" de ID aquí, solo se pegan en el orden existente.
metricas_combinadas <- bind_cols(df_metricas1, df_metricas2)
print("\n--- bind_cols (combina columnas): ---")
print(metricas_combinadas)

# Si los dataframes no tienen el mismo número de filas:
# df_metricas3 <- data.frame(Puntuacion = c(1, 2))
# bind_cols(df_metricas1, df_metricas3) # Esto daría un error
