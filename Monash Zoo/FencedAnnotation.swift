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
    var animal: Animal
    
    init(newAnimal: Animal) {
        animal = newAnimal
        coordinate = CLLocationCoordinate2D()
        coordinate.latitude = newAnimal.lat
        coordinate.longitude = newAnimal.long
    }

    
}
