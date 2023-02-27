import UIKit

private var sdScrollTopDisplayableLastContentOffsetY: CGFloat?
private var sdScrollTopDisplayablePrevieousFrameY: CGFloat?

public protocol ScrollTopDisplayable: UIView {
	
	/// layouted view first frame Y.
	var startFrameY: CGFloat { get }
	/// layouted frame height.
	var viewHeight: CGFloat { get }
	
	func didScroll(_ scrollView: UIScrollView)
	/// If layout of the view update, recommends sync on layoutSubviews.
	func syncPreviousFrameY()
}

public extension ScrollTopDisplayable {
	
	func didScroll(_ scrollView: UIScrollView) {
		let lastContentOffsetY: CGFloat = getAssociatedObject(self, &sdScrollTopDisplayableLastContentOffsetY) ?? 0
		let previousFrameY: CGFloat = getAssociatedObject(self, &sdScrollTopDisplayablePrevieousFrameY) ?? 0
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
			
			if !previousFrameY.isZero, frame.origin.y > previousFrameY {
				frame.origin.y = previousFrameY
			}// 97 > 0 >>> y = 0
			
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
