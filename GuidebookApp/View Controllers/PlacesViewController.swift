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
    var faves:Results<Place>?
    
    // Outlets
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Grab places from the bundle realm file
        places = PlaceService.getPlaces()
        
        // Grab the faves from the default realm file
        faves = FaveService.getFavePlaces()
        
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if faves!.count > 0 {
            
            // There are some faves saved, so do 2 sections
            return 2
            
        } else {
            
            // Otherwise just do one section for all places
            return 1
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView.numberOfSections > 1 && section == 0 {
            
            // There are 2 sections, and it's asking about the 1st section
            return faves != nil ? faves!.count : 0
            
        }else {
            
            // There is oly 1 section
            return places != nil ? places!.count : 0
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Storyboard.placeCellId, for: indexPath) as! PlaceCell
    
        // Get the place
        let p:Place?
            
        if tableView.numberOfSections > 1 && indexPath.section == 0 {
            
            // There are 2 sections, and it's asking about the 1st section
            p = faves![indexPath.row]
            
        }else {
            
            // There's only 1 sectiom
            p =  places![indexPath.row]
            
        }
        
        // Set the cell
        cell.showPlace(p!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Trigger the segue to the detail view controller
        performSegue(withIdentifier: Constants.Storyboard.detailSegue, sender: self)
        
    }
    
    // This is for sliding the cell
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        // Get the place
        var p:Place?
        
        if tableView.numberOfSections > 1 && indexPath.section == 0 {
            
            p = faves![indexPath.row]
            
        }else {
            
            p = places![indexPath.row]
            
        }
        
        // Decide what the action title should be
        var actionTitle = ""
        
        if tableView.numberOfSections > 1 && indexPath.section == 0 {
            
            // The user is sliding over a place in the fave section
            actionTitle = "Unfave"
            
        }else if faves!.index(of: p!) != nil {
            
            // This place is in the faves list
            actionTitle = "Unfave"
            
        } else {
            
            actionTitle = "Fave"
            
        }
        
        let rowAction = UITableViewRowAction(style: .normal, title: actionTitle) { (action, indexPath) in
            
            // toggle the fave
            FaveService.toggleFave(p!.placeId!)
            
            // Get the new list of faves
            self.faves = FaveService.getFavePlaces()
            
            // Reload the tableview
            self.tableView.reloadData()
            
        }
        
        return [rowAction]
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        // Creating a UIView for the section header
        let view = UIView()
        
        // Create a label
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        // Create constraints for the label in the view
        let leftLabelConstraint = NSLayoutConstraint(item: label, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 10)
        let topLabelConstraint = NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 10)
        
        // Add the label into the view
        view.addSubview(label)
        
        // Add the constraints to the view
        view.addConstraints([leftLabelConstraint, topLabelConstraint])
        
        // Set the label text
        if tableView.numberOfSections > 1 && section == 0 {
            label.text = "Faves"
        } else {
            label.text = "All Places"
        }
        
        // Return the view
        return view
        
    }
    
}
