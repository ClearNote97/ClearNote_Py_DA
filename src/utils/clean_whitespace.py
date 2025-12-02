"""
Módulo para limpieza de espacios en blanco en DataFrames.
Primer paso del flujo de procesamiento de datos.
"""

"""
Limpieza de espacios en blanco en DataFrames.
"""
import numpy as np
import pandas as pd


# # Limpieza de espacios en blanco en columnas y valores del DataFrame
def limpiar_espacios_en_blanco(df):
    df = df.copy()  # Crear una copia para no modificar el original directamente

    # Limpiar espacios en blanco en los nombres de las columnas
    df.columns = [
        col.strip() if isinstance(col, str) else "" if col is None else col
        for col in df.columns
    ]

    try:
        # Intentar eliminar espacios al inicio y final usando expresión regular en nombres de columnas
        df.columns = [
            col.replace(r"^\s+|\s+$", "", regex=True) if isinstance(col, str) else col
            for col in df.columns
        ]
    except TypeError:
        # En caso de que alguna columna no soporte replace con regex, se ignora el error
        pass

    # Eliminar espacios al inicio y final en todos los valores del DataFrame (celdas)
    df = df.replace(r"^\s+|\s+$", "", regex=True)

    # Reemplazar múltiples espacios internos por un solo espacio
    df = df.replace(r"\s+", " ", regex=True)

    # Reemplazar cadenas vacías por NaN para facilitar manejo de datos faltantes
    df = df.replace("", np.nan)

    # Eliminar filas que estén completamente vacías (todos los valores NaN)
    df = df.dropna(how="all")

    return df