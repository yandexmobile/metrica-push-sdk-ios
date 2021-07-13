# Yandex AppMetrica Push SDK Change Log

## Version 1.0.0
SDK archive: [**download**](https://storage.mds.yandex.net/get-appmetrica-mobile-sdk/128534/YandexMobileMetricaPush-1.0.0-ios-11df8ee2-df87-4f7f-a7b1-1c0718953680.zip)

* Added support for iPhone and AppleTV simulators running on Apple Silicon Macs (M1)
* Added Swift Package Manager distribution.
* Stopped supporting iOS 8.

#### Notice
> CocoaPods 1.10 or Carthage 0.38 now required for `.xcframework`.

## Version 0.9.2
SDK archive: [**download**](https://storage.mds.yandex.net/get-appmetrica-mobile-sdk/175948/YandexMobileMetricaPush-0.9.2-ios-d8224e1b-10ac-4bdc-8c1b-498370d10714.zip)

* Added the API for downloading attachments

## Version 0.8.0
SDK archive: [**download**](https://storage.mds.yandex.net/get-appmetrica-mobile-sdk/50347/YandexMobileMetricaPush-0.8.0-ios-076122fd-824a-4ccf-8006-7c61145d8475.zip)

* Added the API for manual push tracking with the custom UNUserNotificationCenterDelegate implementation

## Version 0.7.2
SDK archive: [**download**](https://storage.mds.yandex.net/get-appmetrica-mobile-sdk/50347/YandexMobileMetricaPush-0.7.2-ios-c995c336-b8ef-4127-8582-95d104fa6aa3.zip)

* Fixed dynamic framework

## Version 0.7.1
SDK archive: [**download**](https://storage.mds.yandex.net/get-appmetrica-mobile-sdk/128534/YandexMobileMetricaPush-0.7.1-ios-f66a77cc-28fd-4961-becb-eb5cf9480512.zip)

* Added the userNotificationCenter:openSettingsForNotification: proxy delegate
* Fixed crash on setting a nil token
* Moved push permissions obtainment to the main queue
* Updated the YandexMobileMetrica dependency

## Version 0.7.0
SDK archive: [**download**](https://storage.mds.yandex.net/get-appmetrica-mobile-sdk/50347/YandexMobileMetricaPush-0.7.0-ios-d4c21d78-f9ae-4804-90b5-011dd892c25d.zip)

* Added tracking of push notifications appearance/dismiss
* Added tracking of notifications types user is subscribed to

## Version 0.6.0
SDK archive: [**download**](https://storage.mds.yandex.net/get-appmetrica-mobile-sdk/50347/YandexMobileMetricaPush-0.6.0-ios-1630b840-b7b4-4069-a6fa-c95ccc12ff58.zip)

* Updated YandexMobileMetrica dependency

## Version 0.5.1
SDK archive: [**download**](https://storage.mds.yandex.net/get-appmetrica-mobile-sdk/117488/YandexMobileMetricaPush-0.5.1-ios-acb81a52-6f82-486c-97f1-79c6ee030f81.zip)

* Fixed crash when opening URL from push notification
* Fixed double URL opening from push notification

## Version 0.5.0
SDK archive: [**download**](https://storage.mds.yandex.net/get-appmetrica-mobile-sdk/48248/YandexMobileMetricaPush-0.5.0-ios-e53d133c-7449-4c0a-b71e-218bdd08dc18.zip)

* Supported iOS 10+ in-app notifications.
* Added method for identification push notifications related to AppMetrica Push SDK.
* Added method for sending APNs environment with device token.

## Version 0.4.0
SDK archive: [**download**](https://storage.mds.yandex.net/get-appmetrica-mobile-sdk/117488/YandexMobileMetricaPush-0.4.0-ios-9800b76d-af31-4df9-b551-e5c443aadb0e.zip)

* Added URL from push notification opening.
* Added dynamic framework.
* Subspec **DynamicDependencies** is replaced with **Dynamic**.
* Default subspec **StaticDependencies** is replaced with **Static**.

## Version 0.3.0
SDK archive: [**download**](https://storage.mds.yandex.net/get-appmetrica-mobile-sdk/50347/YandexMobileMetricaPush-0.3.0-ios-75366102-cafd-49b0-b97c-3d5366fc76b8.zip)

* Initial release.
