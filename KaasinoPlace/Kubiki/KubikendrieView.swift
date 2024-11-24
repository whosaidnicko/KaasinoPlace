//
//  Bj21View.swift
//  JackKas
//
//  Created by Nicolae Chivriga on 03/09/2024.
//

import Foundation
import SwiftUI

struct KubikendrieView: View {
    
    @State var showMoneyTake: Bool = false
    @State var userWin: Bool?
    @State var firstDice: Int = 1
    @State var secondDice: Int = 1
    @State var myScore: Int?
    @State var enemyScore: Int?
    
    @State var throughDices: Bool?
    @State var showTradeEnergy: Bool = false
    @State var bet: Int = 0
    @State private var isPressed = false
        @State private var timer: Timer?
    @StateObject private var storageUser: UserStorageGameClass = UserStorageGameClass.shared
    var body: some View {
        ZStack {
            ZStack {
                Image("casStol")
                    .resizable()
                    .scaleEffect(1.025)
                    .ignoresSafeArea()
                
                VStack {
                    HStack {
                        self.leftBar()
                        
                        Spacer()
                        
                        self.rightBar()
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 3) {
                        Button {
                            let decrement = 0.10 * Double(self.storageUser.coin)
                            let newBet = bet - Int(decrement)
                            // Ensure the bet does not go below zero
                            if newBet >= 0 {
                                bet = newBet
                            } else {
                                bet = 0
                            }
                        } label: {
                            Image("menuLeibl")
                                .resizable()
                                .frame(width: 45, height: 45)
                                .overlay {
                                    Text("-")
                                        .font(.custom(Font.kumar, size: 25))
                                        .foregroundStyle(.white)
                                }
                        }
                        .buttonStyle(CustomStyle())
                        
                        Image("menuLeibl")
                            .resizable()
                            .frame(width: 141, height: 45)
                            .overlay {
                                Text(String(bet))
                                    .font(.custom(Font.kumar, size: 25))
                                    .foregroundStyle(.white)
                            }
                        
                        Button {
                                let increment = 0.10 * Double(self.storageUser.coin)
                            let newBet = bet + Int(increment)
                            
                            // Ensure the bet does not exceed current money
                            if newBet <= self.storageUser.coin {
                                if newBet == 0 {
                                    self.bet = self.storageUser.coin
                                } else {
                                    bet = newBet
                                }
                                
                            } 
                            if self.storageUser.coin == 0 {
                                withAnimation {
                                    self.showMoneyTake = true
                                }
                            }
                        } label: {
                            Image("menuLeibl")
                                .resizable()
                                .frame(width: 45, height: 45)
                                .overlay {
                                    Text("+")
                                        .font(.custom(Font.kumar, size: 25))
                                        .foregroundStyle(.white)
                                }
                        }
                        .buttonStyle(CustomStyle())
                    }
                    
                    
                    Button(action: {
                        self.storageUser.coin -= self.bet
                        
                        let bet = bet
                        self.bet = 0
                        withAnimation(Animation.easeInOut(duration: 1.5)) {
                            self.throughDices = false
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            
                            withAnimation(Animation.easeInOut(duration: 1.5)) {
                                self.firstDice = .random(in: 1...6)
                                self.secondDice = .random(in: 1...6)
                                self.myScore = firstDice + secondDice
                                self.throughDices = true
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
                                withAnimation(Animation.easeInOut(duration: 0.2)) {
                                    self.throughDices = nil
                                }
                                
                                withAnimation(Animation.easeInOut(duration: 1.5)) {
                                    self.throughDices = false
                                }
                                //
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                    withAnimation(Animation.easeInOut(duration: 1.5)) {
                                        self.firstDice = .random(in: 1...6)
                                        self.secondDice = .random(in: 1...6)
                                        self.enemyScore = self.firstDice + self.secondDice
                                        self.throughDices = true
                                        
                                    }
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                        withAnimation {
                                            if myScore != nil , enemyScore != nil {
                                                if myScore! > enemyScore! {
                                                    self.bet = bet
                                                    self.userWin = true
                                                    
                                                } else if myScore! < enemyScore! {
                                                    self.userWin = false
                                                } else {
                                                    withAnimation {
                                                        self.myScore = nil
                                                        self.enemyScore = nil
                                                        self.throughDices = nil
                                                    }
                                                    self.storageUser.coin += bet
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        
                    }, label: {
                        Image("menuLeibl")
                            .resizable()
                            .frame(width: 141, height: 45)
                            .overlay {
                                Text("BET")
                                    .font(.custom(Font.kumar, size: 25))
                                    .foregroundStyle(.white)
                            }
                    })
                    .buttonStyle(CustomStyle())
                    .scaleEffect(self.bet > 0  ? 1 : 0)
                    .disabled(self.bet == 0)
                    .animation(Animation.easeInOut(duration: 1.2), value: self.bet)
                    
                    
                    
                }
                .padding()
                
                .disabled(self.throughDices != nil)
                ZStack {
                    VStack {
                        Image(String(firstDice))
                            .resizable()
                            .frame(width: 65, height: 65)
                            .scaleEffect(self.throughDices != nil ? (self.throughDices! ? 1 : 0.5 ) : 0)
                            .rotationEffect(.degrees(self.throughDices != nil  ?  (self.throughDices! ? 1080 : 720) : 0))
                            .offset(y: self.throughDices != nil ? (self.throughDices! ? 0 : -600) : 0)
                        
                        Image(String(secondDice))
                            .resizable()
                            .frame(width: 65, height: 65)
                            .scaleEffect(self.throughDices != nil ? (self.throughDices! ? 1 : 0.5 ) : 0)
                            .rotationEffect(.degrees(self.throughDices != nil  ?  (self.throughDices! ? 1080 : 720) : 0))
                            .offset(y: self.throughDices != nil ? (self.throughDices! ? 0 : -600) : 0)
                    }
                    
                    Text(self.myScore != nil ? String(myScore!) : "")
                        .font(.custom(Font.kumar, size: 17))
                        .foregroundStyle(.white)
                        .scaleEffect(self.myScore != nil ? 1 : 0)
                        .rotationEffect(.degrees(self.myScore != nil ? 720 : 0))
                        .offset(y: self.myScore != nil ? 140 : 0)
                    
                    Text(self.enemyScore != nil ? String(enemyScore!) : "")
                        .font(.custom(Font.kumar, size: 17))
                        .foregroundStyle(.white)
                        .scaleEffect(self.enemyScore != nil ? 1 : 0)
                        .rotationEffect(.degrees(self.myScore != nil ? 720 : 0))
                        .offset(y: self.enemyScore != nil ? -140 : 0)
                    
                }
                
            }
            .disabled(self.showTradeEnergy || self.userWin != nil || self.showMoneyTake)
            .blur(radius: self.userWin != nil || self.showTradeEnergy || self.showMoneyTake ? 3 : 0)
            if let userWin = userWin {
                AlertUserWin(gold: bet * 2,
                             experince: Int.random(in: 50...100),
                             userWin: userWin, isFreeRoulette: false) {
                    withAnimation {
                        self.throughDices = nil
                        self.enemyScore = nil
                        self.myScore = nil
                        self.userWin = nil
                        
                    }
                }
                .scaleEffect(self.userWin != nil ? 1 : 0)
            }
            
            MoneyAlert(moneyAlert: $showMoneyTake)
            
            showTradeEnery()
                .scaleEffect(self.showTradeEnergy ? 1 : 0)
        }
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: BacklBtn())
        .onAppear() {
            self.storageUser.energy -= 2
        }
    }
    
    internal func leftBar() -> some View {
        HStack {
            VStack(spacing: 0) {
                HStack {
                    Button(action: {
                        withAnimation {
                            self.showTradeEnergy = true
                        }
                    }, label: {
                        ZStack {
                            Image("squarePurple")
                            
                            Image("plus")
                        }
                    })
                    .offset(x: -5
                        ,y: 2)
                    .buttonStyle(CustomStyle())
                    
                    Spacer()
                    
                    Text(String(self.storageUser.energy))
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
                
                Text(String(self.storageUser.coin))
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
                        if self.storageUser.coin >= 50 {
                            self.storageUser.coin -= 50
                            self.storageUser.energy += 1
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
 
}
private struct RecordButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background {
                if configuration.isPressed {
                    Circle()
                        .fill(Color.pink)
                        
                }
            }
            .onChange(of: configuration.isPressed) { isPressed in
                
            }
    }
}
