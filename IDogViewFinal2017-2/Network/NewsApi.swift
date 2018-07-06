//
//  NewsApi.swift
//  IDogViewFinal2017-2
//
//  Created by Josemaria Inga Villafuerte on 5/07/18.
//  Copyright © 2018 Josemaria Inga Villafuerte. All rights reserved.
//

import Foundation

class NewsApi{
    static let baseUrl = "https://api.thedogapi.co.uk"
    public static var canesUrl: String{
        return "\(baseUrl)/v2/dog.php?limit=20"
    }
    public static var OneCanUrl: String{
        return "\(baseUrl)/v2/dog.php"
    }
}
