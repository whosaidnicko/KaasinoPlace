//
//  BacklBtn.swift
//  JackKas
//
//  Created by Kole Jukisr on 29/11/2024.
//

import Foundation
import SwiftUI

struct BacklBtn: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Button {
            self.dismiss()   
        } label: {
            ZStack {
                Rectangle()
                    .fill(Color.white.opacity(0.000001))
                    .frame(height: 30)
                Image("backbtn")
            }
        }
        .buttonStyle(CustomStyle())
    }
}
