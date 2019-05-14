//
//  ViewController.swift
//  UserLocation
//
//  Created by Alvaro Sanchez on 5/8/19.
//  Copyright © 2019 Alvaro Sanchez. All rights reserved.
//

import UIKit
import MapKit
class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    var currentLat = double_t()
    var currentLon = double_t()
    var pins: [Locations] = []
    @IBOutlet weak var map: MKMapView!

    //find a way to add multiple annotations
    @IBAction func markLocation(_ sender: UIButton) {
        pins.append(Locations(latitude: currentLat, longitude: currentLon))
        for locations in pins {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: locations.latitude, longitude: locations.longitude)
            map.addAnnotation(annotation)
            print(locations)
            print(" ")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.locationManager.requestWhenInUseAuthorization()
        map.showsUserLocation = true
        if CLLocationManager.locationServicesEnabled(){
            
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            
            
        }
        
    }

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        currentLat = locValue.latitude
        currentLon = locValue.longitude
        //print("locations = \(locValue.latitude) \(locValue.longitude)")
        let userLocation = locations.last
        let viewRegion = MKCoordinateRegion(center: (userLocation?.coordinate)!, latitudinalMeters: 600, longitudinalMeters: 600)
        self.map.setRegion(viewRegion, animated: true)
    }
    
}

