//
//  Can.swift
//  IDogViewFinal2017-2
//
//  Created by Josemaria Inga Villafuerte on 5/07/18.
//  Copyright © 2018 Josemaria Inga Villafuerte. All rights reserved.
//

import Foundation
import SwiftyJSON

class Can {
    var id: String
    var url: String
    var time: String
    var format: String
    var verified: String
    var checked: String
    
    init(id: String, url: String, time: String, format: String, verified: String, checked: String){
        self.id = id
        self.url = url
        self.time = time
        self.format = format
        self.verified = verified
        self.checked = checked
    }
    
    convenience init(id: String, url: String){
        self.init(id: id, url: url, time: "", format: "", verified: "", checked: "")
    }
    
    convenience init(jsonCan: JSON){
        self.init(id: jsonCan["id"].stringValue,
                  url: jsonCan["url"].stringValue,
                  time: jsonCan["time"].stringValue,
                  format: jsonCan["format"].stringValue,
                  verified: jsonCan["verified"].stringValue,
                  checked: jsonCan["checked"].stringValue)
    }
    
    func isFavorite() -> Bool {
        let store = IDogViewStore()
        return store
    }
    func setFavorite(isFavorite: Bool){
        let store = IDogViewStore()
        store
    }
    
    class func buildAll(from jsonCanes: [JSON]) -> [Can] {
        let count = jsonCanes.count
        var canes: [Can] = []
        for i in 0 ..< count {
            canes.append(Can(jsonCan: JSON(jsonCanes[i])))
        }
        return canes
    }
}
