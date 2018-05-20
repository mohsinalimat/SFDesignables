//
//  SFTextField.swift
//  ibdesignable
//
//  Created by sudofluff on 3/22/18.
//  Copyright © 2018 sudofluff. All rights reserved.
//

import UIKit

@objc public protocol SFTextFieldDelegate: NSObjectProtocol {
    @objc optional func sfTextField(_ sfTextField: SFTextField, didTap rightButton: UIButton)
}

@IBDesignable open class SFTextField: UITextField {
    
    // MARK: - Actions
    
    open func jitter(repeatCount: Float, duration: TimeInterval) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = duration
        animation.repeatCount = repeatCount
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 5.0, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 5.0, y: self.center.y))
        layer.add(animation, forKey: "position")
    }
    
    // MARK: - Border & Corners
    
    @IBInspectable open var cornerRaduis: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRaduis
            layer.masksToBounds = cornerRaduis > 0
        }
    }
    
    @IBInspectable open var borderWith: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWith
        }
    }
    
    @IBInspectable open var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    /// remark: Placeholder tint color may not be able to render correctly in storyboard.
    @IBInspectable open var placeholderTintColor: UIColor = UIColor.lightGray {
        didSet {
            attributedPlaceholder = NSAttributedString(string: placeholder != nil ? placeholder! : "", attributes: [NSAttributedStringKey.foregroundColor: placeholderTintColor])
        }
    }
    
    // MARK: - LeftView + UIImageView
    
    @IBInspectable open var leftImage: UIImage? {
        didSet {
            updateLeftView()
        }
    }
    
    @IBInspectable open var leftImageViewSize: CGFloat = 20 {
        didSet {
            updateLeftView()
        }
    }
    
    @IBInspectable open var leftImageTintColor: UIColor? = UIColor.white {
        didSet {
            updateLeftView()
        }
    }
    
    @IBInspectable open var leftImagePadding: CGFloat = 0 {
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
    
    // MARK: - RightView + UIButton
    
    open weak var sfTextFieldDelegate: SFTextFieldDelegate?
    
    @IBInspectable open var rightButtonImage: UIImage? {
        didSet {
            updateRightView()
        }
    }
    
    @IBInspectable open var rightButtonPadding: CGFloat = 0 {
        didSet {
            updateRightView()
        }
    }
    
    @IBInspectable open var rightButtonSize: CGFloat = 20 {
        didSet {
            updateRightView()
        }
    }
    
    @IBInspectable open var rightButtonTintColor: UIColor? = UIColor.white {
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
    
    @objc private func rightButtonTapped() {
        if let button = rightButton, let rightButtonDelegate = sfTextFieldDelegate {
            rightButtonDelegate.sfTextField?(self, didTap: button)
        }
    }
    
    // MARK: - ActivityIndicator
    
    @IBInspectable open var activityIndicatorColor: UIColor = UIColor.white {
        didSet {
            activityIndicatorView.tintColor = activityIndicatorColor
        }
    }
    
    private var activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        view.hidesWhenStopped = true
        return view
    }()
    
    open func startAnimating() {
        if !isAnimating {
            activityIndicatorView.startAnimating()
            rightButton?.isHidden = true
        }
    }
    
    open func stopAnimating() {
        if isAnimating {
            activityIndicatorView.stopAnimating()
            rightButton?.isHidden = false
        }
    }
    
    open var isAnimating: Bool {
        return activityIndicatorView.isAnimating
    }
    
    // MARK: - Shadows
    
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
    
    // MARK: - Override
    
    override open func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupShadow()
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        setupShadow()
    }
    
}
