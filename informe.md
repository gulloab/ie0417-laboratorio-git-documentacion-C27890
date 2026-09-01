# Informe del Laboratorio

## 1. Análisis de la documentación Doxygen (nlohmann/json)

### Página principal y navegación
La portada muestra el README del proyecto (vía `USE_MDFILE_AS_MAINPAGE`).
La navegación lateral usa árbol expandible (`GENERATE_TREEVIEW`) con
secciones: Main Page, Related Pages, Namespaces, Classes, Files.

### Información generada
Para clases y estructuras: firmas completas, jerarquía de plantillas,
miembros con su tipo. Para namespaces: `nlohmann` (API pública) y
`nlohmann::detail` (implementación interna) aparecen claramente separados.

### Parámetros, retornos, herencia
[completa con un ejemplo concreto — por ejemplo, revisa la página de
`basic_json::parse` y describe cómo se ven sus parámetros documentados]

### Diagramas generados
Se generaron 553 grafos con Graphviz (`CLASS_GRAPH`, `COLLABORATION_GRAPH`),
visibles en las páginas de clases con herencia, como
`detail::iterator_input_adapter_factory`.

### Comentarios estructurados vs. inferido por Doxygen
La API pública (`nlohmann::basic_json`) tiene comentarios Doxygen ricos
con `@brief`/`@param`. El namespace `detail::` (implementación interna)
casi no tiene comentarios propios — Doxygen solo infiere firmas y tipos
del código, sin descripciones. Ver clasificación de warnings abajo.

### Qué aprende un desarrollador nuevo
Puede entender rápidamente la API pública de `basic_json` (constructores,
parse, serialización) sin tocar la implementación interna.

### Elementos incompletos
Prácticamente toda la documentación faltante cae en `detail::` — es
intencional por parte del proyecto, no un descuido.

### Capturas
![Portada Doxygen](informe/capturas/doxygen-portada.png)
![Clase basic_json](informe/capturas/doxygen-basicjson.png)
[agrega al menos 5 en total]

---

## 2. Análisis de la documentación Sphinx (scrapy)

### Portada y toctree
La portada muestra la página narrativa propia (`introduccion.rst`) y el
`toctree` enlaza a la referencia de API (`api/modules`).

### Paquetes, módulos, clases
[describe lo que viste al abrir `api/scrapy.spiders.html` — clases como
`Spider`, `CrawlSpider`, con sus métodos]

### Contenido automático vs. narrativo
`autodoc` extrajo firmas y docstrings de `Spider`, `Request`, `Response`.
El contenido narrativo (introducción del framework, flujo de datos) fue
escrito manualmente porque `sphinx-apidoc` solo genera referencia técnica,
no explica el propósito ni cómo se relacionan los módulos entre sí.

### Parámetros, tipos, búsqueda
[completa con lo que confirmaste al revisar el HTML generado]

### Qué aprende un usuario nuevo
[tu análisis]

### Elementos incompletos
[revisa si hay warnings de `duplicate object description` u otros —
pégalos aquí clasificados]

### Capturas
![Portada Sphinx](informe/capturas/sphinx-portada.png)
[al menos 5 en total]

---

## 3. Comparación entre Doxygen y Sphinx

| Dimensión | Doxygen en C++ | Sphinx en Python |
|---|---|---|
| Fuente principal de la información | Comentarios `@brief` en headers + inferencia de firmas | Docstrings + `.rst` narrativo escrito a mano |
| Configuración y proceso de generación | Un solo `Doxyfile`, un comando | `conf.py` + `sphinx-apidoc` + `sphinx-build`, más pasos |
| Organización y navegación | Árbol por namespace/clase/archivo | `toctree` jerárquico, más flexible para narrativa |
| Documentación de API | Automática desde firmas de C++ | Depende de calidad de docstrings |
| Diagramas y referencias cruzadas | Grafos de clase/colaboración con Graphviz | Solo enlaces `viewcode`, sin diagramas nativos |
| Contenido narrativo | Limitado a páginas Markdown adicionales | Nativo vía `.rst`, primera clase |
| Dependencia de comentarios/docstrings | Alta para detail útil, pero funciona igual sin ellos | Alta — sin docstrings, autodoc genera casi nada |
| Facilidad de mantenimiento | Regenerar es trivial (1 comando) | Requiere venv + dependencias instaladas |
| Audiencia principal | Desarrolladores que navegan código C++ | Desarrolladores y usuarios de la librería Python |
| Fortalezas y limitaciones | Fuerte en estructura/relaciones; débil en narrativa | Fuerte en narrativa; débil en diagramas nativos |

**¿Cuál produjo información útil con menos configuración?**
[tu respuesta — pista: Doxygen con `doxygen -g` + editar unas pocas líneas
ya da resultado; Sphinx necesita más piezas coordinadas]

**¿Cuál ayuda mejor a comprender la arquitectura?**
[tu respuesta, apóyate en los grafos de Doxygen vs. la narrativa de Sphinx]

**¿Cuál ayuda mejor a aprender a usar la API?**
[tu respuesta]

**¿Qué problemas del código quedaron expuestos?**
### Incidencia real encontrada durante la generación

Al publicar el sitio en Netlify se detectó que la página principal
(`index.html`) se generaba vacía, mostrando solo un enlace de rastreo
(`doxygen_crawl.html`) sin ningún contenido visible. Al revisar
`doxygen/build.log` se encontró la causa exacta:
Doxygen exige que cualquier archivo referenciado en
`USE_MDFILE_AS_MAINPAGE` esté **también** incluido explícitamente en
`INPUT` — no basta con apuntarlo solo desde `USE_MDFILE_AS_MAINPAGE`. La
configuración original solo listaba `include/nlohmann` en `INPUT`, así
que Doxygen ubicaba el README pero nunca procesaba su contenido como
texto de la página principal.

**Solución aplicada:** se modificó `INPUT` para incluir ambos

**¿Qué cambios integrarías al flujo de desarrollo?**
[ej.: generar documentación en CI en cada push a main]

**¿Qué verificarías en integración continua?**
[ej.: que `doxygen`/`sphinx-build` terminen sin errores críticos, que no
aumenten los warnings respecto al build anterior]

---

## 4. Estrategia de ramas y Git

Se trabajó con ramas separadas por componente (`estructura-sitio`,
`configuracion-doc`) integradas a `main` mediante merge, manteniendo un
historial trazable de cada parte del laboratorio.