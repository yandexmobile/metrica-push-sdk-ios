//
//  ContentView.swift
//
//  This file is a part of the AppMetrica
//
//  Version for iOS © 2022 YANDEX
//
//  You may not use this file except in compliance with the License.
//  You may obtain a copy of the License at https://yandex.com/legal/metrica_termsofuse/
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var appDelegate: AppDelegate
    @EnvironmentObject private var sceneDelegate: SceneDelegate
    
    var body: some View {
        Text("Permission: \(appDelegate.isGranted ? "Granted" : "Not granted")")
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
