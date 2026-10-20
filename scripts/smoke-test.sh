#!/usr/bin/env bash
# =============================================================================
# smoke-test.sh — ¿Está sano el proyecto? Rápido, sin red, no modifica nada.
# =============================================================================
#   Uso:  bash scripts/smoke-test.sh
#
# Corre en el host o dentro del devcontainer. Lo invoca el postCreateCommand al final
# (sin bloquear) y es parte del ritual de arranque (README_AGENTS §3).
#
# Salida: ✅ ok · ⚠️ aviso (no falla) · ❌ falla (exit 1).
# =============================================================================
set -uo pipefail
cd "$(dirname "$0")/.."

pass=0; warn=0; fail=0
ok() { echo "  ✅ $*"; pass=$((pass + 1)); }
wa() { echo "  ⚠️  $*"; warn=$((warn + 1)); }
ko() { echo "  ❌ $*"; fail=$((fail + 1)); }

# Intérprete: el .venv del proyecto si existe (dentro del contenedor tras uv sync).
PY=""
for c in .venv/bin/python python3 python; do
  command -v "$c" >/dev/null 2>&1 && { PY="$c"; break; }
done

echo "▶ smoke-test — $(basename "$PWD")"

# --- 1. Configuración ----------------------------------------------------------
echo "· Configuración"
if grep -qE '"name": *"clearnote' .devcontainer/devcontainer.json 2>/dev/null; then
  wa "devcontainer.json trae un nombre fijo de plantilla (debería tomar el de la carpeta)"
fi
case "$(basename "$PWD")" in
  *" "*) wa "la carpeta tiene espacios: Docker no podrá nombrar el contenedor (usa _ o -)" ;;
  *) ok "nombre de carpeta válido para el contenedor" ;;
esac

# --- 2. Sintaxis ----------------------------------------------------------------
echo "· Sintaxis"
bad=0
for f in scripts/*.sh; do
  [ -f "$f" ] || continue
  bash -n "$f" 2>/dev/null || { ko "bash: $f"; bad=1; }
done
[ "$bad" = 0 ] && ok "scripts bash"

if [ -n "$PY" ]; then
  # ast.parse no escribe __pycache__ (py_compile sí).
  if out="$(find src scripts notebooks -name '*.py' -print0 2>/dev/null | xargs -0 "$PY" -c '
import ast, sys
for f in sys.argv[1:]:
    try:
        ast.parse(open(f, encoding="utf-8").read(), f)
    except SyntaxError as e:
        print(f"{f}:{e.lineno}: {e.msg}")
' 2>&1)" && [ -z "$out" ]; then
    ok "código Python"
  else
    ko "Python con errores de sintaxis:"; echo "$out" | sed 's/^/       /'
  fi
else
  wa "sin intérprete Python → se omite la sintaxis"
fi

# --- 3. Dependencias + src/utils ---------------------------------------------
# Corre las utilidades REALES sobre un DataFrame mínimo y verifica que no modifiquen
# el original. Sin las dependencias instaladas (¿aún sin uv sync?) solo avisa.
echo "· Dependencias y src/utils"
if [ -n "$PY" ] && "$PY" -c "import pandas" 2>/dev/null; then
  if missing="$("$PY" -c '
import importlib.util
print(" ".join(m for m in ("numpy", "openpyxl", "pyarrow") if importlib.util.find_spec(m) is None))
' 2>&1)" && [ -z "$missing" ]; then
    ok "pandas, numpy, openpyxl, pyarrow"
  else
    ko "faltan dependencias: $missing"
  fi

  if out="$(PYTHONDONTWRITEBYTECODE=1 "$PY" - <<'PY' 2>&1
import contextlib, io, os, sys
sys.path.insert(0, os.getcwd())
import pandas as pd
from src.utils.clean_whitespace import limpiar_espacios_en_blanco
from src.utils.format_variables import format_dates, format_int
from src.utils.index_management import consolidar_ids_unicos

raw = pd.DataFrame({"  Col   A ": ["  x   y ", "", "z"], "n": [1.0, 2.0, None], "f": ["2026-01-05 13:00", None, "2026-02-01 08:30"]})
snapshot = raw.copy()
df = limpiar_espacios_en_blanco(raw)
assert list(df.columns)[0] == "Col A", f"columna: {list(df.columns)}"
assert df["Col A"].tolist()[0] == "x y", f"celda: {df['Col A'].tolist()}"
assert len(df) == 3 and pd.isna(df["Col A"].iloc[1]), "'' debe quedar NaN sin borrar la fila (n tiene dato)"
assert len(limpiar_espacios_en_blanco(pd.DataFrame({"a": ["  "]}))) == 0, "una fila solo con espacios debe eliminarse"

fechas = format_dates(df, ["f"])
out = format_int(fechas, ["n"])
assert str(out["n"].dtype) == "Int64", f"n: {out['n'].dtype}"
assert out["f"].iloc[0] == pd.Timestamp("2026-01-05"), f"f: {out['f'].iloc[0]}"
intacto = df["f"].iloc[0] == "2026-01-05 13:00" and str(fechas["n"].dtype) == "float64" and raw.equals(snapshot)
assert intacto, "una utilidad modificó el DataFrame que recibió"

with contextlib.redirect_stdout(io.StringIO()):
    ids = consolidar_ids_unicos([pd.DataFrame({"ID": [3, 1]}), pd.DataFrame({"ID": [1, 2, None]})], return_as="list")
assert ids == [1, 2, 3], f"ids: {ids}"
PY
  )"; then
    ok "src/utils: limpieza, fechas, Int64 e IDs (sin tocar el original)"
  else
    ko "src/utils roto:"; echo "$out" | tail -1 | sed 's/^/       /'
  fi
else
  wa "pandas no disponible (¿aún sin uv sync?) → se omiten dependencias y src/utils"
fi

# --- Resumen ----------------------------------------------------------------
echo "▶ $pass ok · $warn avisos · $fail fallas"
[ "$fail" -eq 0 ]
