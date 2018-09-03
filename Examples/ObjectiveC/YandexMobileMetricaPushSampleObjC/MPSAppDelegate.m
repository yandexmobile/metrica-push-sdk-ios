//
//  MPSAppDelegate.m
//
//  This file is a part of the AppMetrica
//
//  Version for iOS © 2017 YANDEX
//
//  You may not use this file except in compliance with the License.
//  You may obtain a copy of the License at https://yandex.com/legal/metrica_termsofuse/
//

#import "MPSAppDelegate.h"

#import <UserNotifications/UserNotifications.h> // iOS 10

#import <YandexMobileMetrica/YandexMobileMetrica.h>
#import <YandexMobileMetricaPush/YandexMobileMetricaPush.h>

@implementation MPSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Replace API_KEY with your unique API key. Please, read official documentation to find out how to obtain one:
    // https://tech.yandex.com/metrica-mobile-sdk/doc/mobile-sdk-dg/tasks/ios-quickstart-docpage/
    [YMMYandexMetrica activateWithConfiguration:[[YMMYandexMetricaConfiguration alloc] initWithApiKey:@"API_KEY"]];
    [YMPYandexMetricaPush setExtensionAppGroup:@"EXTENSION_AND_APP_SHARED_APP_GROUP_NAME"];

    // Enable in-app push notifications handling in iOS 10
    if ([UNUserNotificationCenter class] != Nil) {
        id<YMPUserNotificationCenterDelegate> delegate = [YMPYandexMetricaPush userNotificationCenterDelegate];
        // You can add this delegate as a middleware before your own delegate:
        // delegate.nextDelegate = ownDelegate;
        [UNUserNotificationCenter currentNotificationCenter].delegate = delegate;
    }

    // Track remote notification from application launch options.
    // Method [YMMYandexMetrica activateWithApiKey:] should be called before using this method.
    [YMPYandexMetricaPush handleApplicationDidFinishLaunchingWithOptions:launchOptions];

    [self registerForPushNotificationsWithApplication:application];
    return YES;
}

- (void)registerForPushNotificationsWithApplication:(UIApplication *)application
{
    // Register for push notifications
    if ([application respondsToSelector:@selector(registerForRemoteNotifications)]) {
        if (NSClassFromString(@"UNUserNotificationCenter") != Nil) {
            // iOS 10.0 and above
            UNAuthorizationOptions options =
                UNAuthorizationOptionAlert |
                UNAuthorizationOptionBadge |
                UNAuthorizationOptionSound;
            UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
            UNNotificationCategory *category = [UNNotificationCategory
                                                categoryWithIdentifier:@"Custom category"
                                                actions:@[]
                                                intentIdentifiers:@[]
                                                options:UNNotificationCategoryOptionCustomDismissAction];
            // Only for push notifications of this category dismiss action will be tracked.
            [center setNotificationCategories:[NSSet setWithObject:category]];
            [center requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError *error) {
                // Enable or disable features based on authorization.
            }];
        }
        else {
            // iOS 8 and iOS 9
            UIUserNotificationType userNotificationTypes =
                UIUserNotificationTypeAlert |
                UIUserNotificationTypeBadge |
                UIUserNotificationTypeSound;
            UIUserNotificationSettings *settings =
                [UIUserNotificationSettings settingsForTypes:userNotificationTypes categories:nil];
            [application registerUserNotificationSettings:settings];
        }
        [application registerForRemoteNotifications];
    }
    else {
        // iOS 7
        UIRemoteNotificationType notificationTypes =
            UIRemoteNotificationTypeBadge |
            UIRemoteNotificationTypeSound |
            UIRemoteNotificationTypeAlert;
        [application registerForRemoteNotificationTypes:notificationTypes];
    }
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // Send device token and APNs environment(based on default build configuration) to AppMetrica Push server.
    // Method [YMMYandexMetrica activateWithApiKey:] has to be called before using this method.
#ifdef DEBUG
    YMPYandexMetricaPushEnvironment pushEnvironment = YMPYandexMetricaPushEnvironmentDevelopment;
#else
    YMPYandexMetricaPushEnvironment pushEnvironment = YMPYandexMetricaPushEnvironmentProduction;
#endif
    [YMPYandexMetricaPush setDeviceTokenFromData:deviceToken pushEnvironment:pushEnvironment];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [self handleRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [self handleRemoteNotification:userInfo];

    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)handleRemoteNotification:(NSDictionary *)userInfo
{
    // Track received remote notification.
    // Method [YMMYandexMetrica activateWithApiKey:] should be called before using this method.
    [YMPYandexMetricaPush handleRemoteNotification:userInfo];

    // Check if notification is related to AppMetrica (optionally)
    if ([YMPYandexMetricaPush isNotificationRelatedToSDK:userInfo]) {
        // Get user data from remote notification.
        NSString *userData = [YMPYandexMetricaPush userDataForNotification:userInfo];
        NSLog(@"User Data: '%@'", userData);
    }
    else {
        NSLog(@"Push is not related to AppMetrica");
    }
}

@end
