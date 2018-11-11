//
//  PlaceService.swift
//  GuidebookApp
//
//  Created by Lucas Dahl on 11/11/18.
//  Copyright © 2018 Lucas Dahl. All rights reserved.
//

import Foundation
import RealmSwift

class PlaceService {
    
    static func getPlaces() -> Results<Place> {
        
        // Get a reference to the place.realm file
        let realm = try! Realm(configuration: Constants.RealmConfig.placeConfig)
        
        // Get the places and return the,m
        return realm.objects(Place.self)
        
    }
    
}
