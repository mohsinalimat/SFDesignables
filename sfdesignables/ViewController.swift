//
//  ViewController.swift
//  sfdesignables
//
//  Created by sudofluff on 4/26/18.
//  Copyright © 2018 sudofluff. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    @IBOutlet weak var usernameTextField: SFTextField!
    
    func simulateBackgroundTask() {
        guard let url = URL(string: "https://api.letsbuildthatapp.com/jsondecodable/courses") else {
            print("failed to convert string to url")
            return
        }
        URLSession.shared.dataTask(with: url) { [unowned self] (data, response, error) in
            if let err = error {
                print(err.localizedDescription)
            }
            DispatchQueue.main.async {
                print("stops animating")
                self.usernameTextField.stopAnimating()
            }
        }.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.sfDelegate = self
    }

}

extension ViewController: SFTextFieldDelegate {
    
    func sfTextField(_ sfTextField: SFTextField, didTap rightButton: UIButton) {
        print("starts animating")
        sfTextField.startAnimating()
        // simulate some long running background task
        self.simulateBackgroundTask()
    }
}
