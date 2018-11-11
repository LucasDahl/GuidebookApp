//
//  Constants.swift
//  GuidebookApp
//
//  Created by Lucas Dahl on 11/11/18.
//  Copyright © 2018 Lucas Dahl. All rights reserved.
//

import Foundation
import RealmSwift

struct Constants {
    
    struct Storyboard {
    
        // Segue constants
        static let detailSegue = "toDetail"
        
        // Table cell constants
        static let placeCellId = "PlaceCell"
        
        // Table View constants
        static let notesViewController = "NotesViewController"
        static let composeViewController = "ComposeViewController"
        static let mapViewController = "MapViewController"
        
        
    }
    
    // Confrigure the Realm file
    struct RealmConfig {
        
        static let placeConfig = Realm.Configuration(fileURL: Bundle.main.url(forResource: "Place", withExtension: "realm"), inMemoryIdentifier: nil, syncConfiguration: nil, encryptionKey: nil, readOnly: true, schemaVersion: 0, migrationBlock: nil, deleteRealmIfMigrationNeeded: false, shouldCompactOnLaunch: nil, objectTypes: nil)
        
    }
    
}
