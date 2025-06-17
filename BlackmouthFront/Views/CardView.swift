//
//  CardView.swift
//  BlackmouthFront
//
//  Created by Miguel Munoz on 14/06/25.
//

import Foundation
import SwiftUI

struct CardView: View {
    var card: MenuItem
    var onClose: () -> Void
    var onEdit: (MenuItem) -> Void
    var onDelete: (MenuItem) async -> Void

        @State private var showingDeleteConfirm: Bool = false

        var body: some View {
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    Button(action: {
                        onClose()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title)
                            .foregroundColor(.black)
                    }
                }
                .padding(.bottom, 10)

                Text(card.name)
                    .font(.title)
                    .padding(.bottom, 10)

                if let imageURLString = card.imageURL,
                   let url = URL(string: imageURLString) {
                    AsyncImage(url: url) { image in
                        image.resizable()
                            .scaledToFit()
                            .frame(height: 120)
                            .cornerRadius(10)
                    } placeholder: {
                        ProgressView()
                            .frame(height: 120)
                    }
                    .padding(.bottom, 10)
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 120)
                        .cornerRadius(10)
                        .padding(.bottom, 10)
                }

                HStack {
                    VStack(alignment: .leading) {
                        Text("Descripción")
                            .font(.headline)
                        Text(card.description)
                            .font(.subheadline)
                    }

                    Spacer()

                    VStack(alignment: .trailing) {
                        Text("Precio")
                            .font(.headline)
                        Text("$\(String(format: "%.2f", card.price))")
                            .font(.title3.bold())
                            .foregroundColor(.white)
                            .padding(8)
                            .background(Color.black)
                            .cornerRadius(8)
                    }
                }
                .padding(.top, 10)

                Spacer()

                // Botones de Editar y Eliminar
                HStack {
                    Button(action: {
                        onEdit(card)
                    }) {
                        Label("Editar", systemImage: "pencil.circle.fill")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                            .background(Color.white)
                            .cornerRadius(8)
                    }

                    Spacer()

                    Button(action: {
                        showingDeleteConfirm = true // Muestra la alerta de confirmación
                    }) {
                        Label("Eliminar", systemImage: "trash.circle.fill")
                            .font(.headline)
                            .foregroundColor(.red)
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                            .background(Color.white)
                            .cornerRadius(8)
                    }
                }
                .padding(.top, 20)
            }
            .padding()
            .background(Color.black)
            .cornerRadius(15)
            .foregroundColor(.white)
            .padding()
            // Alerta de confirmación para eliminar
            .alert("Confirmar Eliminación", isPresented: $showingDeleteConfirm) {
                Button("Eliminar", role: .destructive) {
                    Task {
                        await onDelete(card) // Llama a la acción de eliminación
                    }
                }
                Button("Cancelar", role: .cancel) { }
            } message: {
                Text("¿Estás seguro de que quieres eliminar '\(card.name)'?")
            }
        }
    }


struct MenuItem: Identifiable, Codable {
    var id: UUID?
    var name: String
    var description: String
    var price: Double
    var category: String
    var imageURL: String?
    
    enum CodingKeys: String, CodingKey {
            case id, name, description, price, category, imageURL
        }

        init(id: UUID? = nil, name: String, description: String, price: Double, category: String, imageURL: String? = nil) {
            self.id = id
            self.name = name
            self.description = description
            self.price = price
            self.category = category
            self.imageURL = imageURL
        }


    

}
