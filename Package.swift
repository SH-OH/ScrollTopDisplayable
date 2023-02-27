// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ScrollTopDisplayable",
	platforms: [
		.iOS(.v11)
	],
    products: [
        .library(
            name: "ScrollTopDisplayable",
            targets: ["ScrollTopDisplayable"]
		),
    ],
    targets: [
		.target(
			name: "ScrollTopDisplayable",
			path: "Sources"
		)
    ],
	swiftLanguageVersions: [
		.v5
	]
)
