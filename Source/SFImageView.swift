//
//  SFImageView.swift
//  ibdesignable
//
//  Created by sudofluff on 4/25/18.
//  Copyright © 2018 sudofluff. All rights reserved.
//

import UIKit

@IBDesignable open class SFImageView: UIImageView {
    
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
    
    // MARK: - Parallax
    
    @IBInspectable open var parallax: Float = 0 {
        didSet {
            let xMotion = UIInterpolatingMotionEffect(keyPath: "center.x", type: UIInterpolatingMotionEffectType.tiltAlongHorizontalAxis)
            xMotion.minimumRelativeValue = parallax
            xMotion.maximumRelativeValue = -parallax
            let yMotion = UIInterpolatingMotionEffect(keyPath: "center.y", type: UIInterpolatingMotionEffectType.tiltAlongVerticalAxis)
            yMotion.minimumRelativeValue = parallax
            yMotion.maximumRelativeValue = -parallax
            let group = UIMotionEffectGroup()
            group.motionEffects = [xMotion, yMotion]
            if parallax != 0 {
                addMotionEffect(group)
            } else {
                if self.motionEffects.count > 0 {
                    removeMotionEffect(group)
                }
            }
        }
    }
    
    // MARK: - Actions
    
    open func flash(delay: TimeInterval, duration: TimeInterval) {
        UIView.animate(withDuration: duration, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        }) { (completed: Bool) in
            UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.alpha = 0.0
            }, completion: nil)
        }
    }
    
    open func showImageWithAnimation(options: UIViewAnimationOptions, duration: TimeInterval, image: UIImage) {
        UIView.transition(with: self, duration: duration, options: options, animations: {
            self.image = image
        }, completion: nil)
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
    
    // MARK: - Override
    
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
