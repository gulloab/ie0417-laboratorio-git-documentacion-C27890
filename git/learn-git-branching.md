# Niveles de Main

### M1.1 - Introduction to Git Commits
**Objetivo:** Crear dos commits para completar el nivel.  
**Estado inicial:** Repositorio en la rama `main` con un commit inicial `C0`.

| Paso | Comando | Efecto sobre el repositorio |
|---:|---|---|
| 1 | `git commit` | Genera un nuevo commit `C1` avanzando la rama `main`. |
| 2 | `git commit` | Genera un nuevo commit `C2` avanzando la rama `main`. |

**Estado final:** La rama `main` apunta al commit `C2`.

![Nivel completado](evidencias/m1-1.png)  
**Aprendizaje:** Un commit guarda una captura del estado del proyecto y avanza la referencia de la rama actual.

---

### M1.2 - Branching in Git
**Objetivo:** Crear una nueva rama llamada `bugFix` y cambiarte a ella.  
**Estado inicial:** Repositorio en la rama `main` sobre `C1`.

| Paso | Comando | Efecto sobre el repositorio |
|---:|---|---|
| 1 | `git checkout -b bugFix` | Crea la rama `bugFix` y apunta `HEAD` hacia ella. |

**Estado final:** `HEAD` apuntando a `bugFix` sobre el commit `C1`.

![Nivel completado](evidencias/m1-2.png)  
**Aprendizaje:** Las ramas son simplemente punteros ligeros a commits específicos. `checkout -b` combina creación y cambio de rama.

---

### M1.3 - Merging in Git
**Objetivo:** Crear la rama `bugFix`, hacer un commit en ella, volver a `main`, hacer otro commit y unir ambos con `merge`.  
**Estado inicial:** Repositorio en `main` sobre `C1`.

| Paso | Comando | Efecto sobre el repositorio |
|---:|---|---|
| 1 | `git checkout -b bugFix` | Crea y se cambia a la rama `bugFix`. |
| 2 | `git commit` | Genera el commit `C2` en la rama `bugFix`. |
| 3 | `git checkout main` | Cambia el contexto de trabajo a la rama `main`. |
| 4 | `git commit` | Genera el commit `C3` en la rama `main`. |
| 5 | `git merge bugFix` | Crea un commit de fusión `C4` que une `main` y `bugFix`. |

**Estado final:** `main` apunta al commit de fusión `C4` combinando ambas historias.

![Nivel completado](evidencias/m1-3.png)  
**Aprendizaje:** `git merge` integra los cambios de otra rama creando un nuevo commit de fusión con dos padres.

---

### M1.4 - Rebase Introduction
**Objetivo:** Rebasar el trabajo de `bugFix` sobre `main`.  
**Estado inicial:** Ramas divergentes `main` (en `C2`) y `bugFix` (en `C3`).

| Paso | Comando | Efecto sobre el repositorio |
|---:|---|---|
| 1 | `git checkout -b bugFix` | Crea y se mueve a la rama `bugFix`. |
| 2 | `git commit` | Genera el commit `C2` en `bugFix`. |
| 3 | `git checkout main` | Cambia a la rama `main`. |
| 4 | `git commit` | Genera el commit `C3` en `main`. |
| 5 | `git checkout bugFix` | Cambia de nuevo a `bugFix`. |
| 6 | `git rebase main` | Traslada el commit `C2` sobre la punta de `main` como `C2'`. |

**Estado final:** `bugFix` se encuentra sobre `C2'`, derivado linealmente de `C3` en `main`.

![Nivel completado](evidencias/m1-4.png)  
**Aprendizaje:** `rebase` permite mantener una historia de commits lineal reescribiendo la base de la rama actual.

---

### M2.1 - Detach yo’ HEAD
**Objetivo:** Desacoplar `HEAD` de la rama `main` y apuntarlo directamente al commit `C2`.  
**Estado inicial:** `HEAD` apuntando a `main` en `C1`.

| Paso | Comando | Efecto sobre el repositorio |
|---:|---|---|
| 1 | `git checkout C2` | Apunta `HEAD` directamente al commit `C2` en lugar de a la rama `main`. |

**Estado final:** `HEAD` desacoplado apuntando directamente a `C2`.

![Nivel completado](evidencias/m2-1.png)  
**Aprendizaje:** `HEAD` representa el commit o rama de trabajo actual. Al hacer checkout a un commit especifico, entra en estado "detached HEAD".

