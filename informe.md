# Informe del Laboratorio

**Estudiante:** Gabriel Ulloa — Carné C27890
**Curso:** IE0417 — Diseño de Software para Ingeniería

---

## 1. Análisis de la documentación Doxygen (nlohmann/json)

**Sitio publicado:** https://gulloab-ie417-lab1.netlify.app/cpp/
**Repositorio original:** https://github.com/nlohmann/json
**Commit analizado:** 35705d79d878db5ca1a282ec0f8243a80010d24e

### Página principal y organización de la navegación
La portada muestra el contenido del `README.md` original del proyecto, incorporado mediante la directiva `USE_MDFILE_AS_MAINPAGE`: introducción a la librería, badges de integración continua, y una tabla de contenidos que enlaza a las secciones internas del README (objetivos de diseño, ejemplos de uso, guía de instalación). La navegación lateral usa árbol expandible (`GENERATE_TREEVIEW = YES`), organizado en cuatro secciones principales: Main Page, Related Pages, Namespaces y Classes. Desde cualquier punto del sitio se puede llegar a cualquier clase o archivo en pocos clics gracias a esa navegación persistente.

### Información generada para clases, estructuras, namespaces, archivos y funciones
Para cada clase o estructura, Doxygen genera: la firma completa (incluyendo parámetros de plantilla cuando aplica), la lista de miembros con su tipo y visibilidad, y la ubicación exacta en el archivo fuente donde está definida. Los namespaces `nlohmann` (API pública) y `nlohmann::detail` (implementación interna) aparecen claramente separados en el árbol de Namespaces, lo que ayuda a distinguir de inmediato qué está pensado para uso externo y qué es mecanismo interno.

### Parámetros, valores de retorno, miembros, herencia y relaciones
La clase central `nlohmann::basic_json` (alias `nlohmann::json`) es el mejor ejemplo de esto: sus métodos públicos, como los constructores y `parse()`, muestran cada parámetro documentado con su tipo, una descripción de qué representa, el tipo de retorno explicado, y las excepciones que pueden lanzarse (por ejemplo `parse_error` cuando el JSON de entrada es inválido). Las relaciones de herencia y composición entre `detail::` y la clase pública se ven reflejadas en los grafos de colaboración generados automáticamente.

### Diagramas y referencias cruzadas
Se generaron 553 grafos con Graphviz (`HAVE_DOT`, `CLASS_GRAPH`, `COLLABORATION_GRAPH`), visibles en cualquier clase con relaciones de plantillas o herencia — por ejemplo `detail::iterator_input_adapter_factory` o `detail::is_basic_json`. Además, `SOURCE_BROWSER = YES` permite saltar del nombre de cualquier símbolo directamente a su definición en el código fuente, resaltado con sintaxis coloreada.

### Qué parte proviene de comentarios estructurados y qué infiere Doxygen del código
La API pública (`basic_json` y sus métodos) trae comentarios Doxygen ricos escritos por los autores del proyecto, con etiquetas `@brief`, `@param`, `@return` y `@throw`. En cambio, el namespace `detail::` —la mayoría de los 47 archivos procesados— casi no tiene comentarios propios: Doxygen solo infiere las firmas, tipos y relaciones directamente del código, sin descripciones textuales que las acompañen. Este contraste es intencional por parte del proyecto: la implementación interna nunca fue pensada para consumo externo.

### Qué puede aprender un desarrollador nuevo
Un desarrollador nuevo puede entender rápidamente cómo construir, parsear, modificar y serializar un objeto `json` sin necesidad de leer una sola línea de la implementación interna — la documentación de la API pública es autocontenida y suficiente para empezar a usar la librería.

### Elementos incompletos, poco claros o sin documentar, y por qué
Prácticamente toda la documentación "faltante" señalada por los warnings del build cae dentro de `detail::`. Esto es coherente con la intención del proyecto de no documentar su implementación interna como si fuera API pública, y no representa un descuido de este laboratorio.

### Incidencia real encontrada durante la generación
Al publicar el sitio por primera vez en Netlify se detectó que la página principal se generaba vacía, mostrando solo un enlace de rastreo interno (`doxygen_crawl.html`) sin contenido visible. Revisando `doxygen/build.log` se encontró el warning exacto:
Tras regenerar, la portada mostró correctamente el README completo y el warning desapareció del log. Esta incidencia no afectaba la navegación por clases o archivos, que funcionaba correctamente desde el inicio — solo la portada. Por eso pasó desapercibida en las primeras verificaciones locales y solo se detectó al hacer la verificación pública exigida por el punto 10.3 del enunciado, lo que confirma en la práctica por qué esa verificación es indispensable y no un simple trámite.


---

## 2. Análisis de la documentación Sphinx (scrapy)

