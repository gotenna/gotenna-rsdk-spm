// swift-tools-version:6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let version = "3.1.13"
let moduleName = "RSDK"

// shasum -a 256 <path-to-zip>
let checksum = "db81deab32340cda7e606bbbbb5485530c4bfc715817a265cedb614b15d6fd3a"

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