//
//  AppDelegate.swift
//
//  This file is a part of the AppMetrica
//
//  Version for iOS © 2022 YANDEX
//
//  You may not use this file except in compliance with the License.
//  You may obtain a copy of the License at https://yandex.com/legal/metrica_termsofuse/
//

import UIKit

import YandexMobileMetrica
import YandexMobileMetricaPush

class AppDelegate: NSObject, UIApplicationDelegate, ObservableObject {

    @Published var isGranted: Bool = false

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {


        // Replace API_KEY with your unique API key. Please, read official documentation to find out how to obtain one:
        //         https://tech.yandex.com/metrica-mobile-sdk/doc/mobile-sdk-dg/tasks/swift-quickstart-docpage/
        YMMYandexMetrica.activate(with: YMMYandexMetricaConfiguration(apiKey: "API_KEY")!)
        YMPYandexMetricaPush.setExtensionAppGroup("EXTENSION_AND_APP_SHARED_APP_GROUP_NAME")

        let delegate = YMPYandexMetricaPush.userNotificationCenterDelegate()
        // You can add this delegate as a middleware before your own delegate:
        // delegate.nextDelegate = ownDelegate
        // or call methods of YMPYandexMetricaPush.userNotificationCenterHandler() from yours
        UNUserNotificationCenter.current().delegate = delegate


        // Track remote notification from application launch options.
        // Method YMMYandexMetrica.activate should be called before using this method.
        YMPYandexMetricaPush.handleApplicationDidFinishLaunching(options: launchOptions)

        self.registerForPushNotification(with: application)
        return true
    }

    private func registerForPushNotification(with application: UIApplication) {
        let center = UNUserNotificationCenter.current()
        let category = UNNotificationCategory(identifier: "Custom category",
                                              actions: [],
                                              intentIdentifiers: [],
                                              options:UNNotificationCategoryOptions.customDismissAction)
        // Only for push notifications of this category dismiss action will be tracked.
        center.setNotificationCategories(Set([category]))
        center.requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
            DispatchQueue.main.async {
                self.isGranted = granted
            }
        }
        application.registerForRemoteNotifications()
    }

    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
#if DEBUG
        let pushEnvironment = YMPYandexMetricaPushEnvironment.development
#else
        let pushEnvironment = YMPYandexMetricaPushEnvironment.production
#endif
        YMPYandexMetricaPush.setDeviceTokenFrom(deviceToken, pushEnvironment: pushEnvironment)
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        self.handlePushNotification(userInfo)
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        self.handlePushNotification(userInfo)
        completionHandler(.newData)
    }

    func handlePushNotification(_ userInfo: [AnyHashable : Any]) {
        // Track received remote notification.
        // Method YMMYandexMetrica.activate should be called before using this method.
        YMPYandexMetricaPush.handleRemoteNotification(userInfo)

        // Check if notification is related to AppMetrica (optionally)
        if YMPYandexMetricaPush.isNotificationRelated(toSDK: userInfo) {
            // Get user data from remote notification.
            let userData = YMPYandexMetricaPush.userData(forNotification: userInfo)
            print("User Data: %@", userData?.description ?? "[no data]")
        } else {
            print("Push is not related to AppMetrica")
        }
    }

    //MARK: - SceneDelegate
    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession:
                     UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let sceneConfig = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        if connectingSceneSession.role == .windowApplication {
            sceneConfig.delegateClass = SceneDelegate.self
        }
        return sceneConfig
    }
}
