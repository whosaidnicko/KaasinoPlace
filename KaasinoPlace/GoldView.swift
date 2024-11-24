//
//  GoldView.swift
//  JackKas
//
//  Created by Kole Jukisr on 29/11/2024.
//

import Foundation
import SwiftUI

struct GoldView: View {
    @StateObject  var userStorage: UserStorageGameClass = UserStorageGameClass.shared
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 16) {
                Spacer()
                
                Text(String(self.userStorage.coin))
                    .font(.custom(Font.kumar, size: 10))
                    .fixedSize(horizontal: true,
                               vertical: false)
                    .foregroundStyle(.white)
                
                Image("stars")
            }
            
            
            HStack {
                Spacer()
                
                Rectangle()
                    .fill(Color.init(hex: "#FFFFFF").opacity(0.4))
                    .frame(width: 132.78, height: 1.45)
            }
        }
        .frame(width: 133)
    }
}
