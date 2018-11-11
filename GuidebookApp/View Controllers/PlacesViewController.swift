//
//  PlacesViewController.swift
//  GuidebookApp
//
//  Created by Lucas Dahl on 11/11/18.
//  Copyright © 2018 Lucas Dahl. All rights reserved.
//

import UIKit
import RealmSwift

class PlacesViewController: UIViewController {
    
    // Properties
    var places:Results<Place>?
    
    // Outlets
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Grab places from the bundle realm file
        places = PlaceService.getPlaces()
        
        // Configure the table view
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Check for nil values to avoid a crash
        guard places != nil && tableView.indexPathForSelectedRow != nil else {
            return
        }
        
        let detailVC = segue.destination as? DetailViewController
        
        if let detailVC = detailVC {
            
            // Set the place for the detail view contorller
            detailVC.place = places![tableView.indexPathForSelectedRow!.row]
            
        }
        
    }

} // End class

extension PlacesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places != nil ? places!.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Storyboard.placeCellId, for: indexPath) as! PlaceCell
    
        // Get the place
        let p = places![indexPath.row]
        
        // Set the cell
        cell.showPlace(p)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Trigger the segue to the detail view controller
        performSegue(withIdentifier: Constants.Storyboard.detailSegue, sender: self)
        
    }
    
    
}
