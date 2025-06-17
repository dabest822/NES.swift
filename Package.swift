// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "NES",
    platforms: [.iOS(.v14), .macOS(.v12)],
    products: [
        .library(name: "NES", targets: ["NES"])
    ],
    targets: [
        // core library
        .target(
            name: "NES",
            path: "NES",                 // CPU.swift, PPU.swift, …
            exclude: ["../Emulator", "../Assets.xcassets", "../Info.plist"]
        ),

        // unit tests (XCTest stays here, won’t leak into your app)
        .testTarget(
            name: "NESTests",
            dependencies: ["NES"],
            path: "Tests"
        )
    ]
)
