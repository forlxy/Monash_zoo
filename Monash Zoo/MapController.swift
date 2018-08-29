//
//  MapViewContoller.swift
//  Monash Zoo
//
//  Created by Sam on 2018/8/19.
//  Copyright © 2018年 Sam. All rights reserved.
//

import UIKit
import MapKit
import CoreData
class MapController: UIViewController{  
    
    private var animalList: [Animal] = []
    private var managedObjectContext: NSManagedObjectContext
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    required init?(coder aDecoder: NSCoder) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedObjectContext = (appDelegate?.persistentContainer.viewContext)!
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "AnimalData")
        
        do {
            animalList = try managedObjectContext.fetch(fetchRequest) as! [Animal]
            if animalList.count == 0 {
                preSaveImages()
                addAnimalData()
                animalList = try managedObjectContext.fetch(fetchRequest) as! [Animal]
            }
        } catch  {
            fatalError("Failed to fetch animal data: \(error)")
        }
        
        for animal in animalList {
            let location: FencedAnnotation = FencedAnnotation (newTitle: animal.name!, newSubtitle: animal.descript!, lat: animal.lat, long: animal.long)
            addAnnotation(annotation: location)
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    //Reference: https://stackoverflow.com/questions/1383598/core-data-quickest-way-to-delete-all-instances-of-an-entity
    func clearCoreData(fetchRequest: NSFetchRequest<NSFetchRequestResult>) {
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try managedObjectContext.execute(deleteRequest)
        } catch let error as NSError {
            print("Error: \(error)")
        }
    }
    
    func preSaveImages() {
        //Save default ones
        var image = #imageLiteral(resourceName: "cow")
        var data = Data()
        data = UIImageJPEGRepresentation(image, 0.8)!
        
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        if let pathComponent = url.appendingPathComponent("Cow"){
            let filePath = pathComponent.path
            let fileManager = FileManager.default
            fileManager.createFile(atPath: filePath, contents: data, attributes: nil)
        }
        
        image = #imageLiteral(resourceName: "pig")
        data = UIImageJPEGRepresentation(image, 0.8)!
        if let pathComponent = url.appendingPathComponent("Pig"){
            let filePath = pathComponent.path
            let fileManager = FileManager.default
            fileManager.createFile(atPath: filePath, contents: data, attributes: nil)
        }
        
        image = #imageLiteral(resourceName: "chicken")
        data = UIImageJPEGRepresentation(image, 0.8)!
        if let pathComponent = url.appendingPathComponent("Chicken"){
            let filePath = pathComponent.path
            let fileManager = FileManager.default
            fileManager.createFile(atPath: filePath, contents: data, attributes: nil)
        }
        
        image = #imageLiteral(resourceName: "goat")
        data = UIImageJPEGRepresentation(image, 0.8)!
        if let pathComponent = url.appendingPathComponent("Goat"){
            let filePath = pathComponent.path
            let fileManager = FileManager.default
            fileManager.createFile(atPath: filePath, contents: data, attributes: nil)
        }
       
        image = #imageLiteral(resourceName: "rabbit")
        data = UIImageJPEGRepresentation(image, 0.8)!
        if let pathComponent = url.appendingPathComponent("Rabbit"){
            let filePath = pathComponent.path
            let fileManager = FileManager.default
            fileManager.createFile(atPath: filePath, contents: data, attributes: nil)
        }
    }
    

    func addAnimalData() {
        
//        var newImage = NSEntityDescription.insertNewObject(forEntityName: "ImageMetaData", into: managedObjectContext) as! ImageMetaData
//        newImage.fileName = "Cow"
        var animal = NSEntityDescription.insertNewObject(forEntityName: "AnimalData", into: managedObjectContext) as! Animal
        animal.name = "Cow"
        animal.descript = "This is a cow."
        animal.lat = -37.52
        animal.long = 145.4
        animal.mapIcon = "Cow"
        animal.photo = nil
        
        animal = NSEntityDescription.insertNewObject(forEntityName: "AnimalData", into: managedObjectContext) as! Animal
        animal.name = "Pig"
        animal.descript = "This is a pig."
        animal.lat = -38
        animal.long = 145.25
        animal.mapIcon = "Pig"
        animal.photo = nil
        
        animal = NSEntityDescription.insertNewObject(forEntityName: "AnimalData", into: managedObjectContext) as! Animal
        animal.name = "Rabbit"
        animal.descript = "This is a rabbit."
        animal.lat = -37.6
        animal.long = 145.2
        animal.mapIcon = "Rabbit"
        animal.photo = nil
        
        animal = NSEntityDescription.insertNewObject(forEntityName: "AnimalData", into: managedObjectContext) as! Animal
        animal.name = "Chicken"
        animal.descript = "This is a chicken."
        animal.lat = -37.5
        animal.long = 145.4
        animal.mapIcon = "Chicken"
        animal.photo = nil
        
        animal = NSEntityDescription.insertNewObject(forEntityName: "AnimalData", into: managedObjectContext) as! Animal
        animal.name = "Goat"
        animal.descript = "This is a goat."
        animal.lat = -37.05
        animal.long = 145.07
        animal.mapIcon = "Goat"
        animal.photo = nil
        
        do {
            try managedObjectContext.save()
        } catch let error {
            print("Could not save Core Data: \(error)")
        }
        
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
        self.mapView.selectAnnotation(annotation, animated: true)
        
        let span = MKCoordinateSpanMake(0.0275, 0.0275)
        let coodinate = annotation.coordinate
        let region = MKCoordinateRegion(center: coodinate, span: span)
        self.mapView.setRegion(region, animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowAllSegue" {
            if let controller = segue.destination as? ListController {
                controller.mapViewController = self
                controller.allList = animalList
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
