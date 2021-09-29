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
            url: "https://storage.mds.yandex.net/get-appmetrica-mobile-sdk/50347/YandexMobileMetricaPush-1.1.1-ios-spm-4ec3f510-c05b-467e-89ca-51b8151fc015.zip",
            checksum: "15c2183082fe2724e5818f5b62fffa37e6780413edd5076841691b8133166242"
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
