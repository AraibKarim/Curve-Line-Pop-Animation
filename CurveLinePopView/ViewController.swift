//
//  ViewController.swift
//  CurveLinePopView
//
//  Created by Araib on 10/11/2019.
//  Copyright © 2019 Woody Apps. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CAAnimationDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        // Do any additional setup after loading the view.
        
        createCurvedLine(from: CGPoint.init(x: self.view.frame.midX, y: 600), to: CGPoint.init(x: self.view.frame.midX, y: 200), withDuration: 1.25)
    }
    
    func createCurvedLine (from : CGPoint, to : CGPoint, withDuration: CFTimeInterval){
        let path = UIBezierPath.init()
        path.move(to: from)
        path.addCurve(to: to, controlPoint1: CGPoint.init(x: from.x-100, y: from.y-40), controlPoint2: CGPoint.init(x: to.x-50, y: to.y+20))
        let line = CAShapeLayer()
        line.lineCap = CAShapeLayerLineCap.round
        line.path = path.cgPath
        line.strokeColor = UIColor.init(hexString: "#ffe5c5").cgColor
        line.fillColor = UIColor.clear.cgColor
        line.lineWidth = 7.0
        if UIDevice.current.userInterfaceIdiom == .pad {
            line.lineWidth = 14.0
        }
        self.view!.layer.addSublayer(line)
        animateLine(line: line,to : to, withDuration: withDuration)
    }
    func animateLine(line: CAShapeLayer, to : CGPoint, withDuration : CFTimeInterval) {
        let duration: CFTimeInterval = withDuration
        
        let end = CABasicAnimation(keyPath: "strokeEnd")
        end.fromValue = 0
        end.toValue = 1.0175
        end.beginTime = 0
        end.duration = duration * 0.75
        end.timingFunction = CAMediaTimingFunction(controlPoints: 0.44, 0.12, 0.69, 0.12)
        end.fillMode = CAMediaTimingFillMode.forwards
        
        let begin = CABasicAnimation(keyPath: "strokeStart")
        begin.fromValue = 0
        begin.toValue = 1.0175
        begin.beginTime = duration * 0.15
        begin.duration = duration * 0.85
        begin.timingFunction = CAMediaTimingFunction(controlPoints: 0.44, 0.12, 0.69, 0.12)
        begin.fillMode = CAMediaTimingFillMode.backwards
        
        let group = CAAnimationGroup()
        group.delegate = self
        group.setValue("curvelineEnd", forKey: "animationID")
        group.setValue(to, forKey: "to")
        group.animations = [end, begin]
        group.duration = duration
        
        line.strokeEnd = 4
        line.strokeStart = 4
        // custom property set
        
        line.add(group, forKey: "move")
        
    }
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        if let animationID = anim.value(forKey: "animationID"), animationID != nil {
            if animationID as! NSString == "curvelineEnd" {
                // execute code
                if let toPosition = anim.value(forKey: "to"), toPosition != nil {
                    let pop = PopView(colorType: .white)
                    pop.center = toPosition as! CGPoint
                    self.view!.addSubview(pop)
                    
                }
            }
        }
    }
    
    
    
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
}
