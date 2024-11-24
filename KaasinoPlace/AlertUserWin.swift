//
//  AlertUserWin.swift
//  JackKas
//
//  Created by Kole Jukisr on 29/11/2024.
//

import Foundation
import SwiftUI

struct AlertUserWin: View {
    @StateObject private var userStorage: UserStorageGameClass = UserStorageGameClass.shared
    @State var gold: Int
    @State var experince: Int
    @State var userWin: Bool
    var isFreeRoulette: Bool
    let action: () -> Void
    @Environment(\.dismiss) var dismiss
    var body: some View {
        RoundedRectangle(cornerRadius: 30)
            .fill(Color.init(hex: "#25262B"))
            .overlay {
                VStack {
                   
                            Text(self.userWin ? "You Win" : "You Lose")
                                .font(.custom(Font.kumar, size: 30))
                                .foregroundStyle(.white)
                        
                    
                    if self.userWin {
                        HStack  {
                            Text(String(gold))
                                .font(.custom(Font.kumar, size: 40))
                                .foregroundStyle(.white)
                            
                            Image("stars")
                                .resizable()
                                .frame(width: 45, height: 38)
                        }
                    }
                    
                    HStack  {
                        Text(String(self.experince))
                            .font(.custom(Font.kumar, size: 40))
                            .foregroundStyle(.white)
                        
                        Circle()
                            .fill(LinearGradient(colors:
                                                    [Color.init(hex: "#CB73EB"),
                                                     Color.init(hex: "#CB73EB")], startPoint: .topLeading, endPoint: .bottomTrailing))
                        
                            .overlay {
                                Text("XP")
                                    .font(.custom(Font.kumar
                                                  , size: 12))
                                    .foregroundStyle(Color.white)
                                
                            }
                            .frame(width: 36, height: 35)
                        
                        VStack() {
                            Text("\(Int(self.userStorage.currentExperince))/2000")
                                .font(.custom(Font.kumar, size: 8))
                                .foregroundStyle(Color.init(hex: "#999999"))
                            
                            Rectangle()
                                .fill(Color.white.opacity(0.4))
                                .frame(width: 104, height: 10)
                                .overlay(alignment: .leading)  {
                                    Rectangle()
                                        .fill(Color.init(hex: "#CB73EB"))
                                        .frame(width: 104 * (self.userStorage.currentExperince / 2000), height: 5)
                                        .padding(.horizontal, 6)
                                }
                        }
                        .padding(.bottom, 6)
                        
                    }
                    Spacer()
                    
                    Button {
                        if self.isFreeRoulette {
                            self.dismiss()
                        } else {
                            action()
                        }
                    } label: {
                        Image("settingsLeibl")
                            .resizable()
                            .frame(width: 91, height: 42)
                            .overlay {
                                Text(isFreeRoulette ?  "BACK" : "CLOSE")
                                    .font(.custom(Font.kumar,
                                                  size: 15))
                                    .foregroundStyle(.white)
                            }
                            .padding(.bottom)
                    }

                }
                .padding()
            }
            .frame(width: 325, height: 558)
            .onAppear() {
                if self.userWin {
                    DispatchQueue.main.async {
                        self.userStorage.coin += self.gold
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation(Animation.easeInOut(duration: 2)) {
                        self.userStorage.currentExperince += Double(self.experince)
                    }
                }
            }
    }
}
