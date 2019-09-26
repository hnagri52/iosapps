//
//  ViewController.swift
//  Capital Cities
//
//  Created by Hussein Nagri on 2019-09-26.
//  Copyright © 2019 Hussein Nagri. All rights reserved.
//

import UIKit
import MapKit


class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Map Type", style: .plain, target: self, action: #selector(chooseMapType))

        let london = Capital(title: "London", coordinate: CLLocationCoordinate2DMake(51.507222, -0.1275), info: "Home to the 2012 summer olympics")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2DMake(59.95, 10.75), info: "Founded a thousand years ago")
        
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2DMake(48.8567, 2.3508), info: "City of light")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2DMake(41.9, 12.5), info: "whole country inside!")
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2DMake(38.895111, -77.036667), info: "named after george")
        
        mapView.addAnnotations([london, oslo, paris, rome, washington])
        
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else { return nil }
        let identifier = "Capital"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            
            annotationView?.canShowCallout = true
            annotationView?.pinTintColor = .orange
            
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        }else{
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital  = view.annotation as? Capital else {return}
        
        let placeName = capital.title
        let placeInfo = capital.info
        
        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "ok", style: .default))
        present(ac, animated: true)
        
    }
    @objc func chooseMapType() {
        let mapTypeAC = UIAlertController(title: "Map Type", message: "Choose your preferred map type", preferredStyle: .alert)
        mapTypeAC.addAction(UIAlertAction(title: "Standard", style: .default, handler: { [weak self] _ in
            self?.mapView.mapType = .standard
        }))
        mapTypeAC.addAction(UIAlertAction(title: "Hybrid", style: .default, handler: { [weak self] _ in
            self?.mapView.mapType = .hybrid
        }))
        mapTypeAC.addAction(UIAlertAction(title: "Satellite", style: .default, handler: { [weak self] _ in
            self?.mapView.mapType = .satellite
        }))
        
        present(mapTypeAC, animated: true)
    }
    
}

