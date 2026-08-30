# Selección del proyecto — nlohmann/json

- **Nombre y descripción:** nlohmann/json — librería header-only de C++ para
  serializar/deserializar JSON con una API que imita contenedores STL.
- **URL:** https://github.com/nlohmann/json
- **Licencia:** MIT
- **Lenguaje principal:** C++ (header-only, `.hpp`)
- **Commit analizado:** 35705d79d878db5ca1a282ec0f8243a80010d24e
- **Métricas:** 47 archivos, 19 169 líneas de código (cloc, excluyendo thirdparty/hedley)
- **Comando usado:** `cloc include/nlohmann`
- **Por qué es apropiado para Doxygen:** buen uso de namespaces (nlohmann::,
  detail::), clases con plantillas, jerarquía clara entre API pública e
  implementación interna.
- **Comentarios Doxygen existentes:** la API pública (basic_json) trae
  comentarios ricos; el namespace detail:: casi no tiene, por ser
  implementación interna.
- **Dependencias/dificultades previstas:** Graphviz para diagramas;
  exclusión de thirdparty/hedley por ser vendorizado.