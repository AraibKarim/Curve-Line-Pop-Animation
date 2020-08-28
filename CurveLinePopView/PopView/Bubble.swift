//
//  Bubble.swift
//  CurveLinePopView
//
//  Created by Araib on 10/11/2019.
//  Copyright © 2019 Woody Apps. All rights reserved.
//

import UIKit

class Bubble: CAShapeLayer, CAAnimationDelegate {
    
   init(color : String) {
        super.init()
        
        addCircle(color: color)
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addCircle(color : String) {
        let circlePath = UIBezierPath(ovalIn: CGRect(x: -15, y: -15, width: 30, height: 30))
        
        path = circlePath.cgPath
        strokeColor = UIColor.init(hexString: color).cgColor
        fillColor = UIColor.clear.cgColor
        lineWidth = 1
        if UIDevice.current.userInterfaceIdiom == .pad {
            lineWidth = 2
        }
    }
    
    func animate() {
        let scaleAnim = CABasicAnimation(keyPath: "transform.scale")
        scaleAnim.fromValue = 1
        scaleAnim.toValue = 1.25
        scaleAnim.duration = 0.1
        
        scaleAnim.delegate = self
        
        add(scaleAnim, forKey: "scaleCircle")
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            opacity = 0
            CATransaction.commit()
        }
    }
    
}

