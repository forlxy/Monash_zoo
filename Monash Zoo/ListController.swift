//
//  LocationListContoller.swift
//  Monash Zoo
//
//  Created by Sam on 2018/8/19.
//  Copyright © 2018年 Sam. All rights reserved.
//

import UIKit
import MapKit

protocol newLocationDelegate {
    func didSaveLocation(_ annotation: FencedAnnotation)
}

class ListController: UITableViewController, CLLocationManagerDelegate, newLocationDelegate, UISearchResultsUpdating {
    
    var status: Bool
    
    
    var allList = [FencedAnnotation]()
    var filteredList = [FencedAnnotation]()
    
    @IBOutlet weak var sortButton: UIBarButtonItem!
    @IBAction func sortClick(_ sender: Any) {
        if status {
            filteredList = filteredList.sorted {$0.animal.name! <= $1.animal.name!}
            sortButton.title = "Z-A"
        }
        else {
            filteredList = filteredList.sorted {$0.animal.name! > $1.animal.name!}
            sortButton.title = "A-Z"
        }
        status = !status;
        
        tableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, searchText.count > 0 {
            filteredList = allList.filter({(element: FencedAnnotation) -> Bool in
                return element.animal.name!.contains(searchText)
            })
        }
        else {
            filteredList = allList
        }
        
        tableView.reloadData()
        
    }
    
    var mapViewController: MapController?
    
    var geoLocation: CLCircularRegion?
    var locationManager: CLLocationManager = CLLocationManager()
    
    required init?(coder aDecoder: NSCoder) {
        status = true
        super.init(coder: aDecoder)
    }
    
//NOT YET
    func didSaveLocation(_ annotation: FencedAnnotation) {
//        self.locationList.add(annotation)
        self.mapViewController?.addAnnotation(annotation: annotation)
        self.tableView.reloadData()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        filteredList = allList
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Animal"
        navigationItem.searchController = searchController
        
//        let location: FencedAnnotation = FencedAnnotation (newTitle: "Monash University - Caulfield", newSubtitle: "Our location right now", lat: -37.877623, long: 145.045374)
//        self.locationList.add(location)
//        self.mapViewController?.addAnnotation(annotation: location)
//
//        geoLocation = CLCircularRegion(center: location.coordinate, radius: 100, identifier: location.title!)
//        geoLocation!.notifyOnExit = true
//
//        locationManager.delegate = self
//        locationManager.requestAlwaysAuthorization()
//        locationManager.startMonitoring(for: geoLocation!)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        let alert = UIAlertController(title: "Movement Detected!", message: "You have left Monash Caulfield", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func loadImageData(fileName: String) -> UIImage? {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        var image: UIImage?
        if let pathComponent = url.appendingPathComponent(fileName) {
            let filePath = pathComponent.path
            let fileManager = FileManager.default
            let fileData = fileManager.contents(atPath: filePath)
            image = UIImage(data: fileData!)
        }
        
        return image
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnimalCell", for: indexPath) as! AnimalCell
        //let annotation: FencedAnnotation = self.locationList.object(at: indexPath.row) as! FencedAnnotation
        cell.nameLabel!.text = filteredList[indexPath.row].animal.name
        
        cell.discriptionLabel!.text = filteredList[indexPath.row].animal.descript
        
       
        cell.iconImage.image = loadImageData(fileName: filteredList[indexPath.row].animal.mapIcon!)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.mapViewController?.focusOn(annotation: self.filteredList[indexPath.row] as MKAnnotation)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddFromAll" {
            let controller = segue.destination as! AddController
            controller.delegate = self
        }
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
