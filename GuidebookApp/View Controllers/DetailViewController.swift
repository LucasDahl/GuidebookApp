//
//  DetailViewController.swift
//  GuidebookApp
//
//  Created by Lucas Dahl on 11/11/18.
//  Copyright © 2018 Lucas Dahl. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // Properties
    var place:Place?
    
    // Outlets
    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Check if a place has been set
        if place != nil {
            
            showPlace(place!)
            
        }
        
    }
    
    func showPlace(_ p:Place) {
        
        // Set the labels
        nameLabel.text = p.name
        addressLabel.text = p.address
        summaryLabel.text = p.summary
        placeImageView.image = UIImage(named: p.filename!)
        
    }
    
    
    // MARK: IB Actions
    @IBAction func backtapped(_ sender: UIButton) {
        
        // Dismisses the DetailViewController
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func notesTapped(_ sender: UIButton) {
        
        let notesVC = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.notesViewController) as? NoteViewController
        
        if let notesVC = notesVC {
            
            // Set the place property
            notesVC.place = place
            
            // Present the view controller
            present(notesVC, animated: true, completion: nil)
            
        }
        
    }
    
    @IBAction func mapTapped(_ sender: UIButton) {
        
        let mapVC = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.mapViewController) as? MapViewController
        
        if let mapVC = mapVC {
            
            // Set the place property
            mapVC.place = place
            
            // Present the ViewController
            present(mapVC, animated: true, completion: nil)
            
        }
        
    }
    
} // End class
