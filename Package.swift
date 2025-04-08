// swift-tools-version:6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let version = "3.2.5-iostest"
let moduleName = "RSDK"

// shasum -a 256 <path-to-zip>
let checksum = "381ae4f1c9f0f362ef7f4420331db52ad1a5910cf268bab03aff3c8754007472"

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
            url: "https://gotenna.jfrog.io/artifactory/android-libs-release-local/com/gotenna/sdk/radio-sdk-internal-ios/\(version)/radio-sdk-internal-ios-\(version).zip",
            checksum: checksum
        )
    ]
)