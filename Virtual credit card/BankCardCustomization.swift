//
//  BankCardCustomization.swift
//  Demo
//
//  Created by jatin foujdar on 12/08/26.
//


import SwiftUI

struct BankCardCustomization: View {
    @State private var colors: [ColorItem] = [
        ColorItem(colors: [Color(hex: "#8199AB")]),
        ColorItem(colors: [Color(hex: "#EC9E77")]),
        ColorItem(colors: [Color(hex: "#E8FF05").opacity(0.6)]),
        ColorItem(colors: [Color(hex: "#952CE6"),Color(hex: "#C74446"),Color(hex: "#F65A2E"),Color(hex: "#ECBF91")]),
        ColorItem(colors: [.purple]),
        ColorItem(colors: [.orange]),
        ColorItem(colors: [.pink, .purple, .yellow]), // Gradient
        ColorItem(colors: [.blue, .green]),  // Gradient
        ColorItem(colors: [.yellow, .orange]) // Gradient
    ]
    
    @State private var selectedColor: ColorItem = .init(colors: [Color(hex: "#952CE6"),Color(hex: "#C74446"),Color(hex: "#F65A2E"),Color(hex: "#ECBF91")])
    var body: some View {
        VStack {
            Spacer()
            
            ContentView(colorItem: $selectedColor)
            
            Spacer()
            
            VStack(alignment: .center, spacing: 16) {
                VStack(alignment: .center, spacing: 8) {
                    Text("Virtual credit card")
                        .font(.system(.title3, weight: .semibold))
                        .foregroundStyle(.primary)
                    Text("Create your own virtual card to manage your online payments and never worry about losing it")
                        .multilineTextAlignment(.center)
                        .font(.system(.subheadline, weight: .regular))
                        .foregroundStyle(.secondary)
                    
                }.padding(.horizontal, 16)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(colors) { colorItem in
                            colorCircle(colorItem: colorItem)
                                .frame(width: 40, height: 40)
                                .overlay(content: {
                                    Circle()
                                        .stroke(selectedColor.colors == colorItem.colors ? Color(hex: "#1218181B") : Color.clear, lineWidth: 2)
                                        .frame(width: 55, height: 55)
                                })
                                .onTapGesture {
                                    withAnimation(.smooth) {
                                        selectedColor = colorItem
                                    }
                                }
                        }
                    }
                    .padding()
                }
                .frame(height: 70)
                
                Button(action: {}, label: {
                    Text("Continue")
                        .font(.system(.headline, weight: .medium))
                        .frame(maxWidth: .infinity, alignment: .center)
                })
                .buttonStyle(CapsuleButtonStyle())
                .padding(.horizontal, 16)
            }
        }
    }
    
    @ViewBuilder
    func colorCircle(colorItem: ColorItem) -> some View {
        Circle()
            .fill(
                colorItem.isGradient ?
                LinearGradient(
                    colors: colorItem.colors,
                    startPoint: .leading,
                    endPoint: .trailing
                ) : LinearGradient(
                    colors: [colorItem.colors[0], colorItem.colors[0]],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
    }
}

// MARK: - Previews
#Preview(body: {
    BankCardCustomization()
})

// MARK: - Capsule Button Style
struct CapsuleButtonStyle: ButtonStyle {
    var backgroundColor: Color = .black
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(.title3))
            .foregroundColor(.white)
            .padding(16)
            .background(
                Capsule()
                    .fill(backgroundColor)
            )
            .clipShape(Capsule())
    }
}

// MARK: - Hex Color extension
fileprivate extension Color {
    // Basic hex color initializer
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
