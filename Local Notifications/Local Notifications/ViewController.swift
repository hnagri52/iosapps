//
//  ViewController.swift
//  Local Notifications
//
//  Created by Hussein Nagri on 2019-09-27.
//  Copyright © 2019 Hussein Nagri. All rights reserved.
//
import UserNotifications
import UIKit


class ViewController: UIViewController, UNUserNotificationCenterDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Register", style: .plain, target: self, action: #selector(registerLocal))
         navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Schedule", style: .plain, target: self, action: #selector(scheduleLocal))
    }

    @objc func registerLocal(){
        let center  = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]){
            granted, error in
            
            if granted{
                print("yay")
            }else{
                print("no")
            }
        }
        
    }
    @objc func scheduleLocal(){
        registerCategories()
        let center = UNUserNotificationCenter.current()
        center.removeAllDeliveredNotifications()
        
        let content = UNMutableNotificationContent()
        content.title = "Let's wake up call!"
        content.body = "the early bird catches the worm, but the second mouse gets the cheese!"
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = .default
        
        
        var dateComponents = DateComponents()
        dateComponents.hour  = 10
        dateComponents.minute = 30
        
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        center.add(request)
        
        
    }
    
    func registerCategories(){
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        let show = UNNotificationAction(identifier: "show", title: "Tell me more", options: .foreground)
        let category = UNNotificationCategory(identifier: "alarm", actions: [show], intentIdentifiers: [], options: [])
        
        //this connects to the "alarm" category we made at the top
        center.setNotificationCategories([category])
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        if let customData = userInfo["customData"] as? String {
            print("custom data received! \(customData)")
            
            switch response.actionIdentifier {
            case UNNotificationDefaultActionIdentifier:
                print("Default identifier")
                break
            case "show":
                print("Show more information")
                break
            default:
                break
            }
        }
        
        completionHandler()
    }
}

