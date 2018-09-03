//
//  AppDelegate.swift
//
//  This file is a part of the AppMetrica
//
//  Version for iOS © 2017 YANDEX
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
        YMMYandexMetrica.activate(with: YMMYandexMetricaConfiguration(apiKey: "API_KEY")!)
        YMPYandexMetricaPush.setExtensionAppGroup("EXTENSION_AND_APP_SHARED_APP_GROUP_NAME")

        // Enable in-app push notifications handling in iOS 10
        if #available(iOS 10.0, *) {
            let delegate = YMPYandexMetricaPush.userNotificationCenterDelegate()
            // You can add this delegate as a middleware before your own delegate:
            // delegate.nextDelegate = ownDelegate
            UNUserNotificationCenter.current().delegate = delegate
        }

        // Track remote notification from application launch options.
        // Method YMMYandexMetrica.activate should be called before using this method.
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
                let category = UNNotificationCategory(identifier: "Custom category",
                                                      actions: [],
                                                      intentIdentifiers: [],
                                                      options:UNNotificationCategoryOptions.customDismissAction)
                // Only for push notifications of this category dismiss action will be tracked.
                center.setNotificationCategories(Set([category]))
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
        // Send device token and APNs environment(based on default build configuration) to AppMetrica Push server.
        // Method YMMYandexMetrica.activate has to be called before using this method.
#if DEBUG
        let pushEnvironment = YMPYandexMetricaPushEnvironment.development
#else
        let pushEnvironment = YMPYandexMetricaPushEnvironment.production
#endif
        YMPYandexMetricaPush.setDeviceTokenFrom(deviceToken, pushEnvironment: pushEnvironment)
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

        // Check if notification is related to AppMetrica (optionally)
        if YMPYandexMetricaPush.isNotificationRelated(toSDK: userInfo) {
            // Get user data from remote notification.
            let userData = YMPYandexMetricaPush.userData(forNotification: userInfo)
            print("User Data: %@", userData?.description ?? "[no data]")
        } else {
            print("Push is not related to AppMetrica")
        }
    }

}
