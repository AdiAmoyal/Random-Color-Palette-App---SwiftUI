//
//  Colors.swift
//  Random Color Palette App
//
//  Created by Adi Amoyal on 09/02/2023.
//

import Foundation
import SwiftUI

class Colors: ObservableObject {
    @Published var colors: [Color]
    
    init() {
        colors = []
        Task { await fetchColors() }
    }
    
    func fetchColors() async {
        do { self.colors = try await ColormindAPI.generateColorPalette() }
        catch { print(error) }
    }
}
