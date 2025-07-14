# 🐍 Plantilla Dev Container para Ciencia de Datos en Python — ClearNote Py DA

Bienvenido a la plantilla oficial **ClearNote Py DA**, un entorno ligero, reproducible y altamente portable para desarrollo en Python dentro de contenedores usando Visual Studio Code + Docker.

---

## 🎯 Propósito

Esta plantilla está diseñada para:

- Ejecutar proyectos de ciencia de datos **sin instalar nada en tu sistema anfitrión**
- Usar `.py` y `.ipynb` de forma interactiva con **Jupyter Interactive Window**
- Integrar herramientas modernas de desarrollo: formateadores, linters y depuradores
- Trabajar en carpetas sincronizadas (como OneDrive) sin conflictos de permisos

---

## 🧱 Estructura del contenedor

- **Imagen base**: `python:3.13.2-slim-bookworm`
- **Kernel interactivo**: `ipykernel` incluido
- **Gestor de paquetes**: `pip`, configurado para instalar automáticamente desde `requirements.txt`
- **Usuario por defecto**: `root`, para evitar errores de permisos en carpetas compartidas
- **Extensiones VS Code**: preconfiguradas para Python, Jupyter, Copilot, Black, etc.

---

## ⚙️ Instrucciones de uso
### 1. Clona este repositorio
```bash
cd tu_ruta/

git clone https://github.com/tu_usuario/ClearNote_Py_DA.git

cd ClearNote_Py_DA

```
### 2. Desvincula el repositorio original (opcional)
Este paso elimina la conexión con el repositorio de origen en GitHub, para que puedas comenzar un proyecto independiente desde cero:

```bash
rm -rf .git
git init
git add .
git commit -m "Proyecto inicial basado en plantilla ClearNote Py DA"
```

- 💡 Luego puedes conectar tu propio repositorio con:

```bash
git remote add origin https://github.com/tu_usuario/tu_repositorio.git
git push -u origin main
```

### 3. Abre la carpeta en Visual Studio Code

Selecciona Reopen in Container cuando se detecte automáticamente el Dev Container.

### 4. Instala dependencias

Después de crear el contenedor, se ejecutará automáticamente:

```bash
pip install -r requirements.txt
```

Puedes personalizar este archivo para incluir tus propias librerías.

---

## 🧪 ¿Qué puedes hacer aquí?
| Tarea                           | Disponible ✅                      |
| ------------------------------- | --------------------------------- |
| Ejecutar scripts `.py`          | ✅                                 |
| Usar `shift + enter` en código  | ✅ (modo interactivo sin notebook) |
| Ejecutar notebooks `.ipynb`     | ✅                                 |
| Formato automático con Black    | ✅                                 |
| Depurar scripts con breakpoints | ✅                                 |
| Correr análisis reproducibles   | ✅                                 |
| Usar Git y control de versiones | ✅                                 |

---

## 🔍 Recomendaciones adicionales

- Para interacción con .py en modo notebook, asegúrate de instalar ipykernel (ya lo incluye esta imagen).

- Configuración útil incluida:

```json
"jupyter.interactiveWindow.textEditor.executeSelection": true
```

- Para evitar errores de interfaz en Linux:

```json
"remote.containers.mountWaylandSocket": false
```

---

## ⚖️ Licencia
Distribuido bajo la licencia [MIT](https://opensource.org/license/MIT). Puedes copiar, modificar y reutilizar libremente esta plantilla.

---

**MSc. Nicolás Enrique Valencia Santiago**

# README Modificable:
Vale la pena aclarar que el contenido de este README.md debe de ser modificado para adaptarse al proyecto para el que se quiera usar.