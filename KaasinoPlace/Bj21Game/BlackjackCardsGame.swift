//
//  BjTwentyOneView.swift
//  JackKas
//
//  Created by Kole Jukisr on 29/11/2024.
//

import Foundation
import SwiftUI


struct BlackjackCardsGame: View {
  
    @StateObject private var storageUser: UserStorageGameClass = UserStorageGameClass.shared
    @State var bet: Int = 0
    @State var betClosed: Bool = false
    @State var offSetMultiply: CGFloat = 0
    @State var cards: [BjcardModel] = []
    @State var timer: Timer?
    @State var enemyTurn: Bool = false
    @State var userWin: Bool?
    @State var myScore: Int = 0
    @State var enemyScore: Int = 0
    @State var showMoneyTake: Bool = false
    var body: some View {
        ZStack {
            Image("casStol")
                .resizable()
                .scaleEffect(1.025)
                .ignoresSafeArea()
            
            
            ForEach(cards.indices, id: \.self) { index in
                Image(cards[index].open ? cards[index].image : "backOblojk")
                    .resizable()
                    .frame(width: 40, height: 60)
                    .rotation3DEffect(
                                        .degrees(self.cards[index].open  ? 360 : 0),
                                                              axis: (x: 0.0, y: 1.0, z: 0.0)
                                    )
                    .offset(x: cards[index].inDeck ? cards[index].offSetX :  CGFloat(5 * index), y: cards[index].inDeck ?  cards[index].offSetY : 0 )
            }
            .offset(x: -70, y: -50)
            
            
            VStack {
                Spacer()
                if betClosed {
                    HStack {
                        Button(action: {
                            withAnimation {
                                for index in stride(from: cards.count - 1, through: 0, by: -1) {
                                    if !cards[index].inDeck {
                                        cards[index].offSetX = (44 * offSetMultiply) - 25
                                        offSetMultiply += 1
                                        cards[index].inDeck = true
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                            withAnimation {
                                                cards[index].open = true
                                              
                                              
                                                
                                                if cards[index].image.hasPrefix("j") || cards[index].image.hasPrefix("k") || cards[index].image.hasPrefix("d") {
                                                    myScore += 10
                                                }
                                                
                                                if let number = Int(cards[index].image.dropLast()) {
                                                    if number == 1 {
                                                        self.myScore += 11
                                                    } else {
                                                        self.myScore += number
                                                    }
                                                }
                                            }
                                            
                                            if myScore > 21 {
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                                    withAnimation {
                                                        userWin = false
                                                    }
                                                }
                                            } else if myScore == 21 {
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                                    withAnimation {
                                                        userWin = true
                                                    }
                                                }
                                            }
                                        }
                                        break
                                    }
                                }
                            }
                        }, label: {
                            Image("menuLeibl")
                                .resizable()
                                .frame(width: 91, height: 42)
                                .overlay {
                                    Text("MORE")
                                        .font(.custom(Font.kumar, size: 15))
                                        .foregroundStyle(.black)
                                }
                        })
                        
                        ZStack {
                            if myScore != 0 {
                                Button(action: {
                                    self.offSetMultiply = 0
                                    withAnimation {
                                        self.enemyTurn = true
                                    }
                                    timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { _ in
                                        if enemyScore < 17 {
                                            withAnimation {
                                                for index in stride(from: cards.count - 1, through: 0, by: -1) {
                                                    if !cards[index].inDeck {
                                                        withAnimation {
                                                            cards[index].offSetY = -100
                                                            cards[index].offSetX = (44 * offSetMultiply) - 25
                                                            cards[index].inDeck = true
                                                        }
                                               
                                                        
                                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                                            withAnimation {
                                                                cards[index].open = true
                                                               
                                                                offSetMultiply += 1
                                                                
                                                                if cards[index].image.hasPrefix("j") || cards[index].image.hasPrefix("k") || cards[index].image.hasPrefix("d") {
                                                                    enemyScore += 10
                                                                }
                                                                
                                                                if let number = Int(cards[index].image.dropLast()) {
                                                                    if number == 1 {
                                                                        self.enemyScore += 11
                                                                    } else {
                                                                        self.enemyScore += number
                                                                    }
                                                                }
                                                            }
                                                            
                                                            //                                            if myScore > 21 {
                                                            //                                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                                            //                                                    withAnimation {
                                                            //                                                        userWin = false
                                                            //                                                    }
                                                            //                                                }
                                                            //                                            } else if myScore == 21 {
                                                            //                                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                                            //                                                    withAnimation {
                                                            //                                                        userWin = true
                                                            //                                                    }
                                                            //                                                }
                                                            //                                            }
                                                        }
                                                        break
                                                    }
                                                }
                                            }
                                        } else {
                                            if enemyScore > 21 {
                                                withAnimation {
                                                    self.userWin = true
                                                }
                                            } else if enemyScore == myScore {
                                                self.storageUser.coin += bet
                                                withAnimation {
                                                    self.enemyScore = 0
                                                    self.myScore = 0
                                                    self.offSetMultiply = 0
                                                    self.betClosed = false
                                                    self.bet = 0
                                                    
                                                    self.userWin = nil
                                                    self.cards.shuffle()
                                                    self.enemyTurn = false
                                                    
                                                    for index in  cards.indices {
                                                        withAnimation {
                                                            self.cards[index].inDeck = false
                                                            self.cards[index].open = false
                                                            self.cards[index].offSetY = 100
                                                        }
                                                    }
                                                }

                                                
                                            } else if myScore > enemyScore {
                                                withAnimation {
                                                    self.userWin = true
                                                }
                                            } else if enemyScore > myScore {
                                                withAnimation {
                                                    self.userWin = false
                                                }
                                            }
                                            timer?.invalidate()
                                        }
                                    }
                                }, label: {
                                    Image("menuLeibl")
                                        .resizable()
                                        .frame(width: 91, height: 42)
                                        .overlay {
                                            Text("Done")
                                                .font(.custom(Font.kumar, size: 15))
                                                .foregroundStyle(.black)
                                        }
                                })
                            }
                        }
                        .frame(width: 91)
                        
                    }
                    .scaleEffect(enemyTurn ? 0 : 1)
                    
                    

                } else {
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
                                        .foregroundStyle(.black)
                                }
                        }
                        .buttonStyle(CustomStyle())
                        
                        Image("menuLeibl")
                            .resizable()
                            .frame(width: 141, height: 45)
                            .overlay {
                                Text(String(bet))
                                    .font(.custom(Font.kumar, size: 25))
                                    .foregroundStyle(.black)
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
                                        .foregroundStyle(.black)
                                }
                        }
                        .buttonStyle(CustomStyle())
                    }
                }
                Button(action: {
                    withAnimation {
                        self.storageUser.coin -= bet
                        self.betClosed = true
                    }
                }, label: {
                    Image("menuLeibl")
                        .resizable()
                        .frame(width: 141, height: 45)
                        .overlay {
                            Text("BET")
                                .font(.custom(Font.kumar, size: 25))
                                .foregroundStyle(.black)
                        }
                })
             
                    .buttonStyle(CustomStyle())
                    .scaleEffect(self.bet > 0 && !self.betClosed  ? 1 : 0)
                    .disabled(self.bet == 0)
                    .animation(Animation.easeInOut(duration: 1.2), value: self.bet)
            }
            .padding(.bottom)
            .disabled(userWin != nil || myScore > 21 || myScore == 21)
            
            MoneyAlert(moneyAlert: $showMoneyTake)
            
            Text(String(myScore))
                .font(.custom(Font.kumar, size: 20))
                .foregroundStyle(.white)
                .offset(y: 140)
            
            Text(String(enemyScore))
                .font(.custom(Font.kumar, size: 20))
                .foregroundStyle(.white)
                .offset(y: -220)
            
            if userWin != nil {
                AlertUserWin(gold: bet * 2,
                             experince: Int.random(in: 50...100),
                             userWin: userWin!, isFreeRoulette: false) {
                    withAnimation {
                        self.enemyScore = 0
                        self.myScore = 0
                        self.offSetMultiply = 0
                        self.betClosed = false
                        self.bet = 0
                        self.enemyTurn = false
                        self.cards.shuffle()
                        self.userWin = nil
                        
                        for index in  cards.indices {
                            withAnimation {
                                self.cards[index].offSetY = 100
                                self.cards[index].inDeck = false
                                self.cards[index].open = false
                            }
                        }
                    }
                }
                .scaleEffect(self.userWin != nil ? 1 : 0)
            }
        }
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: BacklBtn())
        .navigationBarItems(trailing: rightBar())
        .onAppear() {
            self.storageUser.energy -= 1
            let cardsRanks: [String] = ["j", "d", "k"]
            for card in 1...10 {
                cards.append(BjcardModel(inDeck: false, open: false, image: String(card).appending("c"), offSetX: 0, offSetY: 100) )
                cards.append(BjcardModel(inDeck: false, open: false, image: String(card).appending("h"), offSetX: 0, offSetY: 100) )
            }
            
            for cardRank in cardsRanks {
                cards.append(BjcardModel(inDeck: false, open: false, image: cardRank.appending("c"), offSetX: 0, offSetY: 100) )
                cards.append(BjcardModel(inDeck: false, open: false, image: cardRank.appending("h"), offSetX: 0, offSetY: 100) )
            }
            cards.shuffle()
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

}
