//
//  UserStorageGameClass.swift
//  JackKas
//
//  Created by Kole Jukisr on 29/11/2024.
//

import Foundation
import SwiftUI
import Combine
import AVFoundation

final class UserStorageGameClass: ObservableObject {
    static var shared: UserStorageGameClass = UserStorageGameClass()
    
    @AppStorage("currentExperience") internal var currentExperince: Double = 0 {
        didSet {
            if self.currentExperince >= 2000 {
                self.currentRank += 1
                self.currentExperince = 0
            }
        }
    }
    
    @Published var audioPlayer: AVAudioPlayer?
    @AppStorage("sounds") var soundVolume: Double = 1 {
        didSet {
            self.audioPlayer?.volume = Float(self.soundVolume)
        }
    }
    @AppStorage("currentRank") internal var currentRank: Int = 1
    @AppStorage("selectedLogo") internal var selectedLogo: String = ""
    @AppStorage("name") internal var name: String = ""
    @Published var roultteIsDisabled: Bool = false
    @Published var moneyIsDisable: Bool = false
    
    @AppStorage("energy") internal var energy: Int = 10
    @AppStorage("coin") internal var coin: Int = 100
    
    @Published internal var logos: [String] = [
        "biue", "bl", "grin", "fi", "kri", "ku", "min", "pu"
    ]
    @Published var achievement: [String] = []
    
    private let roulettePressed = "roulettePressed"
    private let timerPressed = "timerPressed"
    @Published var rouletteRemainingTimeText: String = ""
    @Published var goldRemainingTimer: String = ""
    private let rouletteCooldown: TimeInterval = 24 * 60 * 60  // 24 hours in seconds
    private let goldCooldown: TimeInterval = 10 * 60
    
    private var timer: AnyCancellable?
    private var goldTimer: AnyCancellable?
    
    init() {
        self.checkRouletteState()
        self.moneyCounter()
        self.playSound()
    }
    
    func roulettePressedAction() {
        handleButtonPress()
    }
    func playSound() {
        if let url = Bundle.main.url(forResource: "kaasinoBg", withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.volume = Float(self.soundVolume)
                audioPlayer?.numberOfLoops = -1
                audioPlayer?.play()
            } catch {
                print("Error")
            }
        }
    }
    
    private func handleButtonPress() {
        let now = Date()
        UserDefaults.standard.set(now, forKey: roulettePressed)
        roultteIsDisabled = true
        updateRemainingTime(cooldownTime: rouletteCooldown)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + rouletteCooldown) {
            self.roultteIsDisabled = false
            self.rouletteRemainingTimeText = ""
        }
    }
    
     func goldPressed() {
        let now = Date()
        UserDefaults.standard.set(now, forKey: timerPressed)
        moneyIsDisable = true
        updateMoneyTimer(cooldownTime: goldCooldown)
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + goldCooldown) {
            self.moneyIsDisable = false
            self.goldRemainingTimer = ""
        }
    }
    
    private func checkRouletteState() {
        if let lastPress = UserDefaults.standard.object(forKey: roulettePressed) as? Date {
            let timeElapsed = Date().timeIntervalSince(lastPress)
            if timeElapsed < rouletteCooldown {
                roultteIsDisabled = true
                updateRemainingTime(cooldownTime: rouletteCooldown - timeElapsed)
                DispatchQueue.main.asyncAfter(deadline: .now() + (rouletteCooldown - timeElapsed)) {
                    self.roultteIsDisabled = false
                    self.rouletteRemainingTimeText = ""
                }
            }
        }


    }
    
    private func updateRemainingTime(cooldownTime: TimeInterval) {
        timer?.cancel()
        var remaining = cooldownTime
        
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                if remaining > 0 {
                    remaining -= 1
                    let hours = Int(remaining) / 3600
                    let minutes = (Int(remaining) % 3600) / 60
                    let seconds = Int(remaining) % 60
                    self.rouletteRemainingTimeText = String(format: "%02d:%02d", hours, minutes, seconds)
                } else {
                    self.timer?.cancel()
                }
            }
    }
    
    private func moneyCounter() {
        if let lastPress = UserDefaults.standard.object(forKey: timerPressed) as? Date {
            let timeElapsed = Date().timeIntervalSince(lastPress)
            if timeElapsed < self.goldCooldown {
                moneyIsDisable = true
                updateMoneyTimer(cooldownTime: self.goldCooldown - timeElapsed)
                DispatchQueue.main.asyncAfter(deadline: .now() + (self.goldCooldown - timeElapsed)) {
                    self.moneyIsDisable = false
                    self.goldRemainingTimer = ""
                }
            }
        }
    }
    
    private func updateMoneyTimer(cooldownTime: TimeInterval) {
        goldTimer?.cancel()
        var remaining = cooldownTime
        
        goldTimer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                if remaining > 0 {
                    remaining -= 1
                    let minutes = (Int(remaining) % 3600) / 60
                    let seconds = Int(remaining) % 60
                    self.goldRemainingTimer = String(format: "%02d:%02d", minutes, seconds)
                } else {
                    self.goldTimer?.cancel()
                }
            }
    }
}
import SwiftUI

extension Color {
    init(hex: String) {
        var cleanHexCode = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        cleanHexCode = cleanHexCode.replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        
        Scanner(string: cleanHexCode).scanHexInt64(&rgb)
        
        let redValue = Double((rgb >> 16) & 0xFF) / 255.0
        let greenValue = Double((rgb >> 8) & 0xFF) / 255.0
        let blueValue = Double(rgb & 0xFF) / 255.0
        self.init(red: redValue, green: greenValue, blue: blueValue)
    }
}
