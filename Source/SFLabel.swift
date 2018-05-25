//
//  SFLabel.swift
//  ibdesignable
//
//  Created by sudofluff on 4/25/18.
//  Copyright © 2018 sudofluff. All rights reserved.
//

import UIKit

@IBDesignable open class SFLabel: UILabel {
    
    // MARK: - Border & Corners

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
    
    // MARK: - Gradient layer

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
        gradientLayer.cornerRadius = cornerRaduis
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.startPoint = startPoint
        gradientLayer.frame = self.bounds
        gradientLayer.endPoint = endPoint
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    // MARK: - Shadows

    @IBInspectable open var viewShadowColor: UIColor? {
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

    @IBInspectable open var viewShadowOffset: CGSize = CGSize.zero {
        didSet {
            layer.shadowOffset = viewShadowOffset
        }
    }

    private func setupShadow() {
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRaduis).cgPath
        layer.masksToBounds = shadowRadius >= 0 ? false : true
    }
    
    // MARK: - Text layer
    
    let textLayer = CATextLayer()
    
    @IBInspectable open var textHeight: CGFloat = 0
    
    private func setupTextLayer() {
        let width = bounds.size.width
        let height = bounds.size.height
        textLayer.foregroundColor = textColor.cgColor
        textLayer.string = text
        textLayer.fontSize = font.pointSize
        textLayer.font = font
        textLayer.alignmentMode = kCAAlignmentCenter
        textLayer.frame = CGRect(x: 0, y: textHeight, width: width, height: height)
        layer.insertSublayer(textLayer, at: 1)
    }

    // MARK: - Override

    override open func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupGradientLayer()
        setupTextLayer()
        setupShadow()
    }

    override open func layoutSubviews() {
        super.layoutSubviews()
        setupGradientLayer()
        setupTextLayer()
        setupShadow()
    }
}

























