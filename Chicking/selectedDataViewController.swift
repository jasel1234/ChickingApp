//
//  selectedDataViewController.swift
//  Chicking
//
//  Created by Nagaraj R on 16/05/20.
//  Copyright © 2020 Nagaraj R. All rights reserved.
//

import UIKit

class selectedDataViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    var food_title: String = " "
    var food_description: String = " "
    var price: String = " "
    var food_image: String = " "
    
    @IBOutlet weak var detailed_collectionView: UICollectionView!
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "selectedDatacell", for: indexPath) as! SelectedDataCollectionViewCell
        cell.food_description.attributedText = self.food_description.convertHtmlToAttributedStringWithCSS(font: UIFont(name: "Arial", size: 13), csscolor: "black", lineheight: 2)
       cell.food_price.text = self.price
        cell.title.text = self.food_title
        cell.food_image.image = UIImage(url: URL(string: "https://mobileapp.chickinguae.com/images/cakes/" + self.food_image))
        cell.layer.cornerRadius = 8
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
      
        return CGSize(width: self.detailed_collectionView.frame.width, height: 446)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        detailed_collectionView.delegate = self
        detailed_collectionView.dataSource = self
        detailed_collectionView.layer.cornerRadius = 8
        detailed_collectionView.reloadData()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
