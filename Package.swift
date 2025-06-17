// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "NES",
    platforms: [
        .iOS(.v14), .macOS(.v12)
    ],
    products: [
        .library(name: "NES", targets: ["NES"])
    ],
    targets: [
        .target(
            name: "NES",
            path: "Sources/NES",      // ← exact path shown above
            exclude: [],             // nothing to exclude
            resources: []            // no localized assets = no defaultLocalization needed
        ),
        .testTarget(
            name: "NESTests",
            dependencies: ["NES"],
            path: "Tests"
        )
    ]
)
