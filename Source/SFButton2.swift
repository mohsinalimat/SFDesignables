//
//  SFButton2.swift
//  sfdesignables
//
//  Created by sudofluff on 5/26/18.
//  Copyright © 2018 sudofluff. All rights reserved.
//

import UIKit

@IBDesignable open class SFButton2: UIControl {
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 40, weight: UIFont.Weight.heavy)
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.imageView, self.label])
        stackView.axis = .vertical
        stackView.isUserInteractionEnabled = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initPhase2()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initPhase2()
    }
    
    private func initPhase2() {
        label.backgroundColor = tintColor
        layer.borderColor = tintColor.cgColor
        layer.cornerRadius = cornerRaduis
        clipsToBounds = true
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: layoutMarginsGuide.rightAnchor),
            label.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3)
            ])
    }
    
    // MARK: - Public Apis
    
    @IBInspectable open var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        }
    }
    
    @IBInspectable open var text: String? {
        get {
            return label.text
        }
        set {
            label.text = newValue
        }
    }
    
    @IBInspectable open var fontSize: CGFloat {
        get {
            return label.font.pointSize
        }
        set {
            label.font = UIFont.systemFont(ofSize: newValue)
        }
    }
    
    @IBInspectable open var cornerRaduis: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    open override func tintColorDidChange() {
        label.backgroundColor = tintColor
        layer.borderColor = tintColor.cgColor
    }
    
    @IBInspectable open var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layoutMargins = UIEdgeInsets(top: newValue, left: newValue, bottom: newValue / 2, right: newValue)
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable open var imagePadding: CGFloat {
        get {
            return image?.alignmentRectInsets.top ?? 0
        }
        set {
            let insets = UIEdgeInsets(top: -newValue, left: -newValue, bottom: -newValue, right: -newValue)
            image = image?.withAlignmentRectInsets(insets)
        }
    }
    
    // MARK: - Impact
    
    @IBInspectable open var isFeedbackEnabled: Bool = false
    let feedbackGenerator = UIImpactFeedbackGenerator(style: UIImpactFeedbackStyle.heavy)
    
    private func generateImpact() {
        self.feedbackGenerator.impactOccurred()
    }
    
    // MARK: - Touch events
    
    @IBInspectable open var backgroundColorOnTouchDown: UIColor = UIColor(red: 154 / 255, green: 154 / 255, blue: 154 / 255, alpha: 1)
    @IBInspectable open var backgroundColorOnTouchRelease: UIColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1) {
        didSet {
            backgroundColor = backgroundColorOnTouchRelease
        }
    }
    
    private func animate(isPressed: Bool) {
        let (duration, backgroundColor, labelIsHidden) = (isPressed ? (duration: 0.05, backgroundColor: backgroundColorOnTouchDown, labelIsHidden: true) : (duration: 0.1, backgroundColor: backgroundColorOnTouchRelease, labelIsHidden: false))
        UIView.animate(withDuration: duration) {
            self.backgroundColor = backgroundColor
            self.label.isHidden = labelIsHidden
            self.label.alpha = labelIsHidden ? 0.5 : 1.0
        }
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.animate(isPressed: true)
        if isFeedbackEnabled {
            generateImpact()
        }
    }
    
    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        self.animate(isPressed: false)
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.animate(isPressed: false)
    }
    
}
