//
//  PopView.swift
//  CurveLinePopView
//
//  Created by Araib on 10/11/2019.
//  Copyright © 2019 Woody Apps. All rights reserved.
//

import UIKit
enum PopViewColor {
    case white
    case pink
    case yellow
    case red
    case brown
}
class PopView: UIView {
    
    init(colorType : PopViewColor) {
        if UIDevice.current.userInterfaceIdiom == .pad {
            super.init(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
            
        }else {
            super.init(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            
        }
        
        isUserInteractionEnabled = false
        let color =  self.getColor(type: colorType)
        let bubble = Bubble(color: color)
        bubble.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
        layer.addSublayer(bubble)
        bubble.animate()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.07, execute: {
            for number in 1...6 {
                let line = Line(color : color)
                line.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
                line.transform = CATransform3DMakeRotation(CGFloat.pi * 2 / CGFloat(6) * CGFloat(number), 0, 0, 1)
                self.layer.addSublayer(line)
                line.animate()
            }
        })
        
        let minOffset: UInt32 = 0
        let maxOffset: UInt32 = 200
        let rotation = CGFloat(arc4random_uniform(maxOffset - minOffset) + minOffset) / CGFloat(100)
        transform = CGAffineTransform(rotationAngle: rotation)
        
        //remove view after 1 second
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.removeFromSuperview()
        })
    }
   
    func getColor (type : PopViewColor) -> String{
        if(type == .white){
            return "#ffffff"
        }else if (type == .yellow){
             return "#fff000"
        }else if (type == .pink){
             return "#dd1bf2"
        }else if (type == .red){
             return "#f7817e"
        }else if (type == .brown){
            return  "#8a5035"
        }
        return "#ffffff"
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
