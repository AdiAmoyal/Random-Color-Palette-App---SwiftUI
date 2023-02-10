//
//  ColorCardView.swift
//  Random Color Palette App
//
//  Created by Adi Amoyal on 09/02/2023.
//

import SwiftUI

struct ColorCardView: View {
    var color: Color
    @Binding var copiedColor: String
    @Binding var isMessageShowing: Bool
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(color)
                .cornerRadius(5)
                .frame(maxWidth: 130, maxHeight: 130)
                .onTapGesture {
                    var hexCode = color.uiColor.hexString
                    UIPasteboard.general.string = hexCode
                    copiedColor = hexCode
                    isMessageShowing = true
                }
            Text("\(color.uiColor.hexString)")
        }
    }
}

extension Color {
    var uiColor: UIColor {
        let components = self.components()
        return UIColor(red: components.r, green: components.g, blue: components.b, alpha: components.a)
    }

    private func components() -> (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        let color = self.description.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: color).scanHexInt64(&int)
        let a, r, g, b: CGFloat
        switch color.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (1, CGFloat((int & 0xF00) >> 8) / 15.0, CGFloat((int & 0x0F0) >> 4) / 15.0, CGFloat(int & 0x00F) / 15.0)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (1, CGFloat((int & 0xFF0000) >> 16) / 255.0, CGFloat((int & 0x00FF00) >> 8) / 255.0, CGFloat(int & 0x0000FF) / 255.0)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (CGFloat((int & 0xFF000000) >> 24) / 255.0, CGFloat((int & 0x00FF0000) >> 16) / 255.0, CGFloat((int & 0x0000FF00) >> 8) / 255.0, CGFloat(int & 0x000000FF) / 255.0)
        default:
            (a, r, g, b) = (1, 0, 0, 0)
        }
        return (r, g, b, a)
    }
}

extension UIColor {
    var hexString: String {
        let color = self.cgColor.components!
        let r = color[0]
        let g = color[1]
        let b = color[2]
        return String(format: "#%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)))
    }
}



//struct ColorCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        ColorCardView()
//    }
//}
