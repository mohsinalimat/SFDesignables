//
//  ViewController.swift
//  sfdesignables
//
//  Created by sudofluff on 4/26/18.
//  Copyright © 2018 sudofluff. All rights reserved.
//

import UIKit

class SFViewViewController: UIViewController {

    private let shapeLayer = CAShapeLayer()
    private let strokeAnimation = CABasicAnimation(keyPath: "strokeEnd")
    private var duration: CFTimeInterval = 2
    
    func stroke(_ toValue: CGFloat) {
        strokeAnimation.toValue = toValue
    }
    
    func set(_ animationDuration: CFTimeInterval) {
        self.duration = animationDuration
    }
    
    private func setupLayer(block: () -> Void) {
        let center = view.center
        let π = CGFloat.pi
        let radius: CGFloat = 100
        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: 2*π, clockwise: true)
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.strokeEnd = 0
        view.layer.addSublayer(shapeLayer)
        block()
    }
    
    private func setupAnimation() {
        self.strokeAnimation.fillMode = kCAFillModeForwards
        self.strokeAnimation.isRemovedOnCompletion = false
        self.shapeLayer.add(strokeAnimation, forKey: "strokeAnimation")
    }

}
