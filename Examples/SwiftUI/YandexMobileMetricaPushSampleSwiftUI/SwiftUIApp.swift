//
//  SwiftUIApp.swift
//
//  This file is a part of the AppMetrica
//
//  Version for iOS © 2022 YANDEX
//
//  You may not use this file except in compliance with the License.
//  You may obtain a copy of the License at https://yandex.com/legal/metrica_termsofuse/
//

import SwiftUI

@main
struct SwiftUIApp: App {

    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
