// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "NES",
    defaultLocalization: "en",
    platforms: [.iOS(.v13)],
    products: [
        .library(name: "NES", targets: ["NES"])
    ],
    targets: [
        .target(
            name: "NES",
            path: ".",                 // 👈 compile every folder
            exclude: [
                "NES.xcodeproj",
                "NES.xcworkspace",
                "Assets.xcassets",
                "Base.lproj",
                "Info.plist",
                "AppDelegate.swift",
                "NES Tests"
            ]
        )
    ]
)

