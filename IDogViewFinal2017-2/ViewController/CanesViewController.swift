//
//  CanesViewController.swift
//  IDogViewFinal2017-2
//
//  Created by Josemaria Inga Villafuerte on 5/07/18.
//  Copyright © 2018 Josemaria Inga Villafuerte. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

private let reuseIdentifier = "Cell"

class CanCell: UICollectionViewCell {
    
    @IBOutlet var CanImage: UIImageView!
    func updateViews(from can: Can){
        if let url = URL(string: can.url)
        {
            CanImage.af_setImage(withURL: url)
        }
    }
}

class CanesViewController: UICollectionViewController {

    var canes: [Can] = []
    var currentCanIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        // self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        updateData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return canes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CanCell
    
        // Configure the cell
        cell.updateViews(from: canes[indexPath.row])
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }*/
    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    
    //Si selecciono un objeto
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected \(indexPath.row)")
        currentCanIndex = indexPath.row
        self.performSegue(withIdentifier: "show", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show" {
            let canViewController = (segue.destination as! CanViewController)
            canViewController.can = canes[currentCanIndex]
        }
        return
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let collectionView = collectionView {
            if collectionView.numberOfItems(inSection: 0) > 0{
                collectionView.reloadItems(at: [IndexPath(
                    item: self.currentCanIndex, section: 0)])
            }
        }
    }
    
    
    func updateData(){
        Alamofire.request(NewsApi.canesUrl)
        .validate()
        .responseJSON(completionHandler: {response in
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                let response_code = json["response_code"].intValue
                if response_code != 200 {
                    print("NewsApi Error: \(json["message"].stringValue)")
                    return
                }
                self.canes = Can.buildAll(from: json["data"].arrayValue)
                self.collectionView!.reloadData()
            case .failure(let error):
                print("Response Error: \(error.localizedDescription)")
            }
        })
    }

}
