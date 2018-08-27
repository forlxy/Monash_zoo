//
//  NewLocationController.swift
//  Monash Zoo
//
//  Created by Sam on 2018/8/19.
//  Copyright © 2018年 Sam. All rights reserved.
//

import UIKit
import MapKit

class AddContoller: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var titleTextView: UITextField!
    @IBOutlet weak var descriptionTextView: UITextField!
    @IBOutlet weak var latitudeTextView: UITextField!
    @IBOutlet weak var longitudeTextView: UITextField!
    
    
    @IBAction func saveCurrentLocation(_ sender: Any) {
        self.latitudeTextView.text = "\(currentLocation!.latitude)"
        self.longitudeTextView.text = "\(currentLocation!.longitude)"
    }
    
    @IBAction func saveNewLocation(_ sender: Any) {
        addNewLocation(title: titleTextView.text!, description: descriptionTextView.text!, lat: Double(latitudeTextView.text!)!, long: Double(longitudeTextView.text!)!)
    }
    
    var delegate: newLocationDelegate?
    var locationManager: CLLocationManager = CLLocationManager()
    var currentLocation: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 10
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let loc: CLLocation = locations.last!
        currentLocation = loc.coordinate
    }
    
    func addNewLocation(title: String, description: String, lat: Double, long: Double) {
        let location: FencedAnnotation = FencedAnnotation(newTitle: title, newSubtitle: description, lat: lat, long: long)
        delegate!.didSaveLocation(location)
        self.navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
