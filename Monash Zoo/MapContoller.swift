//
//  MapViewContoller.swift
//  Monash Zoo
//
//  Created by Sam on 2018/8/19.
//  Copyright © 2018年 Sam. All rights reserved.
//

import UIKit
import MapKit


class MapContoller: UIViewController{  
    

    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addAnnotation(annotation: MKAnnotation) {
        self.mapView.addAnnotation(annotation)
    }
    
    func focusOn(annotation: MKAnnotation) {
        self.mapView.centerCoordinate = annotation.coordinate
        self.mapView.selectAnnotation(annotation,animated: true)
        
        let span = MKCoordinateSpanMake(0.0275, 0.0275)
        let coodinate = annotation.coordinate
        let region = MKCoordinateRegion(center: coodinate, span: span)
        self.mapView.setRegion(region, animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowAll" {
            if let controller = segue.destination as? LocationListContoller{
                controller.mapViewController = self
            }
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
