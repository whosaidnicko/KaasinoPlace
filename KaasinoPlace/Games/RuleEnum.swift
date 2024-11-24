//
//  RuleEnum.swift
//  JackKas
//
//  Created by Kole Jukisr on 29/11/2024.
//

import Foundation


enum RuleEnum {
    case twentyOne
    case roulette
    case kubiki
    
    
    var image: String {
        switch self {
        case .twentyOne:
            return "21numbers"
        case .roulette:
            return "imageRoullete"
        case .kubiki:
            return  "kubikile"
        }
    }
    var rule: String {
       
        switch self {
        case .twentyOne:
             return "In the game '21', the objective is to reach a card total of 21 or as close as possible without exceeding it. Cards 2-10 are worth their face value, face cards (Jack, Queen, King) are worth 10, and Aces can count as 1 or 11. The player and dealer each receive two cards; the player’s cards are both visible, while only one of the dealer’s is shown. Players can hit (take a card), stand (keep their hand), double down (take one card and double the bet), or split pairs. The dealer reveals their hidden card and must hit until reaching at least 17. A Blackjack (Ace + 10-point card) wins over a regular 21. If both hands have the same total, the bet is returned."
            
        case .roulette:
            return "In roulette, the goal is to predict the number or color where the ball will land. You can bet on a specific number (with a 35:1 payout) or on a color—red or black (1:1 payout). Number bets have higher risk and higher payouts, while color bets are lower risk with lower payouts. Place your bet, watch the wheel spin, and win according to the outcome."
            
        case .kubiki:
            return "In a dice game, players place bets, roll the dice, and sum up the points on the rolled faces. The player with the higher score wins the round and doubles their bet. If there’s a tie, the bets are returned. The game continues for an agreed number of rounds or until players choose to stop."
        }
    }
}
