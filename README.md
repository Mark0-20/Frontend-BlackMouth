# Frontend-BlackMouth
Frontend de proyecto MacOs BlackMouth


# 🍟 Frontend BlackMouth

Tema del proyecto: Menú digital de hamburguesería – BlackMouth 🍔

Integrantes del equipo:

Marco Antonio Hernández Magaña

Sebastián Mendoza Sosa

Miguel Muñoz Hernández

Máximo Núñez Mireles

Daniel Solís Padierna

URL de la API desplegada:
🔗 https://urchin-app-p4aaq.ondigitalocean.app/menu_items

Frontend para la aplicación **BlackMouth**, una plataforma de menú digital para un restaurante de hamburguesas. Desarrollado con **SwiftUI** y consumo de API REST usando `URLSession`.

## 🧩 Tecnologías utilizadas

- Swift 5+
- SwiftUI
- MVVM (Modelo-Vista-VistaModelo)
- URLSession (consumo de API)
- SDWebImageSwiftUI (carga de imágenes desde URLs)

## 🖼️ Características principales

- Visualización dinámica de ítems del menú desde un backend en Vapor
- Interfaz moderna y responsiva con SwiftUI
- Carga de imágenes desde URLs usando `SDWebImageSwiftUI`

## 📦 Estructura del proyecto

```
Frontend-BlackMouth/
├── Models/
│   └── MenuItem.swift
├── Views/
│   ├── ContentView.swift
│   └── CardView.swift
├── ViewModels/
│   └── MenuViewModel.swift
├── Services/
│   └── MenuService.swift
├── Assets/
└── Info.plist
```


## 🔌 Conexión al Backend

Este frontend se conecta a la API de Vapor desplegada en DigitalOcean:

```
https://urchin-app-p4aaq.ondigitalocean.app/menu_items
```

El modelo de datos esperado por el frontend es el siguiente:

```json
{
  "id": "627FA821-4A25-11F0-A440-EAB4945E15B5",
  "category": "Comida rápida",
  "name": "Hamburguesa",
  "imageURL": "https://example.com/img/hamburguesa.jpg"
}
```

## ▶️ Ejecución

1. Abre el proyecto con Xcode.
2. Asegúrate de tener una conexión activa a internet.
3. Ejecuta el proyecto en un simulador o dispositivo.

## 📲 Requisitos

- Xcode 14 o superior
- iOS 15+

## 🧪 Pruebas

- Verifica que los ítems del menú se carguen correctamente al iniciar la app.
- Las imágenes deben mostrarse usando la URL proporcionada por el backend.

