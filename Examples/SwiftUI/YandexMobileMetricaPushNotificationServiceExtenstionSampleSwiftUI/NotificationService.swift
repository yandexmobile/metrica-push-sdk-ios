//
//  NotificationService.swift
//
//  This file is a part of the AppMetrica
//
//  Version for iOS © 2018 YANDEX
//
//  You may not use this file except in compliance with the License.
//  You may obtain a copy of the License at https://yandex.com/legal/metrica_termsofuse/
//

import UserNotifications
import YandexMobileMetricaPush

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        if let bestAttemptContent = bestAttemptContent {
            // Modify the notification content here...

            YMPYandexMetricaPush.setExtensionAppGroup("EXTENSION_AND_APP_SHARED_APP_GROUP_NAME")
            YMPYandexMetricaPush.handleDidReceive(request)
            
            contentHandler(bestAttemptContent)
        }
    }
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }

}
