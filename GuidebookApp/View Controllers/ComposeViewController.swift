//
//  ComposeViewController.swift
//  GuidebookApp
//
//  Created by Lucas Dahl on 11/11/18.
//  Copyright © 2018 Lucas Dahl. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {
    
    // properties
    var place:Place?

    // Outlets
    @IBOutlet weak var textView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelTapped(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func saveTapped(_ sender: UIButton) {
        
        // Make sure place is not nil
        guard place != nil else {
            return
        }
        
        // Create the note that needs to be saved
        var note = Note()
        note.text = textView.text
        
        // Create a date formatter object
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MM d, yyyy - h:mm a"
        
        note.date = formatter.string(from: Date())
        note.placeId = place!.placeId
        
        // Save the note
        NoteService.addNote(note)
        
        // Dismiss the view controller
        dismiss(animated: false, completion: nil)
        
    }
    
}