---

### M2.2 - Relative Refs (^)
**Objetivo:** Mover `HEAD` al padre inmediato del commit donde está la rama `bugFix`.  
**Estado inicial:** `HEAD` apuntando a `main` en `C2`.

| Paso | Comando | Efecto sobre el repositorio |
|---:|---|---|
| 1 | `git checkout bugFix^` | Mueve `HEAD` un commit atrás del puntero de `bugFix`. |

**Estado final:** `HEAD` desacoplado en el commit previo a `bugFix`.

![Nivel completado](evidencias/m2-2.png)  
**Aprendizaje:** El carácter `^` permite desplazarse hacia arriba un ancestro inmediato en el árbol de commits.

---

### M2.3 - Relative Refs #2 (~)
**Objetivo:** Mover la rama `main` tres commits atrás y la rama `bugFix` al commit exacto indicado.  
**Estado inicial:** Múltiples commits en la rama `main`.

| Paso | Comando | Efecto sobre el repositorio |
|---:|---|---|
| 1 | `git branch -f main C6` | Mueve forzadamente la referencia de `main` al commit `C6`. |
| 2 | `git checkout HEAD~1` | Mueve `HEAD` un nivel arriba en el árbol relativo. |
| 3 | `git branch -f bugFix HEAD~1` | Mueve la rama `bugFix` un nivel arriba respecto a `HEAD`. |

**Estado final:** `main` apunta a `C6` y `bugFix` apunta a `C0`.

![Nivel completado](evidencias/m2-3.png)  
**Aprendizaje:** El carácter `~<n>` permite desplazarse $n$ pasos atrás en el historial. `git branch -f` permite reasignar ramas arbitrariamente.

---

### M2.4 - Reversing Changes in Git
**Objetivo:** Revertir un commit en `local` deshaciéndolo y revertir un commit en `pushed` agregando un commit inverso.  
**Estado inicial:** Rama `local` en `C2` y `pushed` en `C3`.

| Paso | Comando | Efecto sobre el repositorio |
|---:|---|---|
| 1 | `git reset HEAD~1` | Mueve la rama `local` atrás descartando el commit `C2`. |
| 2 | `git checkout pushed` | Cambia a la rama `pushed`. |
| 3 | `git revert HEAD` | Crea un nuevo commit `C3'` que anula los cambios introducidos en `C3`. |

**Estado final:** `local` apunta a `C1` y `pushed` incluye la anulación en `C3'`.

![Nivel completado](evidencias/m2-4.png)  
**Aprendizaje:** `reset` reescribe la historia local, mientras que `revert` es seguro para ramas compartidas ya que añade un nuevo commit.

---

### M3.1 - Cherry-pick Intro
**Objetivo:** Copiar los commits `C3`, `C4` y `C7` debajo de `main`.  
**Estado inicial:** Ramas con commits disjuntos `side` y `another`.

| Paso | Comando | Efecto sobre el repositorio |
|---:|---|---|
| 1 | `git cherry-pick C3 C4 C7` | Copia secuencialmente los commits indicados a la punta actual de `main`. |

**Estado final:** `main` contiene copias exactas `C3'`, `C4'` y `C7'`.

![Nivel completado](evidencias/m3-1.png)  
**Aprendizaje:** `git cherry-pick` permite copiar commits específicos desde cualquier lugar de la historia hacia la rama actual.

---

### M3.2 - Interactive Rebase Intro
**Objetivo:** Reordenar y descartar commits mediante rebase interactivo para emparejar la meta.  
**Estado inicial:** Rama `main` sobre el commit `C4`.

| Paso | Comando | Efecto sobre el repositorio |
|---:|---|---|
| 1 | `git rebase -i HEAD~4` | Abre la interfaz interactiva para reordenar, omitir o combinar los últimos 4 commits. |

**Estado final:** La secuencia de commits se reorganiza según el orden definido en el editor interactivo.

![Nivel completado](evidencias/m3-2.png)  
**Aprendizaje:** `rebase -i` ofrece control absoluto sobre el historial para reordenar, editar, eliminar o fusionar commits.

---

### M4.1 - Grabbing Just 1 Commit
**Objetivo:** Mover los cambios de un commit específico en `bugFix` hacia `main` sin llevarse ramas completas.  
**Estado inicial:** `bugFix` tiene modificaciones sobre un error necesario en `main`.

