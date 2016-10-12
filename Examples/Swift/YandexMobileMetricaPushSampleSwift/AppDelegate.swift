//
//  AppDelegate.swift
//
//  This file is a part of the AppMetrica
//
//  Version for iOS © 2016 YANDEX
//
//  You may not use this file except in compliance with the License.
//  You may obtain a copy of the License at https://yandex.com/legal/metrica_termsofuse/
//

import UIKit

import YandexMobileMetrica
import YandexMobileMetricaPush

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    override class func initialize()
    {
        if self === AppDelegate.self {
            // Replace API_KEY with your unique API key. Please, read official documentation how to obtain one:
            // https://tech.yandex.com/metrica-mobile-sdk/doc/mobile-sdk-dg/tasks/swift-quickstart-docpage/
            YMMYandexMetrica.activate(withApiKey: "API_KEY")
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
        // Track remote notification from application launch options.
        // Method [YMMYandexMetrica activateWithApiKey:] should be called before using this method.
        YMPYandexMetricaPush.handleApplicationDidFinishLaunching(options: launchOptions)
        return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data)
    {
        // Send device token to AppMetrica Push server.
        // Method [YMMYandexMetrica activateWithApiKey:] has to be called before using this method.
        YMPYandexMetricaPush.setDeviceTokenFrom(deviceToken)
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any])
    {
        self.handlePushNotification(userInfo)
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void)
    {
        self.handlePushNotification(userInfo)
        completionHandler(.newData)
    }

    func handlePushNotification(_ userInfo: [AnyHashable : Any])
    {
        // Track received remote notification.
        // Method [YMMYandexMetrica activateWithApiKey:] should be called before using this method.
        YMPYandexMetricaPush.handleRemoteNotification(userInfo)

        // Get user data from remote notification.
        let userData = YMPYandexMetricaPush.userData(forNotification: userInfo)
        print("User Data: %@", userData)
    }

}
