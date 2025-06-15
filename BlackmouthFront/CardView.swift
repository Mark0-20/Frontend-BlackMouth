//
//  CardView.swift
//  BlackmouthFront
//
//  Created by Miguel Munoz on 14/06/25.
//

import SwiftUI

struct CardView: View {
    var card: CardData
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
            
            Text(card.title)
                .font(.title)
                .padding(.bottom, 10)
            
            Image(card.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 120)
                .cornerRadius(10)
                .padding(.bottom, 10)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Ingredientes")
                        .font(.headline)
                    ForEach(card.ingredients, id: \.self) { item in
                        Text("\u{2022} \(item)")
                            .font(.subheadline)
                    }
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

struct CardData: Identifiable, Equatable {
    let id = UUID()
    var title: String
    var imageName: String
    var ingredients: [String]
    var price: Double
} 
