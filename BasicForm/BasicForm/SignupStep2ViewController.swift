//
//  SignupStep2ViewController.swift
//  BasicForm
//
//  Created by Hussein Nagri on 2019-09-30.
//  Copyright © 2019 Hussein Nagri. All rights reserved.
//

import UIKit

class SignupStep2ViewController: UIViewController {
    @IBOutlet var emailFieldLabel: UILabel!
    
    @IBOutlet var emailField: UITextField!
    
    @IBOutlet var nextButton: UIButton!
    var user : User?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.emailField.text = "Hi \(user!.name!)! What's your email."
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
