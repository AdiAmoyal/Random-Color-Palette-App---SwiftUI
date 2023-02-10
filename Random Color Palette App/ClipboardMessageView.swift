//
//  ClipboardMessageView.swift
//  Random Color Palette App
//
//  Created by Adi Amoyal on 09/02/2023.
//

import SwiftUI

struct ClipboardMessageView: View {
    @Binding var color: String
    
    var body: some View {
        Text("Color \(color) copied to your clipboard")
            .frame(maxWidth: .infinity)
            .padding(7)
            .multilineTextAlignment(.center)
            .background(Color(red: 0.0, green: 0.42745098039215684, blue: 0.4666666666666667, opacity: 0.8))
            .foregroundColor(.white)
            .cornerRadius(30)
            .font(.body)
    }
}

