//
//  MapView.swift
//  UserLocation
//
//  Created by Alvaro Sanchez on 5/24/19.
//  Copyright © 2019 Alvaro Sanchez. All rights reserved.
//

import UIKit
import Firebase
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    var currentLat = double_t()
    var currentLon = double_t()
    let quest = LinkedList()
    let locStack = Stack<Locations>()
    var window: UIWindow?
    var map: MKMapView!

    
    let markButton: UIButton = {
        let butt = UIButton(type: .system)
        butt.backgroundColor = .gray
        butt.setTitle("Mark", for: .normal)
        butt.setTitleColor(.black, for: .normal)
        butt.addTarget(self, action: #selector(markLocation), for: .touchUpInside)
        butt.layer.cornerRadius = 8.0
        return butt
    }()
    
    let endButton: UIButton = {
        let butt = UIButton(type: .system)
        butt.backgroundColor = .gray
        butt.setTitle("End", for: .normal)
        butt.setTitleColor(.black, for: .normal)
        butt.addTarget(self, action: #selector(endQuest), for: .touchUpInside)
        butt.layer.cornerRadius = 8.0
        return butt
    }()
    
    //BUTTON THAT TAKES YOU TO SIGN IN PAGE
    let followQuestButton: UIButton = {
        let si = UIButton(type: .system)
        si.backgroundColor = .gray
        si.setTitle("Sign In", for: .normal)
        si.setTitleColor(.blue, for: .normal)
        si.addTarget(self, action: #selector(followQuestFunc), for: .touchUpInside)
        si.layer.cornerRadius = 8.0
        return si
    }()
    
    //FUNCTION CHANGES VIEW TO LOGIN CONTROLLER
    @objc func followQuestFunc() {
        let logincontroller = FollowQuestController()
        present(logincontroller, animated: true, completion: {})
    }
    
    
    
    
    //find a way to add multiple annotations
    @objc func markLocation(_ sender: Any) {
        quest.append(latitude: currentLat, longitude: currentLon)
        for locations in quest {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: locations.latitude, longitude: locations.longitude)
            map.addAnnotation(annotation)
        }
    }
    
    
    
    
    @objc func endQuest(_ sender: Any) {
        print("end")
        let userID = Auth.auth().currentUser!.uid
        var ref: DocumentReference? = nil
        let db = Firestore.firestore()
        ref = db.collection("Log").document()
        let timestamp = NSDate().timeIntervalSince1970
        let myTimeInterval = TimeInterval(timestamp)
        for locations in quest{
            let latlon = GeoPoint(latitude: locations.latitude, longitude: locations.longitude)
            ref!.setData([ "Locations": FieldValue.arrayUnion([latlon]), "UID": userID, "Timestamp": myTimeInterval], merge: true)
        }
        quest.removeAll()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        currentLat = locValue.latitude
        currentLon = locValue.longitude
        let userLocation = locations.last
        let viewRegion = MKCoordinateRegion(center: (userLocation?.coordinate)!, latitudinalMeters: 600, longitudinalMeters: 600)
        self.map.setRegion(viewRegion, animated: true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(markButton)
        view.addSubview(endButton)
        view.addSubview(followQuestButton)
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.view.backgroundColor = UIColor.white
        
        self.map = MKMapView(frame: CGRect(x: 0, y: 20, width: (self.window?.frame.width)!, height: 300))
        self.view.addSubview(self.map!)
        
        self.locationManager.requestWhenInUseAuthorization()
        map.showsUserLocation = true
        if CLLocationManager.locationServicesEnabled(){
            
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
            _ = markButton.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 40, bottomConstant: 10, rightConstant: 40, heightConstant: 30)
        
            _ = endButton.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 40, bottomConstant: 50, rightConstant: 40, heightConstant: 30)
        
             _ = followQuestButton.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 40, bottomConstant: 90, rightConstant: 40, heightConstant: 30)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

}