| Paso | Comando | Efecto sobre el repositorio |
|---:|---|---|
| 1 | `git checkout main` | Se sitúa en la rama `main`. |
| 2 | `git cherry-pick C4` | Aplica únicamente el commit `C4` sobre la rama `main`. |

**Estado final:** `main` incluye únicamente el parche de `C4` como `C4'`.

![Nivel completado](evidencias/m4-1.png)  
**Aprendizaje:** Seleccionar commits individuales con `cherry-pick` evita arrastrar cambios no deseados o incompletos.

---

### M4.2 - Juggling Commits
**Objetivo:** Reordenar los commits con rebase interactivo, modificar uno y volver a reordenar para dejar la historia limpia.  
**Estado inicial:** `caption` se encuentra dos commits por detrás de la punta.

| Paso | Comando | Efecto sobre el repositorio |
|---:|---|---|
| 1 | `git rebase -i HEAD~2` | Intercambia el orden de los commits para colocar la modificación al final. |
| 2 | `git commit --amend` | Modifica el commit que ahora está en la cima. |
| 3 | `git rebase -i HEAD~2` | Restaura el orden original de la secuencia de commits. |

**Estado final:** El commit deseado es actualizado sin alterar la estructura general.

![Nivel completado](evidencias/m4-2.png)  
**Aprendizaje:** Alterar temporalmente la secuencia de commits permite editar puntos intermedios de la historia de forma limpia.

---

### M4.3 - Juggling Commits #2
**Objetivo:** Lograr el mismo resultado de modificación intermedia usando `cherry-pick` en lugar de rebase interactivo.  
**Estado inicial:** Commit meta sumergido en la historia.

| Paso | Comando | Efecto sobre el repositorio |
|---:|---|---|
| 1 | `git checkout main` | Cambia a la rama `main`. |
| 2 | `git cherry-pick C2` | Aplica el commit `C2` sobre `main`. |
| 3 | `git commit --amend` | Realiza los cambios necesarios en el nuevo commit. |
| 4 | `git cherry-pick C3` | Aplica secuencialmente el commit posterior `C3`. |

**Estado final:** Historia actualizada mediante reaplicación de commits sin usar rebase interactivo.

![Nivel completado](evidencias/m4-3.png)  
**Aprendizaje:** `cherry-pick` sirve como alternativa más segura y predecible al rebase interactivo para editar commits intermedios.

---

### M4.4 - Git Tags
**Objetivo:** Crear las etiquetas `v1` en `C1` y `v0` en `C2`.  
**Estado inicial:** Commits `C1` y `C2` presentes en el grafo sin etiquetas.

| Paso | Comando | Efecto sobre el repositorio |
|---:|---|---|
| 1 | `git tag v1 C1` | Asigna un hito nombrado `v1` permanentemente al commit `C1`. |
| 2 | `git tag v0 C2` | Asigna un hito nombrado `v0` permanentemente al commit `C2`. |
| 3 | `git checkout v1` | Apunta `HEAD` directamente a la etiqueta `v1`. |

**Estado final:** Hitos permanentes creados en los commits correspondientes.

![Nivel completado](evidencias/m4-4.png)  
**Aprendizaje:** Las etiquetas (tags) son punteros inmutables que marcan momentos clave en la historia del proyecto.

---

### M4.5 - Git Describe
**Objetivo:** Ejecutar `git describe` para obtener la posición relativa de los commits respecto a los tags.  
**Estado inicial:** Punteros y etiquetas previamente configurados.

| Paso | Comando | Efecto sobre el repositorio |
|---:|---|---|
| 1 | `git describe side` | Muestra la distancia y el hash más cercano respecto a la etiqueta más próxima. |
| 2 | `git commit` | Genera un nuevo commit en el entorno de pruebas. |

**Estado final:** Salida descriptiva formateada como `<tag>-<numCommits>-g<hash>`.

![Nivel completado](evidencias/m4-5.png)  
**Aprendizaje:** `git describe` orienta sobre cuán lejos se encuentra la rama actual respecto a la última versión etiquetada.

---

### M5.1 - Rebasing over 9000 times
**Objetivo:** Rebasar múltiples ramas (`bugFix`, `side`, `another`) de manera secuencial sobre `main`.  
**Estado inicial:** Árbol altamente ramificado con múltiples líneas de trabajo.

