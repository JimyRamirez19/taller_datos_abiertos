# Taller: Datos Abiertos de Colombia

Aplicación móvil desarrollada con Flutter que consulta y presenta información de Colombia mediante la API pública de datos de Colombia.

## Descripción del proyecto

La aplicación permite consultar información organizada en cuatro categorías:

- Departamentos de Colombia.
- Regiones de Colombia.
- Presidentes de Colombia.
- Atracciones turísticas de Colombia.

El usuario puede ingresar a una categoría, visualizar el listado de elementos y seleccionar uno para consultar su información detallada.

## Tecnologías utilizadas

- **Flutter:** desarrollo de la aplicación móvil.
- **Dart:** lenguaje de programación.
- **HTTP:** realización de solicitudes a la API.
- **GoRouter:** navegación entre pantallas.
- **flutter_dotenv:** configuración de la URL base mediante variables de entorno.

## API utilizada

Se utiliza la API pública de Colombia:

https://api-colombia.com/api/v1

### Endpoints consultados

| Categoría | Endpoint |
|---|---|
| Departamentos | `/Department` |
| Regiones | `/Region` |
| Presidentes | `/President` |
| Atracciones turísticas | `/TouristicAttraction` |

La aplicación realiza solicitudes HTTP para obtener los datos y presentar la información al usuario.

## Configuración del proyecto

La URL base se configura mediante un archivo `.env` ubicado en la raíz del proyecto:

```dotenv
API_BASE_URL=https://api-colombia.com/api/v1
```

El archivo `.env` debe estar incluido como recurso en la configuración de Flutter.

## Instalación y ejecución

### Requisitos previos

- Flutter instalado y configurado.
- Dart incluido con Flutter.
- Android Studio o un dispositivo compatible.
- Conexión a internet para consultar la API.

### Pasos

1. Clonar el repositorio:

   ```bash
   git clone https://github.com/JimyRamirez19/taller_datos_abiertos.git
   ```

2. Entrar a la carpeta del proyecto:

   ```bash
   cd taller_datos_abiertos
   ```

3. Instalar las dependencias:

   ```bash
   flutter pub get
   ```

4. Verificar la configuración del archivo `.env`.

5. Ejecutar el análisis estático:

   ```bash
   flutter analyze
   ```

6. Ejecutar la aplicación:

   ```bash
   flutter run
   ```

## Arquitectura del proyecto

La aplicación está organizada por responsabilidades para facilitar su mantenimiento:

- **`lib/models/`:** modelos para representar los datos obtenidos de la API.
- **`lib/routes/`:** configuración de las rutas de navegación.
- **`lib/services/`:** servicios encargados de las solicitudes HTTP.
- **`lib/views/dashboard/`:** pantalla principal con las categorías.
- **`lib/views/listing/`:** pantalla de listados.
- **`lib/views/detail/`:** pantalla de información detallada.
- **`capturas/`:** evidencias visuales del funcionamiento de la aplicación.

## Navegación

La aplicación cuenta con las siguientes rutas:

| Ruta | Función |
|---|---|
| `/` | Pantalla principal. |
| `/listing/:category` | Listado de una categoría. |
| `/detail/:category/:id` | Detalle de un elemento seleccionado. |

Los parámetros `category` e `id` permiten identificar la categoría consultada y el elemento que se desea visualizar.

## Manejo de estados

Las pantallas de consulta contemplan los siguientes estados:

- **Carga:** indica que se está realizando una solicitud.
- **Éxito:** muestra los datos recibidos de la API.
- **Error:** informa que ocurrió un problema al consultar los datos y permite intentar nuevamente.
- **Sin resultados:** contempla una respuesta sin elementos, cuando corresponde.

## Evidencias de funcionamiento

Las capturas de pantalla se encuentran en la carpeta `capturas/`.

| Evidencia | Archivo |
|---|---|
| Pantalla principal | `capturas/dashboard.png` |
| Listado de departamentos | `capturas/listado_departamentos.png` |
| Detalle de departamento | `capturas/detalle_departamento.png` |
| Estado de carga | `capturas/estado_carga.png` |
| Estado de error | `capturas/estado_error.png` |

> Nota: agrega la captura `estado_error.png` cuando la tengas disponible.

## Control de versiones

El proyecto utiliza Git y GitHub para el control de versiones y el flujo de trabajo con ramas.

Repositorio: https://github.com/JimyRamirez19/taller_datos_abiertos

Rama de trabajo: `feature/taller_api_colombia`

## Autoría

Proyecto académico desarrollado como parte del taller de creación de aplicaciones móviles con Flutter.