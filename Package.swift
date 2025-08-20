// swift-tools-version:6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let version = "3.3.19"
let moduleName = "RSDK"

// shasum -a 256 <path-to-zip>
let checksum = "c9ca521b5f911e174939025ba9c050659b98defc68c3d057443d5751b2aab613"

let package = Package(
    name: moduleName,
    products: [
        .library(
            name: moduleName,
            targets: [moduleName]
        )
    ],
    targets: [
        .binaryTarget(
            name: moduleName,
            url: "https://gotenna.jfrog.io/artifactory/android-libs-release-local/com/gotenna/sdk/radio-sdk-external-ios/\(version)/radio-sdk-external-ios-\(version).zip",
            checksum: checksum
        )
    ]
)
