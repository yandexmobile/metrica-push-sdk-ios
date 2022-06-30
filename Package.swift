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
            "4.0.0" ..< "5.0.0"
        )
    ],
    
    targets: [
        .binaryTarget(
            name: "YandexMobileMetricaPush",
            url: "https://storage.mds.yandex.net/get-appmetrica-mobile-sdk/48248/YandexMobileMetricaPush-1.3.0-ios-spm-98ad2354-b91a-4b46-a627-c23939d0f1b9.zip",
            checksum: "ec17e741cd2def306de0e57c40b4e24ef371179b29496e2bee36adf476001c3c"
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
