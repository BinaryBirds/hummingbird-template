// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "hummingbird-template",
    products: [
        .executable(name: "App", targets: ["App"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/hummingbird-project/hummingbird",
            from: "1.2.0"
        ),
        .package(
            url: "https://github.com/apple/swift-argument-parser",
            from: "1.0.0"
        ),
    ],
    targets: [
        .executableTarget(name: "App",
            dependencies: [
                .product(
                    name: "ArgumentParser",
                    package: "swift-argument-parser"
                ),
                .product(
                    name: "Hummingbird",
                    package: "hummingbird"
                ),
            ],
            swiftSettings: [
                .unsafeFlags(
                    ["-cross-module-optimization"],
                    .when(configuration: .release)
                ),
            ]
        ),
        .testTarget(name: "AppTests",
            dependencies: [
                .product(
                    name: "HummingbirdXCT",
                    package: "hummingbird"
                ),
                .target(name: "App"),
            ]
        )
    ]
)
