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
import UserNotifications // iOS 10

import YandexMobileMetrica
import YandexMobileMetricaPush

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool
    {
        // Replace API_KEY with your unique API key. Please, read official documentation to find out how to obtain one:
        // https://tech.yandex.com/metrica-mobile-sdk/doc/mobile-sdk-dg/tasks/swift-quickstart-docpage/
        YMMYandexMetrica.activate(withApiKey: "API_KEY")

        // Track remote notification from application launch options.
        // Method [YMMYandexMetrica activateWithApiKey:] should be called before using this method.
        YMPYandexMetricaPush.handleApplicationDidFinishLaunching(options: launchOptions)

        self.registerForPushNotificationsWithApplication(application)
        return true
    }

    func registerForPushNotificationsWithApplication(_ application: UIApplication)
    {
        // Register for push notifications
        if #available(iOS 8.0, *) {
            if #available(iOS 10.0, *) {
                // iOS 10.0 and above
                let center = UNUserNotificationCenter.current()
                center.requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
                    // Enable or disable features based on authorization.
                }
            } else {
                // iOS 8 and iOS 9
                let settings = UIUserNotificationSettings(types: [.badge, .alert, .sound], categories: nil)
                application.registerUserNotificationSettings(settings)
            }
            application.registerForRemoteNotifications()
        } else {
            // iOS 7
            application.registerForRemoteNotifications(matching: [.badge, .alert, .sound])
        }
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
        // Method YMMYandexMetrica.activate should be called before using this method.
        YMPYandexMetricaPush.handleRemoteNotification(userInfo)

        // Get user data from remote notification.
        let userData = YMPYandexMetricaPush.userData(forNotification: userInfo)
        print("User Data: %@", userData?.description ?? "[no data]")
    }

}
