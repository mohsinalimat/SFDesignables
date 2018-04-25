//
//  SFButton.swift
//  ibdesignable
//
//  Created by sudofluff on 4/2/18.
//  Copyright © 2018 sudofluff. All rights reserved.
//

import UIKit

@IBDesignable open class SFButton: UIButton {
    
    // UIButton apis
    
    @IBInspectable open var cornerRaduis: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRaduis
            layer.masksToBounds = cornerRaduis > 0
        }
    }
    
    @IBInspectable open var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable open var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    override open var isSelected: Bool {
        didSet {
            self.setSelected(isSelected, animated: true)
        }
    }
    
    override open var isHighlighted: Bool {
        didSet {
            self.setHighlighted(isHighlighted, animated: true)
        }
    }
    
    open func setSelected(_ selected: Bool, animated: Bool) {
        self.alpha = selected ? 0.8 : 1.0
    }
    
    open func setHighlighted(_ highlighted: Bool, animated: Bool) {
        self.alpha = highlighted ? 0.7 : 1.0
    }
    
    // gradient colors
    
    @IBInspectable open var startColor: UIColor = UIColor.lightGray {
        didSet {
            gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        }
    }
    
    @IBInspectable open var endColor: UIColor = UIColor.darkGray {
        didSet {
            gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        }
    }
    
    @IBInspectable open var startPoint: CGPoint = CGPoint(x: 0.5, y: 0.0) {
        didSet {
            gradientLayer.startPoint = startPoint
        }
    }
    
    @IBInspectable open var endPoint: CGPoint = CGPoint(x: 0.5, y: 1.0) {
        didSet {
            gradientLayer.endPoint = endPoint
        }
    }
    
    open var gradientLayer = CAGradientLayer()
    
    private func setupGradientLayer() {
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    // shadow
    
    @IBInspectable open var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    @IBInspectable open var shadowOpacity: Float = 0 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }
    
    @IBInspectable open var shadowRadius: CGFloat = 0 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable open var shadowOffset: CGSize = CGSize.zero {
        didSet {
            layer.shadowOffset = shadowOffset
        }
    }
    
    private func setupShadow() {
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRaduis).cgPath
        layer.masksToBounds = shadowRadius >= 0 ? false : true
    }
    
    // override
    
    override open func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupGradientLayer()
        setupShadow()
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        setupGradientLayer()
        setupShadow()
    }
    
}
