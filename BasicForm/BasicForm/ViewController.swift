//
//  ViewController.swift
//  BasicForm
//
//  Created by Hussein Nagri on 2019-09-30.
//  Copyright © 2019 Hussein Nagri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var nameFieldLabel: UILabel!
    
    @IBOutlet var nameField: UITextField!
    
    @IBOutlet var nextButton: UIButton!
    var user : User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.user = User()
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.user?.name = nameField.text
        let step2VC = segue.destination as! SignupStep2ViewController
        
        step2VC.user = self.user
        
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if let name = nameField.text, name.count > 3{
            return true
        }
        
        return false
    }

    
}

