//
//  MPSAppDelegate.m
//
//  This file is a part of the AppMetrica
//
//  Version for iOS © 2016 YANDEX
//
//  You may not use this file except in compliance with the License.
//  You may obtain a copy of the License at https://yandex.com/legal/metrica_termsofuse/
//

#import "MPSAppDelegate.h"

#import <YandexMobileMetrica/YandexMobileMetrica.h>
#import <YandexMobileMetricaPush/YandexMobileMetricaPush.h>

@implementation MPSAppDelegate

+ (void)initialize
{
    if ([self class] == [MPSAppDelegate class]) {
        // Replace API_KEY with your unique API key. Please, read official documentation how to obtain one:
        // https://tech.yandex.com/metrica-mobile-sdk/doc/mobile-sdk-dg/tasks/ios-quickstart-docpage/
        [YMMYandexMetrica activateWithApiKey:@"API_KEY"];
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Track remote notification from application launch options.
    // Method [YMMYandexMetrica activateWithApiKey:] should be called before using this method.
    [YMPYandexMetricaPush handleApplicationDidFinishLaunchingWithOptions:launchOptions];
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // Send device token to AppMetrica Push server.
    // Method [YMMYandexMetrica activateWithApiKey:] has to be called before using this method.
    [YMPYandexMetricaPush setDeviceTokenFromData:deviceToken];
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

    // Get user data from remote notification.
    NSString *userData = [YMPYandexMetricaPush userDataForNotification:userInfo];
    NSLog(@"User Data: '%@'", userData);
}

@end
