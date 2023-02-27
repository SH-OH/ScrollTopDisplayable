//
//  DisplayedView.swift
//  ScrollTopDisplayable_Example
//
//  Created by Oh Sangho on 2023/02/27.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit
import ScrollTopDisplayable

final class DisplayedView: UIView, ScrollTopDisplayable {
	
	private var isFirstRendering: Bool = true
	
	private(set) var startFrameY: CGFloat = 0
	private(set) var viewHeight: CGFloat = 0
	
	var frameLayoutHandler: ((CGFloat) -> Void)?
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		backgroundColor = .green
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		if isFirstRendering {
			startFrameY = frame.origin.y
			viewHeight = frame.height
			frameLayoutHandler?(viewHeight)
			isFirstRendering = false
			print("2. \(frame)")
		}
		
//		syncPreviousFrameY()
	}
}
