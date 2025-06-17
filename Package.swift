// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "NES",
    defaultLocalization: "en",
    platforms: [.iOS(.v16)],
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
                "Emulator",
                "Base.lproj",
                "Info.plist",
                "NES Tests",
                "Test Roms",
                "NES.xcworkspace"
            ]
        )
    ]
)

