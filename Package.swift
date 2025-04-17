// swift-tools-version:6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let version = "3.1.15"
let moduleName = "RSDK"

// shasum -a 256 <path-to-zip>
let checksum = "087f7f6a601d611bca5cd67bec38108acdfda75bdc88df231e5a97fa6d8191eb"

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