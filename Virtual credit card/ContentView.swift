//
//  ContentView.swift
//  Demo
//
//  Created by jatin foujdar on 12/08/26.
//

import SwiftUI

struct ContentView: View {
    @Binding var colorItem: ColorItem
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(colorItem.isGradient ?
                      LinearGradient(
                          colors: colorItem.colors,
                          startPoint: .leading,
                          endPoint: .trailing
                      ) :
                          LinearGradient(
                              colors: [colorItem.colors[0], colorItem.colors[0]],
                              startPoint: .leading,
                              endPoint: .trailing
                          ))
                .frame(width: 372, height: 233)
                .shadow(color: Color(.systemYellow).opacity(0.2), radius: 45)
            
            VStack(alignment: .leading){
                HStack{
                    Text("SoftBack")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                    
                    Spacer()
                    
                        .padding(.top, 18)
                        .padding(.leading, 29)
                }
                HStack{
                    Spacer()
                    HStack(spacing: -18) {
                        Circle()
                            .fill(.white.opacity(0.4))
                            .frame(width: 36, height: 36)
                        Circle()
                            .fill(.white.opacity(0.4))
                            .frame(width: 36, height: 36)
                    }
                }
                .padding(.horizontal, 33)
                .padding(.bottom, 20)
                
            }
        }
        .frame(width: 372, height: 233)
        .rotationEffect(.degrees(-90))
        .padding()
    }
}

struct ColorItem: Identifiable {
    let id = UUID()
    let colors: [Color]
    var isGradient: Bool {
        colors.count > 1
    }
}

#Preview {
    ContentView(
        colorItem: .constant(
            ColorItem(colors: [.blue])
        )
    )
}
