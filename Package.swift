// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "TypewriterText",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "TypewriterText",
            targets: ["TypewriterText"]
        )
    ],
    targets: [
        .target(
            name: "TypewriterText"
        ),
        .testTarget(
            name: "TypewriterTextTests",
            dependencies: ["TypewriterText"]
        )
    ]
)
