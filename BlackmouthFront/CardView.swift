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

            Text(card.name) // Usar card.name
                .font(.title)
                .padding(.bottom, 10)

            // Cargar imagen desde URL
            if let imageURLString = card.imageURL,
               let url = URL(string: imageURLString) {
                AsyncImage(url: url) { image in
                    image.resizable()
                        .scaledToFit()
                        .frame(height: 120)
                        .cornerRadius(10)
                } placeholder: {
                    ProgressView() // Mientras carga la imagen
                        .frame(height: 120)
                }
                .padding(.bottom, 10)
            } else {
                // Imagen por defecto si no hay URL o si falla
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 120)
                    .cornerRadius(10)
                    .padding(.bottom, 10)
            }

            HStack {
                VStack(alignment: .leading) {
                    Text("Descripción") // Cambiado a descripción ya que no tienes ingredientes específicos en el backend
                        .font(.headline)
                    Text(card.description) // Mostrar la descripción
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
        }
        .padding()
        .background(Color.black)
        .cornerRadius(15)
        .foregroundColor(.white)
        .padding()
    }
}

struct MenuItem: Identifiable, Codable { // Cambié a MenuItem para reflejar el backend y añadí Codable
    let id: UUID? // El ID puede ser opcional al crear un nuevo item
    var name: String
    var description: String
    var price: Double
    var category: String
    var imageURL: String? // imageURL en el backend, no imageName

    
    var id: UUID? {
        return _id
    }
}
