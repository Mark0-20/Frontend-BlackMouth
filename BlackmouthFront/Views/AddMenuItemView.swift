//
//  AddMenuItemView.swift
//  BlackmouthFront
//
//  Created by Sebastian Mendoza Sosa on 6/17/25.
//

import SwiftUI

struct AddMenuItemView: View {
    @Environment(\.dismiss) var dismiss
    @State private var name: String = ""
    @State private var description: String = ""
    @State private var price: String = ""
    @State private var category: String = "Comida rápida"
    @State private var imageURL: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""

    @ObservedObject var apiService: APIService // Recibe el servicio de la vista principal

    
    let categories = ["Comida rápida", "Bebidas"]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Detalles del Item")) {
                    TextField("Nombre", text: $name)
                    TextField("Descripción", text: $description)
                    TextField("Precio", text: $price)
                    
                    Picker("Categoría", selection: $category) {
                        ForEach(categories, id: \.self) {
                            Text($0)
                        }
                    }
                    TextField("URL de la Imagen (opcional)", text: $imageURL)
                }

                Button("Agregar Item") {
                    Task {
                        await saveMenuItem()
                    }
                }
                .disabled(name.isEmpty || description.isEmpty || price.isEmpty) // Deshabilitar si falta información
            }
            .navigationTitle("Nuevo Item de Menú")
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
            }
            .alert("Error", isPresented: $showAlert) {
                Button("OK") { }
            } message: {
                Text(alertMessage)
            }
        }
    }

    private func saveMenuItem() async {
        guard let itemPrice = Double(price) else {
            alertMessage = "Por favor, ingresa un precio válido."
            showAlert = true
            return
        }

        let newItem = MenuItem(
            id: nil, // El ID será generado por el backend
            name: name,
            description: description,
            price: itemPrice,
            category: category,
            imageURL: imageURL.isEmpty ? nil : imageURL // Envía nil si está vacío
        )

        do {
            let createdItem = try await apiService.createMenuItem(item: newItem)
            print("Item creado exitosamente: \(createdItem)")
            
            dismiss()
        } catch {
            alertMessage = error.localizedDescription
            showAlert = true
            print("Error al crear item: \(error)")
        }
    }
}
