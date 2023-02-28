import UIKit

private var sdScrollTopDisplayableIsRendered: Void?
private var sdScrollTopDisplayableViewHeight: CGFloat?
private var sdScrollTopDisplayableStartFrameY: CGFloat?
private var sdScrollTopDisplayablePrevieousFrameY: CGFloat?
private var sdScrollTopDisplayableLastContentOffsetY: CGFloat?

public protocol ScrollTopDisplayable: UIView {
	
    var isVisible: Bool { get }
    
    var configHandler: ((_ viewHeight: CGFloat) -> Void)? { get set }
    /// Use the `configure` function with `configHandler` closure. This method is called once. For example:
    ///
    ///     - View: ScrollTopDisplayable
    ///
    ///     override func layoutSubviews() {
    ///         super.layoutSubviews()
    ///
    ///         configure()
    ///     }
    ///
    ///     - ViewController
    ///     
    ///     override func viewDidLoad() {
    ///         super.viewDidLoad()
    ///
    ///         view.configHandler = { [weak self] viewHeight in
    ///             self?.scrollView.contentInset.top = viewHeight
    ///             self?.scrollView.contentOffset.y = -viewHeight
    ///             if #available(iOS 11.1, *) {
    ///                 self?.scrollView.verticalScrollIndicatorInsets.top = viewHeight
    ///             }
    ///         }
    ///     }
    func configure(frameY: CGFloat?, height: CGFloat?)
    
	func didScroll(_ scrollView: UIScrollView)
    
	/// Use 'syncPreviousFrameY' function on `layoutSubviews`, if forced to update layouts.
	func syncPreviousFrameY()
}

public extension ScrollTopDisplayable {
    
    var isVisible: Bool {
        get {
            guard let lastContentOffsetY: CGFloat = getAssociatedObject(self, &sdScrollTopDisplayableLastContentOffsetY) ?? 0 else { return true }
            guard let viewHeight: CGFloat = getAssociatedObject(self, &sdScrollTopDisplayableViewHeight) ?? 0 else { return true }
            
            return lastContentOffsetY < viewHeight
        }
    }
    
    func configure(frameY: CGFloat? = nil, height: CGFloat? = nil) {
        if let isRendered: Void? = getAssociatedObject(self, &sdScrollTopDisplayableIsRendered), isRendered != nil {
            return
        }
        
        let viewHeight = frame.height
        
        setRetainedAssociatedObject(self, &sdScrollTopDisplayableViewHeight, viewHeight)
        setRetainedAssociatedObject(self, &sdScrollTopDisplayableStartFrameY, frame.origin.y)
        setRetainedAssociatedObject(self, &sdScrollTopDisplayableIsRendered, ())
        
        configHandler?(viewHeight)
    }
    
	func didScroll(_ scrollView: UIScrollView) {
		let lastContentOffsetY: CGFloat = getAssociatedObject(self, &sdScrollTopDisplayableLastContentOffsetY) ?? 0
        let viewHeight: CGFloat = getAssociatedObject(self, &sdScrollTopDisplayableViewHeight) ?? 0
        let startFrameY: CGFloat = getAssociatedObject(self, &sdScrollTopDisplayableStartFrameY) ?? 0
		let previousFrameY: CGFloat = getAssociatedObject(self, &sdScrollTopDisplayablePrevieousFrameY) ?? startFrameY
		let verticalDirection = scrollView.verticalDirection
		let contentOffsetY = scrollView.contentOffset.y + viewHeight
		let diffY = lastContentOffsetY - contentOffsetY
        
		defer {
			setRetainedAssociatedObject(self, &sdScrollTopDisplayableLastContentOffsetY, contentOffsetY)
		}
		
		if diffY.isNaN {
			return
		}
		
		switch verticalDirection {
		case .up:
			guard contentOffsetY > 0 else { break }
			
			if frame.origin.y > previousFrameY {
				frame.origin.y = previousFrameY
			}
			
			frame.origin.y += diffY
			
			let topPinY = -abs(startFrameY - viewHeight)
			if frame.origin.y <= topPinY {
				frame.origin.y = topPinY
			}
			
			setRetainedAssociatedObject(self, &sdScrollTopDisplayablePrevieousFrameY, frame.origin.y)
            
		case .down:
			guard lastContentOffsetY >= contentOffsetY else { break }
			
			frame.origin.y += diffY
			
			if frame.origin.y >= startFrameY {
				frame.origin.y = startFrameY
			}
			
			setRetainedAssociatedObject(self, &sdScrollTopDisplayablePrevieousFrameY, frame.origin.y)
            
		case .none:
			break
		}
	}
	
	func syncPreviousFrameY() {
		frame.origin.y = getAssociatedObject(self, &sdScrollTopDisplayablePrevieousFrameY) ?? 0
	}
}
