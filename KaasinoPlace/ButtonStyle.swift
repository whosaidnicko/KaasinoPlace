//
//  ButtonStyle.swift
//  JackKas
//
//  Created by Kole Jukisr on 29/11/2024.
//

import Foundation
import SwiftUI

struct CustomStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0 : 1)
            .rotationEffect(.degrees(configuration.isPressed ? 360 : 0))
     
    }
    
}