**Sitio publicado:** https://gulloab-ie417-lab1.netlify.app/python/
**Repositorio original:** https://github.com/scrapy/scrapy
**Commit analizado:** *(completar con el hash completo obtenido de `git rev-parse HEAD` en el clon de scrapy)*

### Qué muestra la portada y cómo funciona el toctree
La portada muestra la página narrativa propia, escrita en `index.rst`: una introducción a qué es scrapy (un framework de Python para extraer datos de sitios web de forma escalable y asíncrona) y una descripción del flujo central del framework — el usuario define una `Spider` que genera objetos `Request`; el motor los despacha a través de una cadena de `downloadermiddlewares` antes de obtener un `Response`; ese response se procesa con el módulo `selector` para extraer datos, que luego pasan por `pipelines` para su almacenamiento final. El `toctree` debajo de esa introducción enlaza a la referencia de API (`api/modules`), integrando narrativa y referencia técnica en la misma navegación lateral.

### Cómo se representan los paquetes, módulos, clases, funciones y métodos
`sphinx-apidoc` generó un archivo `.rst` por cada submódulo real de scrapy (`spiders`, `http`, `selector`, `pipelines`, `downloadermiddlewares`, `core`, `utils`, entre otros). Cada página de la referencia de API muestra la jerarquía de clases del módulo correspondiente, sus métodos con firma completa, y — cuando el docstring lo especifica — los tipos de parámetros y de retorno.

### Qué contenido se obtuvo automáticamente de firmas y docstrings
`sphinx.ext.autodoc` extrajo directamente las firmas y docstrings de las clases centrales del framework: `Spider` y sus variantes (`CrawlSpider`, `SitemapSpider`), `Request`/`Response` y sus subclases especializadas (`FormRequest`, `JsonRequest`, `HtmlResponse`), y `Selector`. `sphinx.ext.napoleon` interpretó los docstrings en estilo Google/NumPy presentes en varios de esos módulos, convirtiéndolos en secciones de parámetros y retornos formateadas correctamente.

### Qué contenido narrativo fue escrito manualmente y por qué era necesario
La introducción de `index.rst` fue escrita a mano porque `sphinx-apidoc`/`autodoc` solo generan referencia técnica — qué clases y métodos existen — sin explicar el propósito del proyecto ni cómo se relacionan sus piezas entre sí. Esa capacidad de narrar el "por qué" y el flujo general es justamente la diferencia principal frente a lo que ofrece Doxygen de forma nativa.

### Cómo se presentan parámetros, tipos, retornos, excepciones, índices, búsqueda y enlaces al código
Las páginas de clases muestran los parámetros con su tipo (cuando el docstring o la anotación de tipo de Python lo especifica) y una descripción de qué representa cada uno. `sphinx.ext.viewcode` agrega en cada método un enlace "View source" que lleva directo al código fuente real con resaltado de sintaxis. El tema Read the Docs (`sphinx_rtd_theme`) provee un buscador funcional en la barra lateral y un índice general (`genindex.html`) navegable.

### Qué puede aprender una persona desarrolladora nueva sobre el proyecto
Combinando la página narrativa con la referencia de API, alguien que nunca usó scrapy puede entender el flujo completo de una araña de rastreo — desde que se define un `Spider` hasta que los datos extraídos llegan a un `pipeline` — y después profundizar en la clase específica que necesite sin perder el contexto de cómo encaja en el resto del framework.

### Qué elementos quedaron incompletos, poco claros o sin documentar, y por qué
Al revisar `sphinx/build.log` aparecen advertencias del tipo `duplicate object description`, producidas porque `scrapy/__init__.py` re-exporta varias clases (como `Spider` o `Request`) desde sus módulos internos hacia el paquete raíz, y `autodoc` termina documentando el mismo símbolo desde dos rutas distintas. No es un error de configuración del laboratorio, sino un patrón común en paquetes de Python que ofrecen una API "plana" de conveniencia sobre una estructura interna más profunda.

### Capturas
*(agregar aquí al menos 5 capturas: portada con la introducción narrativa, la página de API de `scrapy.spiders`, el buscador en uso, un enlace "View source" abierto, y el índice general — guardarlas en `informe/capturas/`)*

---

## 3. Comparación entre Doxygen y Sphinx

