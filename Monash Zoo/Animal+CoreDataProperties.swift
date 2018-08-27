//
//  Animal+CoreDataProperties.swift
//  Monash Zoo
//
//  Created by Sam on 2018/8/27.
//  Copyright © 2018年 Sam. All rights reserved.
//
//

import Foundation
import CoreData


extension Animal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Animal> {
        return NSFetchRequest<Animal>(entityName: "AnimalData")
    }

    @NSManaged public var descript: String?
    @NSManaged public var mapIcon: String?
    @NSManaged public var name: String?
    @NSManaged public var long: Double
    @NSManaged public var lat: Double
    @NSManaged public var photo: NSSet?

}

// MARK: Generated accessors for photo
extension Animal {

    @objc(addPhotoObject:)
    @NSManaged public func addToPhoto(_ value: ImageMetaData)

    @objc(removePhotoObject:)
    @NSManaged public func removeFromPhoto(_ value: ImageMetaData)

    @objc(addPhoto:)
    @NSManaged public func addToPhoto(_ values: NSSet)

    @objc(removePhoto:)
    @NSManaged public func removeFromPhoto(_ values: NSSet)

}
