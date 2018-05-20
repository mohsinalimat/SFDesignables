//
//  SFTextFieldViewController.swift
//  sfdesignables
//
//  Created by sudofluff on 5/20/18.
//  Copyright © 2018 sudofluff. All rights reserved.
//

import UIKit

class SFTextFieldViewController: UIViewController, SFTextFieldDelegate {
    
    @IBOutlet weak var textField: SFTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.sfTextFieldDelegate = self
    }
    
    func sfTextField(_ sfTextField: SFTextField, didTap rightButton: UIButton) {
        print(123)
    }
    
}