| Paso | Comando | Efecto sobre el repositorio |
|---:|---|---|
| 1 | `git rebase main bugFix` | Rebasa `bugFix` sobre `main`. |
| 2 | `git rebase bugFix side` | Rebasa `side` sobre la punta actualizada de `bugFix`. |
| 3 | `git rebase side another` | Rebasa `another` sobre la punta de `side`. |
| 4 | `git rebase another main` | Avanza la referencia de `main` en modo fast-forward al final. |

**Estado final:** Historia completamente linealizada con todas las ramas integradas en `main`.

![Nivel completado](evidencias/m5-1.png)  
**Aprendizaje:** Se pueden concatenar operaciones de rebase entre múltiples ramas para unificar desarrollos en paralelo.

---

### M5.2 - Multiple parents
**Objetivo:** Utilizar modificadores relativos combinados (`~` y `^`) para navegar a través de commits con múltiples padres.  
**Estado inicial:** Grafo de commits resultante de fusiones avanzadas.

| Paso | Comando | Efecto sobre el repositorio |
|---:|---|---|
| 1 | `git checkout HEAD~^2~2` | Navega al segundo padre del commit actual y retrocede dos posiciones. |
| 2 | `git branch -f bugFix HEAD` | Mueve la rama `bugFix` a la posición navegada. |

**Estado final:** `bugFix` apunta al ancestro objetivo en el árbol complejo.

![Nivel completado](evidencias/m5-2.png)  
**Aprendizaje:** El modificador `^2` permite elegir el segundo padre en un commit de fusión, habilitando una navegación precisa.

---

### M5.3 - Branch Spaghetti
**Objetivo:** Reorganizar una historia caótica de ramas en un desarrollo limpio y ordenado.  
**Estado inicial:** Grafo desordenado con múltiples ramificaciones cruzadas.

| Paso | Comando | Efecto sobre el repositorio |
|---:|---|---|
| 1 | `git checkout main` | Posiciona el contexto en `main`. |
| 2 | `git cherry-pick C4 C3 C7` | Copia la secuencia limpia deseada de commits. |
| 3 | `git branch -f one C4` | Ajusta la referencia de la rama `one`. |
| 4 | `git branch -f two C3` | Ajusta la referencia de la rama `two`. |
| 5 | `git branch -f three C7` | Ajusta la referencia de la rama `three`. |

**Estado final:** Ramas estructuradas con sus commits de interés ordenados.

![Nivel completado](evidencias/m5-3.png)  
**Aprendizaje:** Combinar `cherry-pick` con reasignación forzada de ramas (`git branch -f`) permite reestructurar árboles de Git complejos.

---

# Niveles de Remote

### R1.1 - Clone Intro
**Objetivo:** Clonar un repositorio remoto por primera vez.  
**Estado inicial:** Repositorio local sin conexión a servidor remoto.

| Paso | Comando | Efecto sobre el repositorio |
|---:|---|---|
| 1 | `git clone` | Copia el repositorio remoto localmente y configura el remoto `origin`. |

**Estado final:** Copia local exacta con referencias a `origin/main`.

![Nivel completado](evidencias/r1-1.png)  
**Aprendizaje:** `git clone` establece el vínculo entre el entorno local y el servidor remoto predeterminado (`origin`).

---

### R1.2 - Remote Branches
**Objetivo:** Desplegar commits en el entorno local manteniendo actualizada la rama de rastreo remoto.  
**Estado inicial:** Repositorio clonado con rama `origin/main`.

| Paso | Comando | Efecto sobre el repositorio |
|---:|---|---|
| 1 | `git commit` | Avanza la rama `main` local dejando atrás a `origin/main`. |
| 2 | `git checkout origin/main` | Cambia la vista activa directamente al puntero remoto. |
| 3 | `git commit` | Desacopla `HEAD` sobre la rama remota simulando cambios. |

**Estado final:** `HEAD` posicionado sobre la representación remota.

![Nivel completado](evidencias/r1-2.png)  
**Aprendizaje:** Las ramas remota (`origin/main`) reflejan el estado del servidor y solo se actualizan tras operaciones de red o cambios explícitos.

---

### R1.3 - Git Fetchin’
**Objetivo:** Descargar todos los commits del remoto sin alterar las ramas locales.  
**Estado inicial:** Remoto avanzado con nuevos commits no presentes en local.

| Paso | Comando | Efecto sobre el repositorio |
|---:|---|---|
| 1 | `git fetch` | Descarga los commits del remoto y actualiza la referencia `origin/main`. |

