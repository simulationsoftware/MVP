//
//  Quest.swift
//  UserLocation
//
//  Created by Alvaro Sanchez on 6/2/19.
//  Copyright © 2019 Alvaro Sanchez. All rights reserved.
//

import Foundation

protocol DocumentSerializable {
    init?(dictionary:[String:Any])
}






struct Quest {
    var questLocations = [String]()
    var UID: String
    var timeStamp: Date
    
    
    var dictionary:[String:Any] {
        return [
            "questLocations": questLocations,
            "UID": UID,
            "timeStamp": timeStamp
        ]
        
    }
    
    
}



extension Quest: DocumentSerializable{
    init?(dictionary: [String: Any]) {
        guard let questLocations = dictionary["questLocations"] as? [String],
            let UID = dictionary["UID"] as? String,
            let timeStamp = dictionary["timeStamp"] as? Date else {return nil}
        
        
        self.init(questLocations: questLocations, UID: UID, timeStamp: timeStamp)
    }
}

