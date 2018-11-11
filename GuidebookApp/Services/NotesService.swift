//
//  NotesService.swift
//  GuidebookApp
//
//  Created by Lucas Dahl on 11/11/18.
//  Copyright © 2018 Lucas Dahl. All rights reserved.
//

import Foundation
import RealmSwift

class NoteService {
    
    static var token:NotificationToken?
    
    static func getNotes(_ placeId:String, updates: @escaping () -> Void) -> Results<Note> {
        
        // Get a reference to the realm file
        let realm = try! Realm()
        
        // Retrieve the results
        let results = realm.objects(Note.self).filter("placeId = %@", placeId).sorted(byKeyPath: "date", ascending: false)
        
        // Closes the token before opening another one.
        if token != nil {
            token?.invalidate()
        }
        
        token = results.observe { (changes) in
            
            switch changes {
                
            case .update:
                updates()
                break
            case .error:
                break
            case .initial:
                break
                
            }
            
        }
        
        // Return the results
        return results
        
    }
    
    static func addNote(_ n:Note) {
        
        // Get a reference to the realm file
        let realm = try! Realm()
        
        // add the note to the realm file
        try! realm.write {
            realm.add(n)
        }
        
        
    }
    
}
