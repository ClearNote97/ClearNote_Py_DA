# `data/` — datos del proyecto

Raíz de los insumos de datos del análisis.

- **`other/`** → los **archivos de datos en formatos no-SQL** (`.csv`, `.parquet`, `.xlsx`, `.json`, …): los microdatos de entrada.
- En proyectos **SQL**, aquí aparece además `sql/` con las consultas `.sql` (de ahí el nombre "other" para lo no-SQL).
- El **diccionario de datos** no vive aquí, sino en `docs/`.

> **Una carga verde no es una carga buena.** Después de leer cada archivo, valida **conteos y
> cobertura** (filas esperadas, columnas con datos, rango de fechas): un `.xlsx` que entra con 0 filas o
> con columnas vacías "sin error" es una bandera roja (hoja equivocada, encabezado corrido, formato
> nuevo del proveedor), y un `try/except` que no explota no prueba nada. Antes de dar una fuente por
> lista, haz un **piloto con datos reales**, no solo con ejemplos de juguete.
