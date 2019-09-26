//
//  ViewController.swift
//  animations
//
//  Created by Hussein Nagri on 2019-09-25.
//  Copyright © 2019 Hussein Nagri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var imageView : UIImageView!
    var currentAnimaation = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imageView = UIImageView(image: UIImage(named: "penguin"))
        imageView.center = CGPoint(x: 204, y: 384)
        view.addSubview(imageView)
    }
    
    
    
    @IBAction func tapped(_ sender: UIButton) {
        sender.isHidden = true
        
        UIView.animate(withDuration: 1, delay: 0 , options: [], animations: {
            switch self.currentAnimaation{
            case 0:
                self.imageView.transform = CGAffineTransform(scaleX: 2, y: 2)
                break
            default:
                break
            }
        }) { finished in
            sender.isHidden = false
        }
        currentAnimaation += 1
        
        if currentAnimaation > 7{
            currentAnimaation  = 0
        }
    }
    

}

