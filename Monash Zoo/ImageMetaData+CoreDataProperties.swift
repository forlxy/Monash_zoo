//
//  ImageMetaData+CoreDataProperties.swift
//  Monash Zoo
//
//  Created by Sam on 2018/8/27.
//  Copyright © 2018年 Sam. All rights reserved.
//
//

import Foundation
import CoreData


extension ImageMetaData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageMetaData> {
        return NSFetchRequest<ImageMetaData>(entityName: "ImageMetaData")
    }

    @NSManaged public var filename: String?
    @NSManaged public var animal: Animal?

}
