# Selección del proyecto — scrapy

- **Nombre y descripción:** scrapy — framework de Python para extraer datos
  de sitios web (web scraping) de forma escalable y asíncrona.
- **URL:** https://github.com/scrapy/scrapy
- **Licencia:** BSD
- **Lenguaje principal:** Python
- **Commit analizado:** 53eb8d6... (completa con tu hash completo de `git rev-parse HEAD`)
- **Métricas:** 172 archivos, 21 232 líneas de código
- **Comando utilizado:** `cloc scrapy/`
- **Por qué es apropiado para Sphinx:** paquete estructurado en submódulos
  claros (`spiders`, `http`, `selector`, `pipelines`, etc.), con docstrings
  en varios estilos que se benefician de `napoleon`.
- **Presencia y calidad de docstrings existentes:** variable según el
  módulo — las clases principales (`Spider`, `Request`, `Response`) tienen
  docstrings razonablemente completos; módulos internos de `core/` tienen
  menos documentación.
- **Dependencias/dificultades previstas:** dependencias pesadas (Twisted,
  lxml, cryptography) que requieren instalación real en un entorno virtual
  para que `autodoc` pueda importar los módulos correctamente; se optó por
  instalar el paquete real en vez de usar `autodoc_mock_imports`.