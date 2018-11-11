//
//  NoteViewController.swift
//  GuidebookApp
//
//  Created by Lucas Dahl on 11/11/18.
//  Copyright © 2018 Lucas Dahl. All rights reserved.
//

import UIKit
import RealmSwift

class NoteViewController: UIViewController {
    
    // Properties
    var place:Place?
    var notes:Results<Note>?
    
    // Outlets
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Get notes for the place
        if place != nil {
            
            // Can safetly unwrap because all places have a place ID
            notes = NoteService.getNotes(place!.placeId!, updates: {
                
                // Notes result set has updated, so reload the tableview
                self.tableView.reloadData()
                
            })
            
        }
        
        // Configure the tableview
        tableView.delegate = self
        tableView.dataSource = self
        
        // Set dynamic cell height
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 150
        
    }
    

    @IBAction func doneTapped(_ sender: UIBarButtonItem) {
        
        // Dismiss the view controller
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func composeTapped(_ sender: UIBarButtonItem) {
        
        // Create a new compose view controller and present it
        let composeVC = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.composeViewController) as? ComposeViewController
        
        if let composeVC = composeVC {
            
            // Set the place property
            composeVC.place = place
            
            // Set the presentation mode
            composeVC.modalPresentationStyle = .overCurrentContext
            
            // Present it
            present(composeVC, animated: false, completion: nil)
            
        }
        
    }
    
} // End class


extension NoteViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes != nil ? notes!.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Storyboard.noteCellId, for: indexPath) as! NoteCell
        
        // Get the note
        let n = notes![indexPath.row]
        
        // Set the note
        cell.showNote(n)
        
        return cell
        
    }
    
}
