![SFDesignables: Elegant way to design your UI in storyboard](https://raw.githubusercontent.com/sudofluff/SSFDesignables/develop/sfdesignables.pdf)

SFDesignables is a collection of custom UIView subclasses that come with supports for storyboard.

- [Getting stated](#Getting started)
- [Credits](#Credits)
- [License](#License)

## Getting started

### Cocoapods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:
```bash
$ gem install cocoapods
```
To integrate Alamofire into your Xcode project using CocoaPods, specify it in your `Podfile`:
```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '11.3'
use_frameworks!

target '<Your Target Name>' do
    pod 'SFDesignables', '~> 0.1'
end
```
Then, run the following command:

```bash
$ pod install
```

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. It is in early development, but SFDesignables does support its use on supported platforms.

Once you have your Swift package set up, adding SFDesignables as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

#### Swift 4

```swift
dependencies: [
    .package(url: "https://github.com/sudofluff/SFDesignables.git", from: "0.1.2")
]
```

## Credits

SFDesignables is owned and maintained by [sudofluff](https://github.com/sudofluff).

## License

This project is licensed under MIT License - [see LICENSE](https://github.com/sudofluff/SFDesignables/blob/master/LICENSE) file for details.
