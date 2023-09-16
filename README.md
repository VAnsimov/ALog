# ALogger

## Installation

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. It is in early development, but Alamofire does support its use on supported platforms.

Once you have your Swift package set up, adding Alamofire as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/VAnsimov/ALog.git", .upToNextMajor(from: "1.0.0"))
],
targets: [
    .target(name: "<YourPackageManager>", dependencies: ["ALog"]),
]
```

## Initialization


```swift
ALog.setup()
```

OR

```swift
class MyCustomALogger: ALoggerProtocol {

    func setup(trace: ALogger.Trace) {}

    func log(
        type: ALogTypeProtocol,
        message: String,
        trace: ALogger.Trace,
        subsystem: String,
        category: String
    ) {
        print("[\(category)] • (type.mark) (\(trace.file):\(trace.line) \(trace.function): \(message)")
    }
}

ALog.setup(loggers: [ConsoleALogger(), MyCustomALogger()])
```

## Usage:

```swift
ALog.error("Something went wrong")
// will print to the console:
// [Application] • 🚫 (SomeClass.swift:61) somefunction(): Something went wrong

ALog.success("It's a successful log")
// will print to the console:
// [Application] • ✅ (SomeClass.swift:61) somefunction(): It's a successful log

ALog.information("It's a information log", category: "ALog")
// will print to the console:
// [ALog] • ℹ️ (SomeClass.swift:65) somefunction(): It's a information log

ALog.warning("It's a warning log")
// will print to the console:
// [Application] • ⚠️ (SomeClass.swift:61) somefunction(): It's a warning log
```

OR

```swift
import os.log

struct MyLogType: ALogTypeProtocol {
    let identificator: String = "🖥"
    var mark: String { identificator }
    let osLogType: OSLogType = .default
}

ALog.log("Something went wrong", type: MyLogType())
// will print to the console:
// [Application] • 🖥 (SomeClass.swift:61) somefunction(): Something went wrong
```