| Dimensión | Doxygen en C++ | Sphinx en Python |
|---|---|---|
| Fuente principal de la información | Comentarios `@brief`/`@param` en headers + inferencia automática de firmas | Docstrings del código + archivo `.rst` narrativo escrito a mano |
| Configuración y proceso de generación | Un solo `Doxyfile`, un comando (`doxygen Doxyfile`) | `conf.py` + `sphinx-apidoc` + `sphinx-build`, varios pasos coordinados, requiere entorno virtual activo |
| Organización y navegación | Árbol por namespace, clase y archivo | `toctree` jerárquico, más flexible para mezclar narrativa y referencia técnica |
| Documentación de API | Automática desde las firmas de C++, completa incluso sin comentarios | Depende fuertemente de la calidad de los docstrings existentes en el código |
| Diagramas y referencias cruzadas | Grafos de clase y colaboración generados nativamente con Graphviz | Solo enlaces `viewcode` hacia el código fuente; sin diagramas nativos |
| Contenido narrativo | Limitado, incorporado vía páginas Markdown adicionales (`USE_MDFILE_AS_MAINPAGE`) | Nativo y central en el flujo de trabajo, vía archivos `.rst` |
| Dependencia de comentarios/docstrings | Funciona igual sin comentarios, solo pierde descripciones textuales | Sin docstrings, `autodoc` genera páginas casi vacías de contenido útil |
| Facilidad de mantenimiento | Regenerar es trivial, un solo comando sin dependencias externas | Requiere mantener el entorno virtual y las dependencias del proyecto instaladas |
| Audiencia principal | Desarrolladores que navegan y mantienen el código C++ | Tanto desarrolladores que integran la librería como usuarios finales del framework |
| Fortalezas y limitaciones | Fuerte en estructura y relaciones de código; débil para explicar el "por qué" | Fuerte en narrativa y guías de uso; débil en diagramas visuales nativos |

**¿Cuál herramienta produjo información útil con menos configuración y por qué?**
Doxygen. Con `doxygen -g` más una docena de líneas ajustadas en el `Doxyfile` ya se obtiene un sitio completo y navegable. Sphinx necesitó coordinar `conf.py`, la ejecución de `sphinx-apidoc` sobre el paquete, y — de forma crítica — un entorno virtual con las dependencias reales del proyecto instaladas para que `autodoc` pudiera importar los módulos y extraer sus docstrings.

**¿Cuál resultado ayuda mejor a comprender la arquitectura del proyecto?**
Doxygen, gracias a los grafos de colaboración y herencia generados automáticamente, que permiten ver relaciones entre clases sin necesidad de leer el código fuente completo.

**¿Cuál resultado ayuda mejor a aprender a utilizar la API?**
Sphinx, porque combina la referencia técnica con la página narrativa que explica el flujo de uso real del framework (`Spider` → `Request` → `Response` → `pipelines`), un tipo de contenido que Doxygen no ofrece de forma nativa.

**¿Qué problemas del código fuente quedaron expuestos al generar la documentación?**
En nlohmann/json, la cantidad de miembros internos de `detail::` sin documentar refleja una decisión deliberada de no exponer la implementación como API — no es un problema de calidad, sino de alcance. En scrapy, las advertencias de `duplicate object description` expusieron que el paquete re-exporta símbolos desde múltiples rutas, un patrón común pero que complica ligeramente la generación automática de referencia. Además, la generación de Doxygen expuso un problema real de **configuración** (no del código fuente): `USE_MDFILE_AS_MAINPAGE` sin el archivo correspondiente también en `INPUT` produce una portada vacía sin lanzar error fatal, documentado en la sección 1.

**¿Qué cambios integraría al flujo de desarrollo para mantener la documentación actualizada?**
Automatizar la regeneración de ambas documentaciones en un pipeline de integración continua que se dispare en cada push a la rama principal, publicando el resultado directamente al sitio de Netlify mediante despliegue continuo en vez de mantenerlo como un paso manual.

**¿Qué verificaciones automatizaría en integración continua?**
Que tanto `doxygen` como `sphinx-build` terminen su ejecución sin errores críticos; que el conteo de warnings no aumente respecto al build anterior (para detectar regresiones de documentación); y una verificación automatizada de que la página principal de cada sitio generado no esté vacía — un chequeo simple que habría detectado la incidencia de la sección 1 antes de publicar, en vez de descubrirla manualmente después del deploy.

---

## 4. Estrategia de ramas y uso de Git en la entrega

Se trabajó con ramas separadas por componente del laboratorio: `estructura-sitio` para la publicación del HTML generado en `site/`, y `configuracion-doc` para las configuraciones de Doxygen y Sphinx, las selecciones de proyecto y el análisis del informe. Ambas se integraron a `main` mediante merge, lo que permitió aislar cada parte del trabajo y mantener un historial trazable de cuándo se incorporó cada componente del laboratorio.

## 5. Verificación de publicación pública (punto 10.3)

**Navegador usado:** ventana privada (sin sesión iniciada), para confirmar acceso sin autenticación.

URLs verificadas:
- Portada: https://gulloab-ie417-lab1.netlify.app/
- Documentación Doxygen (C++): https://gulloab-ie417-lab1.netlify.app/cpp/
- Documentación Sphinx (Python): https://gulloab-ie417-lab1.netlify.app/python/

Se confirmó navegación funcional en clases y módulos internos de ambas documentaciones, buscador operativo en las dos, y todos los recursos (CSS, JavaScript, imágenes, grafos) cargando correctamente sin requerir autenticación.
