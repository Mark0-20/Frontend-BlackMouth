//
//  ContentView.swift
//  BlackmouthFront
//
//  Created by Miguel Munoz on 13/06/25.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedCard: MenuItem? = nil
    @State private var menuItems: [MenuItem] = []
    @State private var errorMessage: String?
    @StateObject private var apiService = APIService() // Instancia del servicio API
    @State private var showingAddSheet: Bool = false



    var body: some View {
        NavigationView {
            HStack(spacing: 0) {
               
                VStack {
                    Image(systemName: "circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.white)
                        .padding(.top, 20)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Spacer()

                    VStack(spacing: 25) {
                        Image(systemName: "fork.knife")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.white)
                        Image(systemName: "takeoutbag.and.cup.and.straw")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.white)
                        Image(systemName: "cup.and.saucer")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.white)
                        Image(systemName: "cart")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.white)
                        Image(systemName: "phone")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 30)
                    Spacer()
                    
                    Button {
                                           showingAddSheet = true
                                       } label: {
                                           Image(systemName: "plus.circle.fill")
                                               .font(.largeTitle)
                                               .foregroundColor(.green)
                                       }
                                       .padding(.bottom, 20)
                }
                .frame(minWidth: 60, maxWidth: 90)
                .frame(maxHeight: .infinity)
                .padding(.leading, 10)
                .background(Color.black)

                ScrollView {
                    VStack(alignment: .center) {
                        if let errorMessage = errorMessage {
                            Text("Error: \(errorMessage)")
                                .foregroundColor(.red)
                                .padding()
                        } else if menuItems.isEmpty {
                            ProgressView("Cargando menú...")
                                .padding()
                        } else {
                            // Filtra los items por categoría
                            Text("Hamburguesas")
                                .font(.largeTitle)
                                .padding(.bottom, 20)

                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(menuItems.filter { $0.category == "Comida rápida" }) { item in
                                        Button {
                                            selectedCard = item
                                        } label: {
                                            
                                            MenuItemView(imageURL: item.imageURL, title: item.name)
                                        }
                                    }
                                }
                                .padding(.bottom, 10)
                            }

                            Text("Bebidas")
                                .font(.largeTitle)
                                .padding(.top, 20)
                                .padding(.bottom, 20)

                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(menuItems.filter { $0.category == "Bebidas" }) { item in
                                        Button {
                                            selectedCard = item
                                        } label: {
                                            MenuItemView(imageURL: item.imageURL, title: item.name)
                                        }
                                    }
                                }
                            }
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 50)
                    .frame(maxWidth: 800)
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(width: NSScreen.main!.visibleFrame.width, height: NSScreen.main!.visibleFrame.height)
            .sheet(item: $selectedCard) { card in
                CardView(card: card) {
                    selectedCard = nil
                }
            }
            
            .sheet(isPresented: $showingAddSheet) {
                AddMenuItemView(apiService: apiService)
                    .onDisappear {
                        Task {
                            await loadMenuItems()
                        }
                    }
            }
        }
        .task {
            await loadMenuItems()
        }
    }

    func loadMenuItems() async {
        do {
            menuItems = try await apiService.fetchMenuItems()
        } catch {
            errorMessage = error.localizedDescription
            print("Error al cargar los elementos del menú: \(error)")
        }
    }
}

struct MenuItemView: View {
    var imageURL: String?
    var title: String

    var body: some View {
        VStack {
            if let urlString = imageURL, let url = URL(string: urlString) {
                AsyncImage(url: url) { image in
                    image.resizable()
                        .scaledToFit()
                        .frame(width: 130, height: 130)
                } placeholder: {
                    ProgressView()
                        .frame(width: 130, height: 130)
                }
            } else {
                
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 130, height: 130)
                    .foregroundColor(.gray)
            }

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