**Estado final:** `origin/main` actualizado con los cambios del servidor, pero `main` local se mantiene intacta.

![Nivel completado](evidencias/r1-3.png)  
**Aprendizaje:** `git fetch` descarga la información remota pero no aplica fusiones en el código de trabajo local.

---

### R1.4 - Git Pullin’
**Objetivo:** Descargar e integrar los cambios remotos en una sola operación.  
**Estado inicial:** `origin/main` contiene commits por delante de la rama local.

| Paso | Comando | Efecto sobre el repositorio |
|---:|---|---|
| 1 | `git pull` | Descarga los datos remotos y ejecuta un `merge` directo en la rama actual. |

**Estado final:** `main` local sincronizada con `origin/main` incluyendo el commit de fusión.

![Nivel completado](evidencias/r1-4.png)  
**Aprendizaje:** `git pull` equivale a ejecutar en secuencia `git fetch` seguido de `git merge`.

---

### R1.5 - Faking Teamwork
**Objetivo:** Simular que un colaborador empujó cambios al remoto antes de integrarlos localmente.  
**Estado inicial:** Repositorio local desincronizado del servidor remoto.

| Paso | Comando | Efecto sobre el repositorio |
|---:|---|---|
| 1 | `git fakeTeamwork main 2` | Simula dos commits remotos realizados por un compañero de equipo. |
| 2 | `git commit` | Realiza un commit local propio. |
| 3 | `git pull` | Integra las simulaciones remotas con el trabajo local. |

**Estado final:** `main` local integra los dos cambios remotos simulados.

![Nivel completado](evidencias/r1-5.png)  
**Aprendizaje:** La colaboración en Git requiere sincronizar constantemente los cambios propios con los realizados por terceros.

---

### R1.6 - Git Pushin’
**Objetivo:** Publicar el trabajo local en el repositorio remoto.  
**Estado inicial:** Commits locales no presentes en el servidor remoto.

| Paso | Comando | Efecto sobre el repositorio |
|---:|---|---|
| 1 | `git commit` | Crea el commit local `C2`. |
| 2 | `git commit` | Crea el commit local `C3`. |
| 3 | `git push` | Sube `C2` y `C3` actualizando el remoto `origin/main`. |

**Estado final:** `origin/main` y `main` local alineadas en el mismo commit final.

![Nivel completado](evidencias/r1-6.png)  
**Aprendizaje:** `git push` sube los commits locales al repositorio remoto y actualiza sus punteros correspondientes.

---

### R1.7 - Diverged History
**Objetivo:** Sincronizar y publicar cambios cuando la historia local y la remota han divergido.  
**Estado inicial:** Commits locales y remotos creados en paralelo sobre el mismo ancestro.

| Paso | Comando | Efecto sobre el repositorio |
|---:|---|---|
| 1 | `git clone` | Clona el repositorio base. |
| 2 | `git fakeTeamwork` | Genera un commit divergente en el servidor. |
| 3 | `git commit` | Genera un commit divergente en el área local. |
| 4 | `git fetch` | Trae los datos del servidor remoto. |
| 5 | `git rebase origin/main` | Relocaliza el commit local sobre la cima de `origin/main`. |
| 6 | `git push` | Sube la historia limpia y linealizada. |

**Estado final:** Servidor remoto actualizado con la historia rebasada linealmente.

![Nivel completado](evidencias/r1-7.png)  
**Aprendizaje:** Es obligatorio resolver la divergencia (vía `rebase` o `merge`) antes de poder ejecutar un `push` exitoso.

---

### R1.8 - Locked Main
**Objetivo:** Resolver un rechazo de push sobre la rama protegida `main` creando una rama secundaria.  
**Estado inicial:** Rama `main` remota con reglas de protección que impiden un push directo.

| Paso | Comando | Efecto sobre el repositorio |
|---:|---|---|
| 1 | `git checkout -b feature` | Crea una rama propia para conservar los cambios. |
| 2 | `git branch -f main origin/main` | Resetea `main` local al estado exacto del servidor. |
| 3 | `git push origin feature` | Sube la rama `feature` al remoto de forma segura. |

**Estado final:** Cambios publicados en una rama auxiliar sin violar la protección de `main`.

![Nivel completado](evidencias/r1-8.png)  
**Aprendizaje:** Ante ramas protegidas, los cambios deben enviarse en ramas de características para su posterior revisión vía Pull Request.

