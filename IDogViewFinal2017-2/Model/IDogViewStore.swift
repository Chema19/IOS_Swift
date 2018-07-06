//
//  IDogViewStore.swift
//  IDogViewFinal2017-2
//
//  Created by Josemaria Inga Villafuerte on 6/07/18.
//  Copyright © 2018 Josemaria Inga Villafuerte. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class IDogViewStore {
    
    let idKey = "id"
    let urlKey = "url"
    let uploadedAtKey = "uploadedAt"
    let createdAtKey = "createdAt"
    
    var idValue: String?
    var urlValue: String?
    var uploadedAtValue: String?
    var createdAtValue: String?
    
    init(){
        
    }
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    //CoreData
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func save(){
        delegate.saveContext()
    }
    
    func setFavorite(_ isFavorite: Bool, for can: Can) {
        if self.isFavorite(can: can) == isFavorite {
            return
        }
        if self.isFavorite(can: can) {
            //deleteFavorite(for: can)
        } else {
            editFavorite(for: can)
        }
    }
    
    //Save or edit a property list file
    func editFavorite(for can: Can) {
        
        let pathForThePlistFile = delegate.plistPathInDocument
        let id: String!
        let url: String!
        let uploadedAt: String!
        let createdAt: String!
        
        id = can.id
        url = can.url
        uploadedAt = can.time
        //Converto date() to String()
        createdAt = can.time
        
        do{
            try id?.write(toFile: pathForThePlistFile, atomically: true, encoding: String.Encoding.utf8)
            try url?.write(toFile: pathForThePlistFile, atomically: true, encoding: String.Encoding.utf8)
            try uploadedAt?.write(toFile: pathForThePlistFile, atomically: true, encoding: String.Encoding.utf8)
            try createdAt?.write(toFile: pathForThePlistFile, atomically: true, encoding: String.Encoding.utf8)
        } catch{
            print(error)
        }
        save()
    }
    
    //Read a property list file
    func findFavoriteById(for can: Can) {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let documentDirectory = paths[0] as! String
        let path = documentDirectory.appending("myPropertiListFile.plist")
        let fileManager = FileManager.default
        
        if (!fileManager.fileExists(atPath: path)){
            if let bundlePath = Bundle.main.path(forResource: "myPropertiListFile", ofType: "plist"){
                let result = NSMutableDictionary(contentsOfFile: bundlePath)
                print("bundle file .plist is ->  \(String(describing: result?.description))")
                do{
                    try fileManager.copyItem(atPath: bundlePath, toPath: path)
                }catch{
                    print("copy failure")
                }
            }else{
                print("file .plist no found.")
            }
        }else{
            print("exits at path")
        }
        
        //parte donde se lee
        let resultDictionary = NSMutableDictionary(contentsOfFile: path)
        print("load .plist is -> \(String(describing: resultDictionary?.description))")
        
        let myDict = NSDictionary(contentsOfFile: path)
        if let dict = myDict{
            idValue = dict.object(forKey: idKey) as! String?
            urlValue = dict.object(forKey: urlKey) as! String?
            uploadedAtValue = dict.object(forKey: uploadedAtKey) as! String?
            createdAtValue = dict.object(forKey: createdAtKey) as! String?
        }else{
            print("load fail")
        }
    }
    
    func findAllFavorites() -> [NSManagedObject]? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
        do {
            let result = try context.fetch(request)
            return result as? [NSManagedObject]
        } catch let error {
            print("Query Error: \(error.localizedDescription)")
        }
        return nil
    }
    
    func isFavorite(can: Can) -> Bool {
        return findFavoriteById(for: can) != nil
    }
    
    func favorite(can: Can) {
        setFavorite(true, for: can)
    }
    
    func unFavorite(can: Can) {
        setFavorite(false, for: can)
    }
    
    func favoriteSourceIdsAsString() -> String {
        let favorites = findAllFavorites()
        
        if let favorites = favorites {
            print("All Favorites Count: \(favorites.count)")
            return favorites
                .map({ $0.value(forKey: "sourceId") as! String})
                .filter({ !$0.isEmpty })
                .prefix(20)
                .joined(separator: ",")
        }
        return ""
    }
    
}
