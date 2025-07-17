// swift-tools-version:6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let version = "3.3.19"
let moduleName = "RSDK"

// shasum -a 256 <path-to-zip>
let checksum = "d2d8ac8e60c916624903b7de4a12211c2e1736b81c2390ce5a01f8ca43efd015"

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