---

### R2.1 - Push Main!
**Objetivo:** Sincronizar un entorno complejo rebasando múltiples cambios en local antes de subir a `main`.  
**Estado inicial:** Ramas divergentes locales desfasadas con respecto al remoto.

| Paso | Comando | Efecto sobre el repositorio |
|---:|---|---|
| 1 | `git checkout side1` | Cambia a la rama `side1`. |
| 2 | `git rebase main` | Rebase de `side1` sobre la rama `main`. |
| 3 | `git checkout side2` | Cambia a la rama `side2`. |
| 4 | `git rebase side1` | Rebase de `side2` sobre `side1`. |
| 5 | `git checkout main` | Cambia de nuevo a `main`. |
| 6 | `git rebase side2` | Avanza la referencia de `main` al final de la cadena. |
| 7 | `git push` | Envía la cadena completa unificada al remoto. |

**Estado final:** Repositorio remoto actualizado con una secuencia totalmente lineal de todas las ramas.

![Nivel completado](evidencias/r2-1.png)  
**Aprendizaje:** Es aconsejable ordenar y unificar toda la arquitectura de ramas locales antes de ejecutar la publicación en `origin`.

---

### R2.2 - Merging with remotes
**Objetivo:** Utilizar la estrategia de fusión (`merge`) en lugar de `rebase` para integrar ramas divergentes del servidor.  
**Estado inicial:** Estado divergente entre `main` y `origin/main`.

| Paso | Comando | Efecto sobre el repositorio |
|---:|---|---|
| 1 | `git fetch` | Descarga los commits remotos sin alterar `main`. |
| 2 | `git merge origin/main` | Fusiona la rama remota descargada en `main` local. |
| 3 | `git push` | Sube el commit de fusión resultante al remoto. |

**Estado final:** Historia combinada mediante un commit explícito de fusión publicado en `origin/main`.

![Nivel completado](evidencias/r2-2.png)  
**Aprendizaje:** `merge` conserva la historia real no lineal del proyecto, siendo una alternativa no destructiva frente a `rebase`.

---

### R2.3 - Remote Tracking
**Objetivo:** Configurar una rama local para que rastree a una rama remota con un nombre distinto.  
**Estado inicial:** Rama `main` rastreando por defecto `origin/main`.

| Paso | Comando | Efecto sobre el repositorio |
|---:|---|---|
| 1 | `git checkout -b foo origin/main` | Crea la rama `foo` y la configura para rastrear `origin/main`. |
| 2 | `git commit` | Genera un commit local en la rama `foo`. |
| 3 | `git push` | Publica la actualización directamente sobre `origin/main`. |

**Estado final:** `foo` rastrea y actualiza la rama `main` en el servidor remoto.

![Nivel completado](evidencias/r2-3.png)  
**Aprendizaje:** Las ramas locales pueden rastrear explícitamente cualquier rama remota independiente de su nombre local.

---

### R2.4 - Git push arguments
**Objetivo:** Especificar origen y destino de manera explícita usando argumentos en el comando `git push`.  
**Estado inicial:** Múltiples ramas desconectadas de sus correspondientes remotas.

| Paso | Comando | Efecto sobre el repositorio |
|---:|---|---|
| 1 | `git push origin main` | Publica explícitamente la rama local `main` en `main` de `origin`. |
| 2 | `git push origin foo` | Publica explícitamente la rama local `foo` en `foo` de `origin`. |

**Estado final:** Ambas ramas actualizadas en el repositorio remoto objetivo.

![Nivel completado](evidencias/r2-4.png)  
**Aprendizaje:** La sintaxis `git push <remoto> <rama>` ignora la rama actual y sube la rama especificada al servidor.

---

### R2.5 - Git push arguments - Expanded!
**Objetivo:** Usar la sintaxis de refspec `<origen>:<destino>` para subir cambios a ramas con nombres diferentes en el remoto.  
**Estado inicial:** Punteros locales `foo` y `bar` que deben ir a ramas con nombres distintos en el remoto.

| Paso | Comando | Efecto sobre el repositorio |
|---:|---|---|
| 1 | `git push origin foo:main` | Sube los cambios de la rama local `foo` hacia la rama `main` remota. |
| 2 | `git push origin main^:foo` | Sube el padre de `main` local directamente a la rama `foo` remota. |

