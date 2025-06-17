//
//  ApiService.swift
//  BlackmouthFront
//
//  Created by Sebastian Mendoza Sosa on 6/16/25.
//


import Foundation

enum APIError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingError(Error)
    case custom(error: String)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "La URL no es válida."
        case .invalidResponse:
            return "Respuesta del servidor inválida."
        case .decodingError(let error):
            return "Error al decodificar los datos: \(error.localizedDescription)"
        case .custom(let error):
            return error
        }
    }
}

class APIService: ObservableObject {
    private let baseURL = URL(string: "https://urchin-app-p4aaq.ondigitalocean.app/menu_items")!

    func fetchMenuItems() async throws -> [MenuItem] {
        guard let url = URL(string: "/menu_items", relativeTo: baseURL) else {
            throw APIError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw APIError.invalidResponse
        }

        do {
            let decoder = JSONDecoder()
          
            return try decoder.decode([MenuItem].self, from: data)
        } catch {
            throw APIError.decodingError(error)
        }
    }

    func createMenuItem(item: MenuItem) async throws -> MenuItem {
           guard let url = URL(string: "/menu_items", relativeTo: baseURL) else {
               throw APIError.invalidURL
           }

           var request = URLRequest(url: url)
           request.httpMethod = "POST"
           request.setValue("application/json", forHTTPHeaderField: "Content-Type")

           let encoder = JSONEncoder()
           var itemToSend = item
           itemToSend.id = nil

           request.httpBody = try encoder.encode(itemToSend)

           let (data, response) = try await URLSession.shared.data(for: request)

           guard let httpResponse = response as? HTTPURLResponse,
                 (200...299).contains(httpResponse.statusCode) else {
               throw APIError.invalidResponse
           }

           do {
               return try JSONDecoder().decode(MenuItem.self, from: data)
           } catch {
               throw APIError.decodingError(error)
           }
       }
    
    func updateMenuItem(item: MenuItem) async throws -> MenuItem {
            guard let itemID = item.id else {
                throw APIError.custom(error: "El ID del item es necesario para actualizar.")
            }
            guard let url = URL(string: "/menu_items/\(itemID.uuidString)", relativeTo: baseURL) else {
                throw APIError.invalidURL
            }

            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

           
            request.httpBody = try JSONEncoder().encode(item)

            let (data, response) = try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                if let responseData = String(data: data, encoding: .utf8) {
                    print("API Error Response (update): \(responseData)")
                }
                throw APIError.invalidResponse
            }

            do {
                return try JSONDecoder().decode(MenuItem.self, from: data)
            } catch {
                throw APIError.decodingError(error)
            }
        }

        func deleteMenuItem(item: MenuItem) async throws {
            guard let itemID = item.id else {
                throw APIError.custom(error: "El ID del item es necesario para eliminar.")
            }
            guard let url = URL(string: "/menu_items/\(itemID.uuidString)", relativeTo: baseURL) else {
                throw APIError.invalidURL
            }

            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"

            let (_, response) = try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                
                throw APIError.invalidResponse
            }
           
        }

}
