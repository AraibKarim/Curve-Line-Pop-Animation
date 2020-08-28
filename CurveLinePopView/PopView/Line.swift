//
//  Line.swift
//  CurveLinePopView
//
//  Created by Araib on 10/11/2019.
//  Copyright © 2019 Woody Apps. All rights reserved.
//

import UIKit

class Line: CAShapeLayer {
    
     init(color : String) {
        super.init()
        
        createLine(color : color)
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createLine(color : String) {
        let bezPath = UIBezierPath()
        bezPath.move(to: CGPoint(x: 15, y: 0))
        let distance = CGFloat(arc4random_uniform(45 - 25) + 25)
        bezPath.addLine(to: CGPoint(x: distance, y: 0))
        
        lineWidth = 4.5
        if UIDevice.current.userInterfaceIdiom == .pad {
           lineWidth = 8
        }
        lineCap = CAShapeLayerLineCap.round
        strokeColor = UIColor.init(hexString: color).cgColor
        path = bezPath.cgPath
    }
    
    func animate() {
        let duration: CFTimeInterval = 1.0
        
        let end = CABasicAnimation(keyPath: "strokeEnd")
        end.fromValue = 0
        end.toValue = 1.0175
        end.beginTime = 0
        end.duration = duration * 0.75
        end.timingFunction = CAMediaTimingFunction(controlPoints: 0.2, 0.88, 0.09, 0.99)
        end.fillMode = CAMediaTimingFillMode.forwards
        
        let begin = CABasicAnimation(keyPath: "strokeStart")
        begin.fromValue = 0
        begin.toValue = 1.0175
        begin.beginTime = duration * 0.15
        begin.duration = duration * 0.85
        begin.timingFunction = CAMediaTimingFunction(controlPoints: 0.2, 0.88, 0.09, 0.99)
        begin.fillMode = CAMediaTimingFillMode.backwards
        
        let group = CAAnimationGroup()
        group.animations = [end, begin]
        group.duration = duration
        
        strokeEnd = 1
        strokeStart = 1
        
        add(group, forKey: "move")
    }
    
}