**Estado final:** Ramas remotas personalizadas actualizadas según los refspecs definidos.

![Nivel completado](evidencias/r2-5.png)  
**Aprendizaje:** El parámetro refspec `:src:dst` otorga control total sobre qué origen local se envía a qué destino remoto.

---

### R2.6 - Fetch arguments
**Objetivo:** Descargar commits desde ubicaciones explícitas del servidor remoto usando refspecs.  
**Estado inicial:** Servidor remoto con cambios en ramas no rastreadas localmente.

| Paso | Comando | Efecto sobre el repositorio |
|---:|---|---|
| 1 | `git fetch origin main~1:foo` | Trae el penúltimo commit de `main` remoto y crea/actualiza la rama local `foo`. |
| 2 | `git fetch origin foo:main` | Trae la rama `foo` remota directamente sobre la rama `main` local. |

**Estado final:** Ramas locales creadas o actualizadas directamente con datos específicos descargados del remoto.

![Nivel completado](evidencias/r2-6.png)  
**Aprendizaje:** `git fetch` con argumentos permite descargar información específica y colocarla directamente en ramas locales elegidas.

---

### R2.7 - Source of nothing
**Objetivo:** Eliminar ramas remotas pasando un origen vacío en `push` o crear ramas locales con un origen vacío en `fetch`.  
**Estado inicial:** Rama `foo` remota existente que se desea eliminar.

| Paso | Comando | Efecto sobre el repositorio |
|---:|---|---|
| 1 | `git push origin :foo` | Envía "nada" a la rama remota `foo`, eliminándola del servidor. |
| 2 | `git fetch origin :bar` | Crea la rama local `bar` vacía a partir del comando fetch. |

**Estado final:** Rama `foo` eliminada en el servidor y rama `bar` creada localmente.

![Nivel completado](evidencias/r2-7.png)  
**Aprendizaje:** Pasar un parámetro de origen vacío (`:dest`) en un push actúa como instrucción para eliminar la rama remota.

---

### R2.8 - Pull arguments
**Objetivo:** Utilizar parámetros avanzados en `git pull` especifando refspecs de origen y destino.  
**Estado inicial:** Servidor con cambios específicos requeridos en ramas locales objetivo.

| Paso | Comando | Efecto sobre el repositorio |
|---:|---|---|
| 1 | `git pull origin foo:bar` | Descarga `foo` del remoto, la coloca en la rama local `bar` y la fusiona en la rama activa. |
| 2 | `git pull origin main:main` | Descarga `main` del remoto y actualiza la rama `main` local de forma directa. |

**Estado final:** Sincronización precisa de referencias remotas aplicadas a la rama de trabajo actual.

![Nivel completado](evidencias/r2-8.png)  
**Aprendizaje:** `git pull` acepta los mismos argumentos que `fetch` pero ejecuta la fusión inmediatamente después.

---

# Mapas de Progreso

### Mapa de Progreso Completo: Módulos Main
![Mapa de Progreso Main](evidencias/mapa-main.png)

### Mapa de Progreso Completo: Módulos Remote
![Mapa de Progreso Remote](evidencias/mapa-remote.png)

---

# Tabla Resumen de Progreso

