# 📖 Diccionario de datos

> Describe **qué significa cada variable** de los datos del proyecto: nombre, tipo, significado, dominio y origen.
> Se organiza **un bloque por dataset** (archivo o tabla) y se llena a medida que se incorporan datos.
>
> **Cómo se usa:** por cada dataset, una breve descripción + una tabla de variables. Copia la plantilla del
> final para agregar un dataset nuevo. Los tipos se escriben en lenguaje llano (`entero`, `decimal`,
> `texto`, `fecha`, `booleano`, `categórico`), no en el tipo interno de pandas.

---

## `<nombre_del_dataset>` — `data/other/<archivo>`

_Breve descripción: qué representa cada fila, período que cubre, granularidad y fuente del dato._

| Variable | Tipo | Descripción | Dominio / valores | Fuente |
|---|---|---|---|---|
| `id` | entero | Identificador único del registro | `> 0`, único | — |
| `fecha` | fecha (`YYYY-MM-DD`) | Fecha del evento | — | — |
| `categoria` | categórico | Clasificación del registro | `A`, `B`, `C` | — |
| `monto` | decimal | Valor monetario asociado | `>= 0` (COP) | — |
| `activo` | booleano | Si el registro está vigente | `true` / `false` | — |

> _Las filas de arriba son un ejemplo ilustrativo. Reemplázalas por las variables reales del dataset._

---

<!-- ─────────────────────────────────────────────────────────────────────────────
PLANTILLA PARA UN NUEVO DATASET (copia este bloque y quítale el comentario)

## `<nombre_del_dataset>` — `ruta/al/archivo`

_Breve descripción del dataset._

| Variable | Tipo | Descripción | Dominio / valores | Fuente |
|---|---|---|---|---|
| `<variable>` | <tipo> | <qué es> | <valores posibles> | <origen> |

───────────────────────────────────────────────────────────────────────────── -->
