# ScrollTopDisplayable

A protocol-based feature that displays or hides the view at the top based on scrolling.

## Preview

https://user-images.githubusercontent.com/50817510/221955138-8a11ea3d-8bfb-42d1-b29c-4234018a1250.mp4

## Usage

1. Configure to ScrollTopDisplayable View
```
import ScrollTopDisplayable

class View: UIView, ScrollTopDisplayable {
    
    var configHandler: ((CGFloat) -> Void)?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configure()
    }
}
```
2. Configure `scrollView` in ViewController
```
view.configHandler = { [weak self] viewHeight in
    self?.scrollView.contentInset.top = viewHeight
    self?.scrollView.contentOffset.y = -viewHeight
    if #available(iOS 11.1, *) {
        self?.scrollView.verticalScrollIndicatorInsets.top = viewHeight
    }
}
```
```
extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.didScroll(scrollView)
    }
}
```

## Installation

### Cocoapods

```
pod 'ScrollTopDisplayable'
```

### Swift Package Manager

1. File > Swift Packages > Add Package Dependency
2. Add https://github.com/SH-OH/ScrollTopDisplayable.git

*OR*

Update dependencies in Package.swift

```
dependencies: [
    .package(url: "https://github.com/SH-OH/ScrollTopDisplayable.git", .upToNextMajor(from: "1.0.0"))
]
```
