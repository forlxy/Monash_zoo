//
//  NewLocationController.swift
//  Monash Zoo
//
//  Created by Sam on 2018/8/19.
//  Copyright © 2018年 Sam. All rights reserved.
//

import UIKit
import MapKit

class AddController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var titleTextView: UITextField!
    @IBOutlet weak var descriptionTextView: UITextField!
    @IBOutlet weak var latitudeTextView: UITextField!
    @IBOutlet weak var longitudeTextView: UITextField!
    
    @IBAction func saveCurrentLocation(_ sender: Any) {
        self.latitudeTextView.text = "\(currentLocation!.latitude)"
        self.longitudeTextView.text = "\(currentLocation!.longitude)"
    }
    
    @IBAction func saveNewLocation(_ sender: Any) {
//        var animal: Animal
//        addNewLocation(animal: animal)
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
    
    func addNewLocation(animal: Animal) {
        let location: FencedAnnotation = FencedAnnotation(newAnimal: animal)
        delegate!.didSaveLocation(location)
        self.navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
