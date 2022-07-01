//
//  SceneDelegate.swift
//
//  This file is a part of the AppMetrica
//
//  Version for iOS © 2022 YANDEX
//
//  You may not use this file except in compliance with the License.
//  You may obtain a copy of the License at https://yandex.com/legal/metrica_termsofuse/
//

import UIKit

import YandexMobileMetricaPush

class SceneDelegate: NSObject, UIWindowSceneDelegate, ObservableObject {
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        // Track remote notification from scene connection options.
        YMPYandexMetricaPush.handleSceneWillConnectToSession(with: connectionOptions)
    }
}
