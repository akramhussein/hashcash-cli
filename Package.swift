import PackageDescription

let package = Package(
    name: "hashcash-cli",
    targets: [],
    dependencies: [
        .Package(url: "https://github.com/akramhussein/Hashcash", Version(0, 0, 1)),
        .Package(url: "https://github.com/IngmarStein/CommandLine", Version(2, 2, 0)),
    ]
)
