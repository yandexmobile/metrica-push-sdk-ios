// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "YandexMobileMetricaPush",
    platforms: [
        .iOS(.v9)
    ],
    
    products: [
        .library(name: "YandexMobileMetricaPush", targets: ["YandexMobileMetricaPushWrapper"]),
    ],
    
    dependencies: [
        .package(
            name:"YandexMobileMetrica",
            url: "https://github.com/yandexmobile/metrica-sdk-ios.git",
            "3.14.0" ..< "4.0.0"
        )
    ],
    
    targets: [
        .binaryTarget(
            name: "YandexMobileMetricaPush",
            url: "https://storage.mds.yandex.net/get-appmetrica-mobile-sdk/117488/YandexMobileMetricaPush-1.0.0-ios-spm-443d80c4-d02f-4fd5-9c25-70e5cf81bf88.zip",
            checksum: "68332fc87f5ace5ef135c859f9e095679370ef7df4026c0d807fc944ffa85d1f"
        ),
        .target(
            name: "YandexMobileMetricaPushWrapper",
            dependencies: [
                .target(name: "YandexMobileMetricaPush"),
                .product(name: "YandexMobileMetrica", package: "YandexMobileMetrica"),
            ],
            path: "YandexMobileMetricaPushWrapper",
            linkerSettings: [
                .linkedFramework("UserNotifications")
            ]
        ),
    ]
)
