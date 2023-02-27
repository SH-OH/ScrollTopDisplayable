# ScrollTopDisplayable

Follow the scroll to show or hide the view at the top.

## Usage

```
import UIKit
import ScrollTopDisplayable

class View: UIView, ScrollTopDisplayable {

}

extension View: ScrollTopDisplayable {

    var startFrameY: CGFloat { 0 }
    var viewHeight: CGFloat { 50.0 }
}

```


## Installation

### Cocoapods

```
pod 'ScrollTopDisplayable'
```

### Swift Package Manager

File > Swift Packages > Add Package Dependency
Add https://github.com/SH-OH/ScrollTopDisplayable.git

*OR*

```
dependencies: [
    .package(url: "https://github.com/SH-OH/ScrollTopDisplayable.git", .upToNextMajor(from: "1.0.0"))
]
```