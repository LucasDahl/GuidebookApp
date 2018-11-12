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
    var locationManger:CLLocationManager?
    var lastKnownLocation:CLLocation?
    
    // Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Show the blue dot for the user if the location is known
        mapView.showsUserLocation = true
        
        // Create and configure the location manager
        locationManger = CLLocationManager()
        locationManger?.delegate = self
        
        
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
    
    func showGeoLocationError() {
        
        // Create the alert
        let alert = UIAlertController(title: "Geolocation failed", message: "Location services are turned off, or this app doesnt have permission to locate. Check your settings to continue.", preferredStyle: .alert)
        
        // Create the alert actions
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (alert) in
            
            // Get a url to the settings of the device
            let url = URL(string: UIApplication.openSettingsURLString)
            
            if let url = url {
                
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                
            }
            
        }
        
        // Add the settings action to the alert action
        alert.addAction(settingsAction)
        
        // Create the cancel button and add it to the alert action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        // Show the alert
        present(alert, animated: true, completion: nil)
        
    }

    @IBAction func backTapped(_ sender: UIButton) {
        
        // Dismiss the map view controller
        dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func locateTapped(_ sender: UIButton) {
        
        if CLLocationManager.locationServicesEnabled() {
            
            // Check the authorization status
            let status = CLLocationManager.authorizationStatus()
            
            if status == .denied || status == .restricted {
                
                // Show error popup
                showGeoLocationError()
                
            } else if status == .authorizedWhenInUse || status == .authorizedAlways {
                
                // Start locating the user
                locationManger?.startUpdatingLocation()
                
                // Center the map around the last known location
                if let lastKnownLocation = lastKnownLocation {
                    
                    mapView.setCenter(lastKnownLocation.coordinate, animated: true)
                    
                }
                
            } else if status == .notDetermined {
                
                // Ask the user for permission
                locationManger?.requestWhenInUseAuthorization()
                
            }
            
        } else  {
            
            // Location services turned off
            showGeoLocationError()
            
        }
        
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
    
} // End class

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        
        if let location = location {
            
            // Center the map around this location, only if its the first time locating the user
            if lastKnownLocation == nil {
                mapView.setCenter(location.coordinate, animated: true)
            }
            
            lastKnownLocation = location
            
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .denied || status == .restricted {
            
            // User chose "don't allow"
            showGeoLocationError()
            
        } else if status == .authorizedAlways || status == .authorizedWhenInUse {
            
            // Start locating the user
            locationManger?.startUpdatingLocation()
            
        }
        
    }
    
}
