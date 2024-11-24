//
//  KaasinoPlaceApp.swift
//  KaasinoPlace
//
//  Created by Kole Jukisr on 29/11/2024.
//

import SwiftUI

@main
struct KaasinoPlaceApp: App {
    @StateObject  private var userStorageGame: UserStorageGameClass = UserStorageGameClass.shared
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            NavigationView {
                LoadingViewCard()
            }
        }
    }
}
extension Font {
    static var kumar: String = "KumarOne-Regular"
}
