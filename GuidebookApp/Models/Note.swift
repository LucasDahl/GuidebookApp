//
//  Note.swift
//  GuidebookApp
//
//  Created by Lucas Dahl on 11/11/18.
//  Copyright © 2018 Lucas Dahl. All rights reserved.
//

import Foundation
import RealmSwift

class Note: Object {
    
    @objc dynamic var placeId:String?
    @objc dynamic var date:String?
    @objc dynamic var text:String?
    
}
