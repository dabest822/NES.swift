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
            /// <-- the repo’s real folder that holds CPU.swift, PPU.swift, etc.
            path: "NES",

            /// exclude demo-app stuff that would clash with your app
            exclude: [
                "../NES.xcodeproj",
                "../NES.xcworkspace",
                "../Emulator",          // sample Mac app
                "../Assets.xcassets",
                "../Base.lproj",
                "../AppDelegate.swift",
                "../Info.plist",
                "../ViewController.swift"
            ]
        )
    ]
)
