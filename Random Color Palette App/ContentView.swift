//
//  ContentView.swift
//  Random Color Palette App
//
//  Created by Adi Amoyal on 08/02/2023.
//

import SwiftUI
import Foundation

struct ContentView: View {
    @StateObject var motionManager = MotionManager()
    @StateObject var colors = Colors()
    @State var copiedColor: String = Color.black.uiColor.hexString
    @State var isMessageShowing: Bool = false
    @State var isShaking = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Style.backgroundColor)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                Text("Color Palette Generator")
                    .font(.largeTitle)
                    .fontWeight(.thin)
                    .multilineTextAlignment(.center)
                    .padding(.vertical)

                Spacer()
            
                if isMessageShowing {
                    ClipboardMessageView(color: $copiedColor)
                } else {
                    Text("")
                        .padding(10)
                }
                
                GeometryReader { geometry in
                    VStack {
                        Spacer()
                        
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 10) {
                            ForEach(colors.colors, id: \.self) { color in
                                ColorCardView(color: color, copiedColor: $copiedColor, isMessageShowing: $isMessageShowing)
                                    .frame(minWidth: geometry.size.width * 0.2, minHeight: geometry.size.height * 0.25)
                            }
                        }
                        
                        Spacer()
                        
                        Button("Generate Palette") {
                            Task {
                                await colors.fetchColors()
                                isMessageShowing = false
                            }
                        }
                        .font(.title3)
                        .fontWeight(.light)
                        .frame(maxWidth: .infinity)
                        .padding([.vertical], 7)
                        .background(Style.buttonColor)
                        .cornerRadius(40)
                        
                        Text("Or just shake your phone to generate new palettes")
                            .frame(maxWidth: .infinity)
                            .font(.footnote)
                            .fontWeight(.medium)
                            .multilineTextAlignment(.center)
                    }
                }
                
                Spacer()
                
                VStack {
                    Spacer()
                    
                    Text("Click to copy individual color")
                        .frame(maxWidth: .infinity)
                        .padding([.vertical], 9)
                        .background(Style.backgroundColorText)
                        .cornerRadius(40)
                        .font(.footnote)
                }
                .buttonStyle(.plain)
                .frame(height: UIScreen.main.bounds.height * 0.1)
            }
            .padding(.horizontal)
            .foregroundColor(Style.textColor)
        }
        .onChange(of: motionManager.isShaking) { newValue in
            Task {
                if newValue {
                    await colors.fetchColors()
                    isMessageShowing = false
                }
            }
        }
    }
}

struct Style {
    static var textColor = /*@START_MENU_TOKEN@*/Color(red: 0.0, green: 0.42745098039215684, blue: 0.4666666666666667)/*@END_MENU_TOKEN@*/
    static var backgroundColor = Color(hue: 0.542, saturation: 0.035, brightness: 0.971, opacity: 0.548)
    static var buttonColor = Color(red: 0.514, green: 0.773, blue: 0.743, opacity: 0.607)
    static var backgroundColorText = Color(hue: 1.0, saturation: 0.0, brightness: 0.494, opacity: 0.1)
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