| ID | Secuencia | Nivel | Estado |
|:---|:---|:---|:---:|
| M1.1 | Introduction Sequence | Introduction to Git Commits | Completado |
| M1.2 | Introduction Sequence | Branching in Git | Completado |
| M1.3 | Introduction Sequence | Merging in Git | Completado |
| M1.4 | Introduction Sequence | Rebase Introduction | Completado |
| M2.1 | Ramping Up | Detach yo’ HEAD | Completado |
| M2.2 | Ramping Up | Relative Refs (^) | Completado |
| M2.3 | Ramping Up | Relative Refs #2 (~) | Completado |
| M2.4 | Ramping Up | Reversing Changes in Git | Completado |
| M3.1 | Moving Work Around | Cherry-pick Intro | Completado |
| M3.2 | Moving Work Around | Interactive Rebase Intro | Completado |
| M4.1 | A Mixed Bag | Grabbing Just 1 Commit | Completado |
| M4.2 | A Mixed Bag | Juggling Commits | Completado |
| M4.3 | A Mixed Bag | Juggling Commits #2 | Completado |
| M4.4 | A Mixed Bag | Git Tags | Completado |
| M4.5 | A Mixed Bag | Git Describe | Completado |
| M5.1 | Advanced Topics | Rebasing over 9000 times | Completado |
| M5.2 | Advanced Topics | Multiple parents | Completado |
| M5.3 | Advanced Topics | Branch Spaghetti | Completado |
| R1.1 | Push & Pull - Git Remotes | Clone Intro | Completado |
| R1.2 | Push & Pull - Git Remotes | Remote Branches | Completado |
| R1.3 | Push & Pull - Git Remotes | Git Fetchin’ | Completado |
| R1.4 | Push & Pull - Git Remotes | Git Pullin’ | Completado |
| R1.5 | Push & Pull - Git Remotes | Faking Teamwork | Completado |
| R1.6 | Push & Pull - Git Remotes | Git Pushin’ | Completado |
| R1.7 | Push & Pull - Git Remotes | Diverged History | Completado |
| R1.8 | Push & Pull - Git Remotes | Locked Main | Completado |
| R2.1 | To Origin And Beyond - Advanced Git Remotes | Push Main! | Completado |
| R2.2 | To Origin And Beyond - Advanced Git Remotes | Merging with remotes | Completado |
| R2.3 | To Origin And Beyond - Advanced Git Remotes | Remote Tracking | Completado |
| R2.4 | To Origin And Beyond - Advanced Git Remotes | Git push arguments | Completado |
| R2.5 | To Origin And Beyond - Advanced Git Remotes | Git push arguments - Expanded! | Completado |
| R2.6 | To Origin And Beyond - Advanced Git Remotes | Fetch arguments | Completado |
| R2.7 | To Origin And Beyond - Advanced Git Remotes | Source of nothing | Completado |
| R2.8 | To Origin And Beyond - Advanced Git Remotes | Pull arguments | Completado |

---

# Síntesis de Conceptos Aprendidos

El recorrido completo a través de la plataforma interactive *Learn Git Branching* permite construir una comprensión profunda e intuitiva de los sistemas de control de versiones distribuidos. A diferencia de un enfoque mecánico basado exclusivamente en memorizar comandos, el análisis visual del árbol de commits demuestra que Git opera como un grafo acíclico dirigido (DAG) donde las referencias, ramas y punteros se desplazan con absoluta flexibilidad.

En los módulos iniciales de **Main**, el concepto fundamental radica en comprender que una rama es simplemente un puntero ligero que hace referencia a un hash o estado específico dentro de la historia. A través de mecanismos como `git checkout` y la navegación con referencias relativas (`^` y `~`), se comprende cómo el puntero especial `HEAD` interactúa con el espacio de trabajo. La diferencia crítica entre integrar trabajo mediante `git merge` y `git rebase` destaca dos filosofías distintas: la primera prioriza la preservación histórica genuina mediante commits de unión multi-padre, mientras que la segunda persigue una estructura de código estrictamente lineal, legible y secuencial mediante la reescritura de la base del trabajo.

Conforme avanzamos hacia el reordenamiento de trabajo con herramientas como `cherry-pick` y el rebase interactivo (`git rebase -i`), Git demuestra su capacidad para actuar como una herramienta de modelado de precisión. Es posible corregir errores pasados, reordenar soluciones, alterar commits específicos con `--amend` y etiquetar hitos críticos mediante `git tag`. Esta flexibilidad enseña que la historia local no es estática, sino una borrador modificable que debe ser refinado antes de hacerlo público.

Por otro lado, los módulos de **Remote** trasladan esta lógica al ámbito colaborativo. La sincronización distribuida añade una capa de complejidad donde existen representaciones locales de estados remotos, tales como `origin/main`. Comandos esenciales como `git fetch`, `git pull` y `git push` no son simplemente operaciones de descarga o carga de archivos, sino sincronizaciones explícitas entre los grafos locales y remotos. 

El aprendizaje más crítico en la gestión remota radica en el manejo de historias divergentes. Cuando múltiples desarrolladores trabajan sobre una misma base, es obligatorio resolver la divergencia antes de publicar. Esto se logra rebasando el trabajo local sobre las últimas actualizaciones del servidor o uniendo las dos líneas de desarrollo mediante fusiones explícitas. Finalmente, el uso de sintaxis avanzadas mediante refspecs (`<origen>:<destino>`) e instrucciones específicas de rastreo otorga un nivel de control granular indispensable para proyectos profesionales donde existen ramas protegidas, flujos de integración continua y despliegues automatizados.
