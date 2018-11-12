//
//  FaveService.swift
//  GuidebookApp
//
//  Created by Lucas Dahl on 11/11/18.
//  Copyright © 2018 Lucas Dahl. All rights reserved.
//

import Foundation
import RealmSwift

class FaveService {
    
    static var fave:Fave = {
        
        // get a reference to the default realm object
        let realm = try! Realm()
        
        // Try to get the fave object
        var f = realm.objects(Fave.self).first
        
        if f != nil {
            
            // Found the fave object in the default realm
            return f!
            
        } else {
            
            // There's no fave object in the default realm
            f = Fave()
            
            // Add the new fave object to the default realm
            try! realm.write {
                realm.add(f!)
            }
            
            return f!
            
        }
        
    }()
    
    static func getFavePlaces() -> Results<Place> {
        
        // Get a reference to the place realm file
        let realm = try! Realm(configuration: Constants.RealmConfig.placeConfig)
        
        let results = realm.objects(Place.self).filter("placeId IN %@", fave.favePlaceIds)
        
        return results
        
    }
    
    static func toggleFave(_ placeId:String) {
        
        // Get a reference to the default realm
        let realm = try! Realm()
        
        // Check if this placeId is in the faves list
        let index = fave.favePlaceIds.index(of: placeId)
        
        try! realm.write {
            
            if index == nil {
                
                fave.favePlaceIds.insert(placeId, at: 0)
                
            } else {
                
                fave.favePlaceIds.remove(at: index!)
                
            }
            
        }
        
    }
    
}
