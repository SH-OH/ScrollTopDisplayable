import UIKit

private var sdVerticalDirectionLastOffsetYKey: CGFloat?

extension UIScrollView {
    
    enum SDVerticalDirection {
        
        case none
        case up
        case down
    }
    
    var verticalDirection: SDVerticalDirection {
        let lastOffsetY: CGFloat = getAssociatedObject(self, &sdVerticalDirectionLastOffsetYKey) ?? 0
        let contentOffsetY = contentOffset.y
        
        if lastOffsetY > contentOffsetY {
            setRetainedAssociatedObject(self, &sdVerticalDirectionLastOffsetYKey, contentOffsetY)
            return .down
        } else if lastOffsetY < contentOffsetY {
            setRetainedAssociatedObject(self, &sdVerticalDirectionLastOffsetYKey, contentOffsetY)
            return .up
        }
        
        setRetainedAssociatedObject(self, &sdVerticalDirectionLastOffsetYKey, contentOffsetY)
        return .none
    }
}
