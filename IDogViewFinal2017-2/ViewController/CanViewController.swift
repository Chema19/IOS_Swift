//
//  CanViewController.swift
//  IDogViewFinal2017-2
//
//  Created by Josemaria Inga Villafuerte on 6/07/18.
//  Copyright © 2018 Josemaria Inga Villafuerte. All rights reserved.
//

import UIKit

class CanViewController: UIViewController {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var plistPath: String!
    var isFavorite: Bool = false
    
    
    
    var can: Can? {
        didSet {
            print("Set \(can!.id)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let can = can {
            dateLabel.text = can.time
            if let url = URL(string: can.url){
                photoImageView.af_setImage(withURL: url)
            }
        }
        // Do any additional setup after loading the view.
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func doneAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
