//
//  EditMenuItemView.swift
//  BlackmouthFront
//
//  Created by Sebastian Mendoza Sosa on 6/17/25.
//


import SwiftUI

struct EditMenuItemView: View {
    @Environment(\.dismiss) var dismiss
    @State private var name: String
    @State private var description: String
    @State private var price: String
    @State private var category: String
    @State private var imageURL: String
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""

    @ObservedObject var apiService: APIService
    var menuItemToEdit: MenuItem // El ítem que se va a editar

    let categories = ["Comida rápida", "Bebidas"]

    init(apiService: APIService, menuItem: MenuItem) {
        self.apiService = apiService
        self.menuItemToEdit = menuItem
        
        _name = State(initialValue: menuItem.name)
        _description = State(initialValue: menuItem.description)
        _price = State(initialValue: String(format: "%.2f", menuItem.price))
        _category = State(initialValue: menuItem.category)
        _imageURL = State(initialValue: menuItem.imageURL ?? "")
    }

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

                Button("Guardar Cambios") {
                    Task {
                        await saveChanges()
                    }
                }
                .disabled(name.isEmpty || description.isEmpty || price.isEmpty)
            }
            .navigationTitle("Editar Item")
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

    private func saveChanges() async {
        guard let itemPrice = Double(price) else {
            alertMessage = "Por favor, ingresa un precio válido."
            showAlert = true
            return
        }

        // Crea una copia mutable del item para actualizar
        var updatedItem = menuItemToEdit
        updatedItem.name = name
        updatedItem.description = description
        updatedItem.price = itemPrice
        updatedItem.category = category
        updatedItem.imageURL = imageURL.isEmpty ? nil : imageURL

        do {
            let result = try await apiService.updateMenuItem(item: updatedItem)
            print("Item actualizado exitosamente: \(result)")
            dismiss() // Cierra la hoja modal al guardar
        } catch {
            alertMessage = error.localizedDescription
            showAlert = true
            print("Error al actualizar item: \(error)")
        }
    }
}
