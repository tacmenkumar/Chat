//
//  UIView+Extension.swift
//  Chat
//
//  Created by Niraj Kumar on 4/21/16.
//  Copyright © 2016 Niraj Kumar. All rights reserved.
//

import UIKit
import Foundation
import QuartzCore
import ObjectiveC


extension UIView  {
    
    var topLeftRightCorner : CGFloat {return self.topLeftRightCorner}
    
    func setTopLeftRightCorner (topLeftRightCorner: CGFloat) -> Void {
        let maskPath = UIBezierPath.init(roundedRect: self.frame, byRoundingCorners: [.TopLeft, .TopRight] , cornerRadii: CGSize(width: topLeftRightCorner, height: topLeftRightCorner))
        let maskLayer = CAShapeLayer(layer: self.layer)
        maskLayer.frame = self.frame
        maskLayer.path = maskPath.CGPath
        self.layer.mask = maskLayer
        self.layer.masksToBounds = true
    }
}
