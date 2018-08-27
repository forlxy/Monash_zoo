//
//  FencedAnnotation.swift
//  Monash Zoo
//
//  Created by Sam on 2018/8/19.
//  Copyright © 2018年 Sam. All rights reserved.
//

import UIKit
import MapKit

class FencedAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(newTitle: String, newSubtitle: String, lat: Double, long: Double) {
        title = newTitle
        subtitle = newSubtitle
        coordinate = CLLocationCoordinate2D()
        coordinate.latitude = lat
        coordinate.longitude = long
    }

    
}
