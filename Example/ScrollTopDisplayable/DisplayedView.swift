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
    
	var configHandler: ((CGFloat) -> Void)?
    
	override func awakeFromNib() {
		super.awakeFromNib()
		
		backgroundColor = .green
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
        config()
	}
}
