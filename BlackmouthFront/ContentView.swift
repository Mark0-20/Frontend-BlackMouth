//
//  ContentView.swift
//  BlackmouthFront
//
//  Created by Miguel Munoz on 13/06/25.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedCard: CardData? = nil

    let burgers = [
        CardData(title: "Clásica",
                 imageName: "classic_burger",
                 ingredients: ["Carne de res", "Lechuga", "Jitomate", "Cebolla", "Pepinillos", "Queso amarillo"],
                 price: 79.00),
        CardData(title: "Doble",
                 imageName: "double_burger",
                 ingredients: ["Doble carne", "Lechuga", "Jitomate", "Cebolla", "Pepinillos", "Queso doble"],
                 price: 99.00),
        CardData(title: "Cheese",
                 imageName: "cheese_burger",
                 ingredients: ["Carne de res", "Queso cheddar", "Tocino", "Cebolla caramelizada", "Pan brioche"],
                 price: 89.00),
        CardData(title: "Boneless",
                 imageName: "boneless_burger",
                 ingredients: ["Boneless BBQ", "Lechuga", "Jitomate", "Aderezo ranch", "Pan artesanal"],
                 price: 85.00),
    ]

    let drinks = [
        CardData(title: "Coca-cola",
                 imageName: "coca_cola",
                 ingredients: ["Refresco de cola", "355ml bien fría"],
                 price: 25.00),
        CardData(title: "Cerveza",
                 imageName: "beer",
                 ingredients: ["Botella 355ml", "Marca local o importada"],
                 price: 35.00),
        CardData(title: "Jamaica",
                 imageName: "jamaica",
                 ingredients: ["Agua de jamaica natural", "Endulzada con poca azúcar"],
                 price: 20.00),
        CardData(title: "Naranja",
                 imageName: "orange_juice",
                 ingredients: ["Jugo natural de naranja", "Exprimido al momento"],
                 price: 22.00),
    ]

    var body: some View {
        NavigationView {
            HStack(spacing: 0) {
                VStack {
                    Image(systemName: "circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(Color.white)
                        .padding(.top, 20)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Spacer()

                    VStack(spacing: 30) {
                        Image(systemName: "fork.knife")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color.white)
                        Image(systemName: "takeoutbag.and.cup.and.straw")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color.white)
                        Image(systemName: "cup.and.saucer")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color.white)
                        Image(systemName: "cart")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color.white)
                        Image(systemName: "phone")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color.white)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 40)

                    Spacer()
                }
                .frame(width: 70)
                .frame(maxHeight: .infinity)
                .padding(.leading, 10)
                .background(Color.black)

                Spacer()

                VStack(alignment: .leading) {
                    Text("Hamburguesas")
                        .font(.largeTitle)
                        .padding(.bottom, 20)

                    HStack {
                        ForEach(burgers) { item in
                            Button {
                                selectedCard = item
                            } label: {
                                MenuItemView(imageName: item.imageName, title: item.title)
                            }
                        }
                    }

                    Text("Bebidas")
                        .font(.largeTitle)
                        .padding(.top, 20)
                        .padding(.bottom, 20)

                    HStack {
                        ForEach(drinks) { item in
                            MenuItemView(imageName: item.imageName, title: item.title)
                        }
                    }

                    Spacer()
                }
                .padding()
            }
            .sheet(item: $selectedCard) { card in
                CardView(card: card) {
                    selectedCard = nil
                }
            }
        }
    }
}

struct MenuItemView: View {
    var imageName: String
    var title: String

    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .frame(width: 100, height: 100)
            Text(title)
                .font(.headline)
            Text("ver más")
                .font(.subheadline)
                .padding(5)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(5)
        }
        .padding()
    }
}
