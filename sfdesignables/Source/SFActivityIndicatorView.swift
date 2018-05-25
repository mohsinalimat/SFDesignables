//
//  SFActivityIndicatorView.swift
//  sfdesignables
//
//  Created by sudofluff on 5/24/18.
//  Copyright © 2018 sudofluff. All rights reserved.
//

import UIKit

protocol SFActivityIndicatorViewDataSource: NSObjectProtocol {
    
}

protocol SFActivityIndicatorViewDelegate: NSObjectProtocol {
    
}

@IBDesignable public class SFActivityIndicatorView: UIControl {
    
    weak var dataSource: SFActivityIndicatorViewDataSource?
    weak var delegate: SFActivityIndicatorViewDelegate?
    private let shapLayer = CAShapeLayer()
    private let strokeAnimation = CABasicAnimation(keyPath: "strokeEnd")
    private var strokeDuration: CFTimeInterval = 0
    
    func setupLayer() {
        let circularPath = UIBezierPath(arcCenter: self.center, radius: self.frame.size.height / 2, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        self.shapLayer.path = circularPath.cgPath
        self.shapLayer.strokeColor = UIColor.red.cgColor
        self.shapLayer.lineWidth = 10
        self.shapLayer.strokeEnd = 0
        self.layer.addSublayer(shapLayer)
    }
    
    func setDuration(_ duration: CFTimeInterval) {
        self.strokeDuration = duration
    }
    
    func stroke(toValue: Float) {
        self.strokeAnimation.toValue = toValue
        self.strokeAnimation.duration = self.strokeDuration
    }
    
    // MARK: - Override
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupLayer()
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        setupLayer()
    }
    
}
