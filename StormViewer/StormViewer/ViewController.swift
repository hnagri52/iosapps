//
//  ViewController.swift
//  StormViewer
//
//  Created by Hussein Nagri on 2019-09-16.
//  Copyright © 2019 Hussein Nagri. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var pictures = [String]()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareInfo))
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true

        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items  = try! fm.contentsOfDirectory(atPath: path)
    
        for item in items{
            if item.hasPrefix("nssl"){
                pictures.append(item)
            }
            pictures.sort()
        }
        print(pictures)
    }
    @objc func shareInfo(){
        let vc = UIActivityViewController(activityItems: ["Make sure you get this app!"], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController{
            vc.selectedImage = pictures[indexPath.row]
            vc.selectedPictureNumber = indexPath.row + 1
            vc.totalPictures = pictures.count
            navigationController?.pushViewController(vc,animated: true)
        }
    }
    
    
}

