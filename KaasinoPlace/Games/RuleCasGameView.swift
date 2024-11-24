//
//  RuleCasGameView.swift
//  JackKas
//
//  Created by Kole Jukisr on 29/11/2024.
//

import Foundation
import SwiftUI


struct RuleCasGameView: View {
    @State var rule: RuleEnum
    var body: some View {
        ZStack {
            Color.init(hex: "#18191E")
                .ignoresSafeArea()
            
            VStack {
                Image(rule.image)
                    .resizable()
                    .frame(width: 144, height: 159)
                    .padding(.top)
                
                ScrollView {
                    Text(rule.rule)
                        .font(.custom(Font.kumar, size: 15))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                        .padding()
                }
            }
            .background(Color.black.opacity(0.66))
            .cornerRadius(20)
            .frame(width: 333)
            .padding(.bottom)
        }
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: BacklBtn())
    }
}
