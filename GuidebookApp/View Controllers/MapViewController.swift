//
//  MapViewController.swift
//  GuidebookApp
//
//  Created by Lucas Dahl on 11/11/18.
//  Copyright © 2018 Lucas Dahl. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    // Properties
    var place:Place?
    
    // Outlets
    @IBOutlet weak var mapView: MKMapView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // Check for a place and plot the pin
        if place != nil {
            plotPin(place!)
        }
        
    }
    
    func plotPin(_ p:Place) {
        
        let pin = MKPointAnnotation()
        
        // Get the long and lat from the plcae
        pin.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(p.lat), longitude: CLLocationDegrees(p.long))
        
        // Set the title
        pin.title = p.name!
        
        // Add the pin to the map view
        mapView.addAnnotation(pin)
        
        // Center the map aroud the pin
        mapView.showAnnotations([pin], animated: true)
        
    }

    @IBAction func backTapped(_ sender: UIButton) {
        
        // Dismiss the map view controller
        dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func locateTapped(_ sender: UIButton) {
        
        
        
    }
    
    @IBAction func routeTapped(_ sender: UIButton) {
        
        // Male sure there arent nil values
        guard place != nil && place!.address != nil else {
            return
        }
        
        // Replace all spaces with +
        let newAddress = place!.address!.replacingOccurrences(of: " ", with: "+")
        
        let url = URL(string: "http://maps.apple.com/?address=" + newAddress)
        
        if url == url {
            
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
            
        }
        
    }
    
}
