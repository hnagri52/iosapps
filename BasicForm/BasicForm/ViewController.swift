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
        navigationItem.title = "Work Order Inspections"
//        navigationController?.navigationBar.barTintColor = UIColor(red: 0.67, green: 0/255, blue: 0, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        

         self.navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .done, target: nil, action: nil)
    }
    
    @objc func homeButtonTapped(){
        self.performSegue(withIdentifier: "ViewController", sender: self)
        
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

