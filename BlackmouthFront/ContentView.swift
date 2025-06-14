//
//  ContentView.swift
//  BlackmouthFront
//
//  Created by Miguel Munoz on 13/06/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Image(systemName: "circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                    Spacer()
                    Image(systemName: "hamburger")
                        .resizable()
                        .frame(width: 30, height: 30)
                    Image(systemName: "fries")
                        .resizable()
                        .frame(width: 30, height: 30)
                    Image(systemName: "drink")
                        .resizable()
                        .frame(width: 30, height: 30)
                    Image(systemName: "cart")
                        .resizable()
                        .frame(width: 30, height: 30)
                    Image(systemName: "phone")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
                .padding()
                .background(Color.black)
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("Hamburguesas ")
                        .font(.largeTitle)
                        .padding(.bottom, 20)
                    
                    HStack {
                        MenuItemView(imageName: "classic_burger", title: "Clásica")
                        MenuItemView(imageName: "double_burger", title: "Doble")
                        MenuItemView(imageName: "cheese_burger", title: "Cheese")
                        MenuItemView(imageName: "boneless_burger", title: "Boneless")
                    }
                    
                    Text("Bebidas")
                        .font(.largeTitle)
                        .padding(.top, 20)
                        .padding(.bottom, 20)
                    
                    HStack {
                        MenuItemView(imageName: "coca_cola", title: "Coca-cola")
                        MenuItemView(imageName: "beer", title: "Cerveza")
                        MenuItemView(imageName: "jamaica", title: "Jamaica")
                        MenuItemView(imageName: "orange_juice", title: "Naranja")
                    }
                }
                .padding()
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
            Button(action: {
                // Acción para "ver más"
            }) {
                Text("ver más")
                    .font(.subheadline)
                    .padding(5)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(5)
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
