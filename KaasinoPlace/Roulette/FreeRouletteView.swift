//
//  FreeRouletteView.swift
//  JackKas
//
//  Created by Kole Jukisr on 29/11/2024.
//

import Foundation
import SwiftUI


struct FreeRouletteView: View {
    @State var showMoneyTake: Bool = false
    var isFree: Bool
    @State var bet: Int = 0
    @State var showTradeEnergy: Bool = false
    @StateObject private var userStorage: UserStorageGameClass = UserStorageGameClass.shared
    @State var gold: Int = 0
    @State var experience: Int = 0
    @State var userWin: Bool?
    @State var selectedColor: Color?
    @State var selectedNumber: Int = -1
    @State var numbers: [Int] = []
    let columns = [
        GridItem(.fixed(24), spacing: 0),
        GridItem(.fixed(24), spacing: 0),
        GridItem(.fixed(24), spacing: 0),
        GridItem(.fixed(24), spacing: 0),
        GridItem(.fixed(24), spacing: 0),
        GridItem(.fixed(24), spacing: 0),
        GridItem(.fixed(24), spacing: 0),
        GridItem(.fixed(24), spacing: 0),
        GridItem(.fixed(24), spacing: 0),
        GridItem(.fixed(24), spacing: 0)
    ]
    var body: some View {
        ZStack {
            Image("roleteBg")
                .resizable()
                .scaleEffect(1.05)
                .ignoresSafeArea()
            
            VStack {
            self.rouleteView()
            
                LazyVGrid(columns: columns,alignment: .center, spacing: 6) {
                    ForEach(self.numbers.indices, id: \.self) { index in
                        RoundedRectangle(cornerRadius: 3)
                            .fill(numbers[index] == 0 ? Color.init(hex: "#66B945") : (numbers[index] % 2 == 0 ? Color.black : Color.init(hex: "#F2272F")))
                            .overlay {
                                RoundedRectangle(cornerRadius: 3)
                                    .trim(from: 0, to: self.selectedNumber == numbers[index]  && selectedColor == nil  ? 1 : 0)
                                    .stroke(Color.white
                                        ,lineWidth: 1)
                                  
                                Text(String(numbers[index]))
                                    .font(.custom(Font.kumar
                                                  , size: 10))
                                    .foregroundStyle(Color.white)
                            }
                            .animation(Animation.easeInOut(duration: 2), value: self.selectedNumber)
                            .frame(width: 19, height: 19)
                            .onTapGesture {
                                self.selectedColor = nil
                                self.selectedNumber = self.numbers[index]
                            }
                    }
                }
                
                HStack(spacing: 49) {
                    Button(action: {
                        selectedNumber = -1
                        selectedColor = Color.init(hex: "#F5222A")
                    }, label: {
                        RoundedRectangle(cornerRadius: 3)
                            .fill(Color.init(hex: "#F5222A"))
                            .overlay {
                            RoundedRectangle(cornerRadius: 3)
                                    .trim(from: 0, to: Color.init(hex: "#F5222A") == selectedColor ? 1 : 0)
                                    .stroke(Color.white
                                        ,lineWidth: 1)
                               
                            }
                            .frame(width: 33, height: 33)
                            .animation(Animation.easeInOut(duration: 2), value: self.selectedColor)
                    })
                    .buttonStyle(CustomStyle())
                    
                    Button(action: {
                        selectedNumber = -1
                        selectedColor = Color.init(hex: "#000000")
                    }, label: {
                        RoundedRectangle(cornerRadius: 3)
                            .fill(Color.init(hex: "#000000"))
                            .overlay {
                            RoundedRectangle(cornerRadius: 3)
                                    .trim(from: 0, to: Color.init(hex: "#000000") == selectedColor ? 1 : 0)
                                    .stroke(Color.white
                                        ,lineWidth: 1)
                               
                            }
                            .frame(width: 33, height: 33)
                            .animation(Animation.easeInOut(duration: 2), value: self.selectedColor)
                    })
                    .buttonStyle(CustomStyle())

                 
                }
                .padding(.top)
                
                Spacer()
                
                Group {
                    if !self.isSpinning && (selectedNumber > -1 || selectedColor != nil) {
                        if isFree {
                            Button {
                                isSpinning = true
                                randomAngle = Double.random(in: 1...360)
                                rotationAngle += 1080 + randomAngle
                                calculatedAngle = normalizeAngle(angle: rotationAngle)
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2.9) {
                                    isSpinning = false
                                    self.determineSector(from: calculatedAngle)
                                }
                                
                            } label: {
                                Image("menuLeibl")
                                    .overlay {
                                        Text("FREE SPIN")
                                            .font(.custom(Font.kumar, size: 17))
                                            .foregroundStyle(.white)
                                    }
                            }
                            .buttonStyle(CustomStyle())
                            .disabled(isSpinning)
                        } else {
                            HStack(spacing: 3) {
                                Button {
                                    let decrement = 0.10 * Double(self.userStorage.coin)
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
                                        let increment = 0.10 * Double(self.userStorage.coin)
                                    let newBet = bet + Int(increment)
                                    
                                    // Ensure the bet does not exceed current money
                                    if newBet <= self.userStorage.coin {
                                        if newBet == 0 {
                                            self.bet = self.userStorage.coin
                                        } else {
                                            bet = newBet
                                        }
                                        
                                    }
                                    if self.userStorage.coin == 0 {
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
                                isSpinning = true
                                self.userStorage.coin -= self.bet
                                randomAngle = Double.random(in: 1...360)
                                rotationAngle += 1080 + randomAngle
                                calculatedAngle = normalizeAngle(angle: rotationAngle)
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2.9) {
                                    isSpinning = false
                                    self.determineSector(from: calculatedAngle)
                                }
                                
                            }, label: {
                                Image("menuLeibl")
                                    .resizable()
                                    .frame(width: 141, height: 45)
                                    .overlay {
                                        Text("Spin")
                                            .font(.custom(Font.kumar, size: 25))
                                            .foregroundStyle(.white)
                                    }
                            })
                            .buttonStyle(CustomStyle())
                            .scaleEffect(!self.isSpinning  ? 1 : 0)
                            .disabled(self.bet == 0)
                            .animation(Animation.easeInOut(duration: 1.2), value: self.bet)
                        }
                    }
                }
                .transition(.scale)
                .padding(.bottom, 10)
            }
            .blur(radius: self.userWin != nil ? 3 : 0)
            .disabled(self.userWin != nil)
            
            Group {
                if self.userWin != nil {
                    AlertUserWin(gold: self.gold, 
                                 experince: self.experience,
                                 userWin: userWin!,
                                 isFreeRoulette: isFree ) {
                        withAnimation {
                            self.userWin = nil
                        }
                    }
                        .onAppear() {
                            self.userStorage.roulettePressedAction()
                        }
                }
            }
            .transition(.scale)
            
            showTradeEnery()
                .scaleEffect(self.showTradeEnergy ? 1 : 0)
            MoneyAlert(moneyAlert: $showMoneyTake)
        }
        
