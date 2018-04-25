//
//  SFTextField.swift
//  ibdesignable
//
//  Created by sudofluff on 3/22/18.
//  Copyright © 2018 sudofluff. All rights reserved.
//

import UIKit

@objc protocol SDTextFieldRightButtonDelegate: NSObjectProtocol {
    @objc optional func didTapButton(_ sender: UIButton)
}

@IBDesignable class SFTextField: UITextField {
    
    // Animations & Physics
    
    func jitter(repeatCount: Float, duration: TimeInterval) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = duration
        animation.repeatCount = repeatCount
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 5.0, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 5.0, y: self.center.y))
        layer.add(animation, forKey: "position")
    }
    
    // Generic UITextField & properties
    
    weak var rightButtonDelegate: SDTextFieldRightButtonDelegate?
    
    @IBInspectable var cornerRaduis: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRaduis
            layer.masksToBounds = cornerRaduis > 0
        }
    }
    
    @IBInspectable var borderWith: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWith
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    /// remark: Placeholder tint color may not be able to render correctly in storyboard.
    @IBInspectable var placeholderTintColor: UIColor = UIColor.lightGray {
        didSet {
            attributedPlaceholder = NSAttributedString(string: placeholder != nil ? placeholder! : "", attributes: [NSAttributedStringKey.foregroundColor: placeholderTintColor])
        }
    }
    
    // LeftView + UIImageView
    
    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateLeftView()
        }
    }
    
    @IBInspectable var leftImageViewSize: CGFloat = 20 {
        didSet {
            updateLeftView()
        }
    }
    
    @IBInspectable var leftImageTintColor: UIColor? = UIColor.white {
        didSet {
            updateLeftView()
        }
    }
    
    @IBInspectable var leftImagePadding: CGFloat = 0 {
        didSet {
            updateLeftView()
        }
    }
    
    private func updateLeftView() {
        if let image = leftImage {
            leftViewMode = .always
            let imageView = UIImageView(frame: CGRect(x: leftImagePadding, y: 0, width: leftImageViewSize, height: leftImageViewSize))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            imageView.tintColor = leftImageTintColor
            let containerView = UIView(frame: CGRect(x: 0, y: 0, width: leftImageViewSize + leftImagePadding + 8, height: leftImageViewSize))
            containerView.addSubview(imageView)
            leftView = containerView
        } else {
            leftViewMode = .never
        }
    }
    
    // RightView + UIButton
    
    @IBInspectable var rightButtonImage: UIImage? {
        didSet {
            updateRightView()
        }
    }
    
    @IBInspectable var rightButtonPadding: CGFloat = 0 {
        didSet {
            updateRightView()
        }
    }
    
    @IBInspectable var rightButtonSize: CGFloat = 20 {
        didSet {
            updateRightView()
        }
    }
    
    @IBInspectable var rightButtonTintColor: UIColor? = UIColor.white {
        didSet {
            updateRightView()
        }
    }
    
    private var rightButton: UIButton?
    
    private func updateRightView() {
        if let image = rightButtonImage {
            rightViewMode = .always
            rightButton = UIButton(type: UIButtonType.system)
            rightButton!.setImage(image, for: UIControlState.normal)
            rightButton!.frame = CGRect(x: 0, y: 0, width: rightButtonSize, height: rightButtonSize)
            rightButton!.contentMode = .scaleAspectFit
            rightButton!.tintColor = rightButtonTintColor
            rightButton!.addTarget(self, action: #selector(rightButtonTapped), for: UIControlEvents.touchUpInside)
            let containerView = UIView(frame: CGRect(x: 0, y: 0, width: rightButtonSize + rightButtonPadding, height: rightButtonSize))
            containerView.addSubview(rightButton!)
            containerView.addSubview(activityIndicatorView)
            rightView = containerView
        } else {
            rightViewMode = .never
        }
    }
    
    @objc func rightButtonTapped() {
        if let button = rightButton, let rightButtonDelegate = rightButtonDelegate {
            rightButtonDelegate.didTapButton!(button)
        }
    }
    
    // GradientLayer
    
    @IBInspectable var startColor: UIColor = UIColor.lightGray {
        didSet {
            gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        }
    }
    
    @IBInspectable var endColor: UIColor = UIColor.darkGray {
        didSet {
            gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        }
    }
    
    @IBInspectable var startPoint: CGPoint = CGPoint(x: 0.5, y: 0.0) {
        didSet {
            gradientLayer.startPoint = startPoint
        }
    }
    
    @IBInspectable var endPoint: CGPoint = CGPoint(x: 0.5, y: 1.0) {
        didSet {
            gradientLayer.endPoint = endPoint
        }
    }
    
    var gradientLayer = CAGradientLayer()
    
    func setupGradientLayer() {
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    // shadow
    
    @IBInspectable var shadowColor: UIColor? {
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
    
    @IBInspectable var shadowOpacity: Float = 0 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 0 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable var shadowOffset: CGSize = CGSize.zero {
        didSet {
            layer.shadowOffset = shadowOffset
        }
    }
    
    private func setupShadow() {
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRaduis).cgPath
        layer.masksToBounds = shadowRadius >= 0 ? false : true
    }
    
    // activity indicator
    
    @IBInspectable var activityIndicatorColor: UIColor = UIColor.white {
        didSet {
            activityIndicatorView.tintColor = activityIndicatorColor
        }
    }
    
    private var activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        view.hidesWhenStopped = true
        return view
    }()
    
    func startAnimating() {
        activityIndicatorView.startAnimating()
        rightButton?.isHidden = true
    }
    
    func stopAnimating() {
        activityIndicatorView.stopAnimating()
        rightButton?.isHidden = false
    }
    
    var isAnimating: Bool {
        return activityIndicatorView.isAnimating
    }
    
    // Lifecycle
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupGradientLayer()
        setupShadow()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupGradientLayer()
        setupShadow()
    }
    
}
