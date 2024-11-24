//
//  GamesChooseView.swift
//  JackKas
//
//  Created by Kole Jukisr on 29/11/2024.
//

import Foundation
import SwiftUI


struct GamesChooseView: View {
    @StateObject private var userStorage: UserStorageGameClass = UserStorageGameClass.shared
    
    @State var showTradeEnergy: Bool = false
    @State var showMoney: Bool = false
    var body: some View {
        ZStack {
            Color.init(hex: "#18191E")
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    self.leftBar()
                    
                    Spacer()
                    
                    self.rightBar()
                }
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 29) {
                 
                        Image("gameRo")
                            .overlay {
                                HStack(spacing: 21) {
                                    Image("21numbers")
                                    if self.userStorage.energy > 0 {
                                        NavigationLink {
                                            BlackjackCardsGame()
                                        } label: {
                                            Image("settingsLeibl")
                                                .resizable()
                                                .frame(width: 91,
                                                       height: 42)
                                                .overlay {
                                                    Text("Play")
                                                        .font(.custom(Font.kumar, size: 15))
                                                        .foregroundStyle(.white)
                                                }
                                        }
//                                        .padding(.horizontal)
//                                        .offset(y: -32)
                                    } else {
                                        Button(action: {
                                            withAnimation {
                                                if self.userStorage.coin >= 50 {
                                                    self.showTradeEnergy = true
                                                } else {
                                                    self.showMoney = true
                                                }
                                            }
                                        }, label: {
                                            Image("settingsLeibl")
                                                .resizable()
                                                .frame(width: 91,
                                                       height: 42)
                                                .overlay {
                                                    Text("Play")
                                                        .font(.custom(Font.kumar, size: 15))
                                                        .foregroundStyle(.white)
                                                }

                                        })
                                      
                                    }
                                    
                                }    .padding(.horizontal)
                                    .offset(y: -32)
                              
                            }
                        
                            .overlay {
                                VStack {
                                    Spacer()
                                    
                                    HStack {
                                        NavigationLink {
                                            RuleCasGameView(rule: .twentyOne)
                                        } label: {
                                            Image("settingsLeibl")
                                                .resizable()
                                                .frame(width: 79,
                                                       height: 31.8)
                                                .overlay {
                                                    Text("Rules")
                                                        .font(.custom(Font.kumar, size: 15))
                                                        .foregroundStyle(.white)
                                                }
                                        }

                                     
                                        
                                        Text("1")
                                            .font(.custom(Font.kumar, size: 30))
                                            .foregroundStyle(.white)
                                        
                                        Image("lightPurpel")
                                            .resizable()
                                            .frame(width: 31, height: 33)
                                    }
                                }
                                .padding()
                                .offset(x: 60)
                            }
                        
                        Image("gameRo")
                            .overlay {
                                HStack(spacing: 21) {
                                    
                                    Image("imageRoullete")
                                        .resizable()
                                        .frame(width: 86, height: 83)
                                    
                                    if self.userStorage.energy > 0 {
                                        NavigationLink {
                                            FreeRouletteView(isFree: false)
                                        } label: {
                                            
                                            Image("settingsLeibl")
                                                .resizable()
                                                .frame(width: 91,
                                                       height: 42)
                                                .overlay {
                                                    Text("Play")
                                                        .font(.custom(Font.kumar, size: 15))
                                                        .foregroundStyle(.white)
                                                }
                                        }
                                    } else {
                                        Button(action: {
                                            withAnimation {
                                                if self.userStorage.coin >= 50 {
                                                    self.showTradeEnergy = true
                                                } else {
                                                    self.showMoney = true
                                                }
                                            }
                                        }, label: {
                                            Image("settingsLeibl")
                                                .resizable()
                                                .frame(width: 91,
                                                       height: 42)
                                                .overlay {
                                                    Text("Play")
                                                        .font(.custom(Font.kumar, size: 15))
                                                        .foregroundStyle(.white)
                                                }
                                        })
                                    }

                                }
                                .padding(.horizontal)
                                .offset(y: -32)
                            }
                        
                            .overlay {
                                VStack {
                                    Spacer()
                                    
                                    HStack {
                                        NavigationLink {
                                            RuleCasGameView(rule: .roulette)
                                        } label: {
                                            Image("settingsLeibl")
                                                .resizable()
                                                .frame(width: 79,
                                                       height: 31.8)
                                                .overlay {
                                                    Text("Rules")
                                                        .font(.custom(Font.kumar, size: 15))
                                                        .foregroundStyle(.white)
                                                }
                                        }

                                     
                                        
                                        Text("1")
                                            .font(.custom(Font.kumar, size: 30))
                                            .foregroundStyle(.white)
                                        
                                        Image("lightPurpel")
                                            .resizable()
                                            .frame(width: 31, height: 33)
                                    }
                                }
                                .padding()
                                .offset(x: 60)
                            }
                        
                        Image("gameRo")
                            .overlay {
                                HStack(spacing: 21) {
                                    Image("kubikile")
                                    if self.userStorage.energy < 2 {
                                        Button(action: {
                                            withAnimation {
                                                if self.userStorage.coin >= 50 {
                                                    self.showTradeEnergy = true
                                                } else {
                                                    self.showMoney = true
                                                }
                                            }
                                        }, label: {
                                            Image("settingsLeibl")
                                                .resizable()
                                                .frame(width: 91,
                                                       height: 42)
                                                .overlay {
                                                    Text("Play")
                                                        .font(.custom(Font.kumar, size: 15))
                                                        .foregroundStyle(.white)
                                                }
                                        })
                                    } else {
                                        NavigationLink {
                                            KubikendrieView()
                                        } label: {
                                            Image("settingsLeibl")
                                                .resizable()
                                                .frame(width: 91,
                                                       height: 42)
                                                .overlay {
                                                    Text("Play")
                                                        .font(.custom(Font.kumar, size: 15))
                                                        .foregroundStyle(.white)
                                                }
                                        }
                                    }
                                    
                                }
                                .padding(.horizontal)
                                .offset(y: -32)
                            }
                        
                            .overlay {
                                VStack {
                                    Spacer()
                                    
                                    HStack {
                                        NavigationLink {
                                            RuleCasGameView(rule: .kubiki)
                                        } label: {
                                            Image("settingsLeibl")
                                                .resizable()
                                                .frame(width: 79,
                                                       height: 31.8)
                                                .overlay {
                                                    Text("Rules")
                                                        .font(.custom(Font.kumar, size: 15))
                                                        .foregroundStyle(.white)
                                                }
                                        }

                                        Text("2")
                                            .font(.custom(Font.kumar, size: 30))
                                            .foregroundStyle(.white)
                                        
                                        Image("lightPurpel")
                                            .resizable()
                                            .frame(width: 31, height: 33)
                                    }
                                }
                                .padding()
                                .offset(x: 60)
                            }
                    }
                    .padding(.top, 100)
                }
                Spacer()
                
            }
            .padding(.horizontal)
            .blur(radius: self.showTradeEnergy ? 3 : 0)
            
            showTradeEnery()
                .scaleEffect(self.showTradeEnergy ? 1 : 0)
            
            MoneyAlert(moneyAlert: self.$showMoney)
        }
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: BacklBtn())
    }
    
    func showTradeEnery() -> some View {
        Image("rectName")
            .overlay {
                VStack {
                    HStack {
                        Spacer()
                        Button {
                            withAnimation {
                            self.showTradeEnergy = false
                            }
                        } label: {
                            Image("closeIc")
                        }
                    }
                    HStack {
                        Text("50")
                            .font(.custom(Font.kumar, size: 20))
                            .foregroundStyle(Color.white)
                        
                        Image("stars")
                            .resizable()
                            .frame(width: 34, height: 28.5)
                        
                        Text("=")
                            .font(.custom(Font.kumar, size: 25))
                            .foregroundStyle(.white)
                        
                        Text("1")
                            .font(.custom(Font.kumar, size: 25))
                            .foregroundStyle(.white)
                        
                        Image("lightPurpel")
                            .resizable()
                            .frame(width: 31, height: 33)
                    }
                    Button {
                    if self.userStorage.coin >= 50 {
                            self.userStorage.coin -= 50
                            self.userStorage.energy += 1
                        }
                    } label: {
                        Image("settingsLeibl")
                            .resizable()
                            .frame(width: 91, height: 42)
                            .overlay {
                                Text("Change")
                                    .font(.custom(Font.kumar
                                                  , size: 15))
                                    .foregroundStyle(.white)
                            }
                    }
                    .buttonStyle(CustomStyle())
                    
                    
                    
                    Spacer()
                }
            }
    }
    internal func leftBar() -> some View {
        HStack {
            VStack(spacing: 0) {
                HStack {
                    ZStack {
                        Image("squarePurple")
                        
                        Image("plus")
                    }
                    .offset(x: -5
                        ,y: 2)
                    
                    Spacer()
                    
                    Text(String(self.userStorage.energy))
                        .font(.custom(Font.kumar, size: 20))
                        .foregroundStyle(.white)
                    
                    Spacer()
                    
                    Image("lightPurpel")
                        .padding(.horizontal)
                }
                
                HStack {
                    Rectangle()
                        .fill(Color.init(hex: "#FFFFFF").opacity(0.4))
                        .frame(width: 132.78, height: 1.45)
                    
                    Spacer()
                }
            }
            .frame(width: 133)
            
            Spacer()
        }
    }
    
    internal func rightBar() -> some View {
        VStack(spacing: 0) {
            HStack(spacing: 16) {
                Spacer()
                
                Text(String(self.userStorage.coin))
                    .font(.custom(Font.kumar, size: 10))
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