        .animation(Animation.easeInOut, value: isSpinning)
        .navigationBarBackButtonHidden()
        .navigationBarItems(trailing: GoldView())
        .navigationBarItems(leading: BacklBtn())
        .onAppear() {
            for number in 0...36 {
                self.numbers.append(number)
            }
            if !self.isFree {
                self.userStorage.energy -= 1
            }
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

    
    func rouleteView() -> some View {
        VStack(spacing: 0) {
            Image("showingArrow")
                .scaleEffect(UIScreen.main.bounds.height > 680 ? 1 : 0.8)
           
            Image("imageRoullete")
                .resizable()
                .scaledToFit()
                .rotationEffect(Angle(degrees: rotationAngle))
                .frame(width: 245 * (UIScreen.main.bounds.height > 680 ? 1 : 0.8), height: 245 * (UIScreen.main.bounds.height > 680 ? 1 : 0.8))
                .animation(Animation.easeInOut(duration: 2.9),
                           value: rotationAngle)
  
            
        }
    }
 
    @State private var rotationAngle = 0.0
    @State private var randomAngle = 0.0
    @State private var calculatedAngle = 0.0
    
    let halfSectorSize = 360.0 / 37.0 / 2.0
    let rouletteSectors: [RouletteSector] = [
        RouletteSector(number: 32, color: .red),
        RouletteSector(number: 15, color: .black),
        RouletteSector(number: 19, color: .red),
        RouletteSector(number: 4, color: .black),
        RouletteSector(number: 21, color: .red),
        RouletteSector(number: 2, color: .black),
        RouletteSector(number: 25, color: .red),
        RouletteSector(number: 17, color: .black),
        RouletteSector(number: 34, color: .red),
        RouletteSector(number: 6, color: .black),
        RouletteSector(number: 27, color: .red),
        RouletteSector(number: 13, color: .black),
        RouletteSector(number: 36, color: .red),
        RouletteSector(number: 11, color: .black),
        RouletteSector(number: 30, color: .red),
        RouletteSector(number: 8, color: .black),
        RouletteSector(number: 23, color: .red),
        RouletteSector(number: 10, color: .black),
        RouletteSector(number: 5, color: .red),
        RouletteSector(number: 24, color: .black),
        RouletteSector(number: 16, color: .red),
        RouletteSector(number: 33, color: .black),
        RouletteSector(number: 1, color: .red),
        RouletteSector(number: 20, color: .black),
        RouletteSector(number: 14, color: .red),
        RouletteSector(number: 31, color: .black),
        RouletteSector(number: 9, color: .red),
        RouletteSector(number: 22, color: .black),
        RouletteSector(number: 18, color: .red),
        RouletteSector(number: 29, color: .black),
        RouletteSector(number: 7, color: .red),
        RouletteSector(number: 28, color: .black),
        RouletteSector(number: 12, color: .red),
        RouletteSector(number: 35, color: .black),
        RouletteSector(number: 3, color: .red),
        RouletteSector(number: 26, color: .black),
        RouletteSector(number: 0, color: .green)
    ]
    @State private var isSpinning = false
    
    var spinningAnimation: Animation {
        Animation.easeOut(duration: 3.0)
            .repeatCount(1, autoreverses: false)
    }
    
    func normalizeAngle(angle: Double) -> Double {
        let adjusted = 360 - angle.truncatingRemainder(dividingBy: 360)
        return adjusted
    }
    
    func determineSector(from angle: Double) {
        var index = 0
        var currentSector: RouletteSector = RouletteSector(number: -1, color: .none)
        
        while currentSector == RouletteSector(number: -1, color: .none) && index < rouletteSectors.count {
            let start: Double = halfSectorSize * Double((index * 2 + 1)) - halfSectorSize
            let end: Double = halfSectorSize * Double((index * 2 + 3))
            
            if angle >= start && angle < end {
                currentSector = rouletteSectors[index]
            }
            index += 1
        }
        
        DispatchQueue.main.async {
            self.experience = Int.random(in: 25...200)
            withAnimation(Animation.easeInOut(duration: 1)) {
                
                if self.selectedColor == Color.init(hex: currentSector.color.rawValue) {
                    self.gold = (isFree ? 100 : self.bet) * 2
                
                    self.userWin = true
                 
                } else if self.selectedNumber == currentSector.number {
                    if selectedNumber == 0 {
                   
                        self.gold = (isFree ? 100 : self.bet) * 50
                        self.userWin = true
                    } else {
                        self.userWin = true
                        self.gold = 30 * (isFree ? 100 : self.bet)
                    }
                   
                } else {
                    self.gold = 0
                    self.userWin = false
                   
                }
                self.bet = 0
                self.selectedColor = nil
                self.selectedNumber = -1
            
            }
        }
 
    }
    
    
      
}

import SwiftUI

enum RouletteColor: String {
    case red = "#F5222A"
    case black = ""
    case green = "ZERO"
    case none
}

struct RouletteSector: Equatable {
    let number: Int
    let color: RouletteColor
}

