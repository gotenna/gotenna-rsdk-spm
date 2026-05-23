// swift-tools-version:6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let version = "3.4.15"
let moduleName = "RSDK"

// shasum -a 256 <path-to-zip>
let checksum = "7a9c6a7c9eee9f881582865b4d42373d2ae94358a1a0be8537be92353c26b10c"

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
