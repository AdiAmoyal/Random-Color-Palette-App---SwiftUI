//
//  ColormindAPI.swift
//  Random Color Palette App
//
//  Created by Adi Amoyal on 09/02/2023.
//

import Foundation
import SwiftUI

struct ColormindAPI {
    static private let endpoint = URL(string: "http://colormind.io/api/")
    static private let params: String = "{\"model\": \"default\"}"
    
    static func generateColorPalette() async throws -> [Color] {
        var colors: [Color] = []
        var apiReq = URLRequest(url: self.endpoint!)
        apiReq.httpMethod = "POST"
        apiReq.httpBody = params.data(using: .utf8)
        apiReq.setValue("application/json", forHTTPHeaderField: "Content-Type")
        apiReq.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let (data, _) = try await URLSession.shared.data(for: apiReq)
        let colorPalette = try JSONDecoder().decode(ColorPalette.self, from: data)

        colors = colorPalette.result.map { color in
            Color(red: Double(color[0]) / 255, green: Double(color[1]) / 255, blue: Double(color[2]) / 255)
        }

        return colors
    }
}
