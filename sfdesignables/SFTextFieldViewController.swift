//
//  SFTextFieldViewController.swift
//  sfdesignables
//
//  Created by sudofluff on 5/20/18.
//  Copyright © 2018 sudofluff. All rights reserved.
//

import UIKit

class SFTextFieldViewController: UIViewController {
    
    @IBOutlet weak var textField: SFTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.sfDelegate = self
    }
    
}

extension SFTextFieldViewController: SFTextFieldDelegate {
    
    func sfTextField(_ sfTextField: SFTextField, didTap rightButton: UIButton) {
        sfTextField.jitter(repeatCount: 5, duration: 1)
    }
    
}
