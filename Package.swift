// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "NES",
    platforms: [.iOS(.v14)],
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
                "Info.plist"
            ]
        )
    ]
)

