//
//  Animal+CoreDataClass.swift
//  Monash Zoo
//
//  Created by Sam on 2018/8/27.
//  Copyright © 2018年 Sam. All rights reserved.
//
//

import Foundation
import CoreData
import MapKit


public class Animal: NSManagedObject, MKAnnotation {
    public var coordinate: CLLocationCoordinate2D

    init(lat: Double, long: Double) {
        coordinate = CLLocationCoordinate2D()
        coordinate.latitude = lat
        coordinate.longitude = long
    }

}
