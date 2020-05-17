//
//  FoodMenuViewController.swift
//  Chicking
//
//  Created by Nagaraj R on 16/05/20.
//  Copyright © 2020 Nagaraj R. All rights reserved.
//

import UIKit
import Foundation
class FoodMenuViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
    
{
    
    @IBOutlet weak var food_view: UIView!
    @IBOutlet weak var food_collectionView: UICollectionView!
    @IBOutlet weak var vertical_collectionView: UICollectionView!
    @IBOutlet weak var collectionView: UICollectionView!
    var modelData: FoodCategory?
    var modelData1: Selected_category?
    var modelData2: Selected_category?
    var food_category = [String]()
    
    var selectedIndex: IndexPath?
    override func viewDidLoad() {
        super.viewDidLoad()
        //horizontal collection
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
        //vertical collection
        vertical_collectionView.delegate = self
        vertical_collectionView.dataSource = self
        vertical_collectionView.reloadData()
        //foodCollection
        food_collectionView.delegate = self
        food_collectionView.dataSource = self
        food_collectionView.layer.cornerRadius = 8
        food_collectionView.reloadData()
        // Do any additional setup after loading the view.
        self.fetch_category_data()
        self.Fetch_listCakesByCategory()
        self.fetch_listCakesByCategory(id: 7)
        navigationController?.navigationBar.barTintColor = UIColor(rgb: 0xFF800000)
        self.food_view.backgroundColor = UIColor(rgb: 0xFF800000)
    }
    //fetch horizontal data
    func fetch_category_data()
    {
        SQLHelper.sharedInstance.fetchJSON(url: "listAllCakeCategory", httpMethod: "GET", params: [:])
        { (status, data) in
            do {
                let jsonResponse = try JSONDecoder().decode(FoodCategory.self, from: data)
                //  self.modelData = jsonResponse
                //  print(jsonResponse)
                //print("bitty")
                self.modelData = jsonResponse
                print(self.modelData?.data)
                var indexpath = IndexPath(item: 1, section: 0)
                DispatchQueue.main.async {
                    
                    self.collectionView.reloadData()
                    self.collectionView.selectItem(at: indexpath, animated: true, scrollPosition: [])
                    
                }
                
            }
            catch{
                print(error)
            }
        }
    }
    
    //fetch vertical scrolling data
    func fetch_listCakesByCategory(id: Int)
    {
        
        let parameters : NSMutableDictionary = NSMutableDictionary()
        let url: String?
        url = "listCakesByCategory/"+String(id)
        //parameters.setValue(String(id), forKey: "id")
        SQLHelper.sharedInstance.fetchJSON(url:url!, httpMethod: "GET", params: parameters as! [String : Any] ) { (status, data) in
            print(data)
            do {
                let jsonResponse = try JSONDecoder().decode(Selected_category.self, from: data)
                //  self.modelData = jsonResponse
                //  print(jsonResponse)
                //print("bitty")
                self.modelData1 = jsonResponse
                print(self.modelData1?.data)
                
                DispatchQueue.main.async {
                    self.vertical_collectionView.reloadData()
                    //self.food_collectionView.reloadData()
                }
            
            }
            catch{
                print(error)
            }
        }
    }
    
    func Fetch_listCakesByCategory()
    {
        
        let parameters : NSMutableDictionary = NSMutableDictionary()
        let url: String?
         let User_Id = "7"
         parameters.setValue(String(User_Id), forKey: "id")
        url = "listCakesByCategory/"+User_Id
        //parameters.setValue(String(id), forKey: "id")
        SQLHelper.sharedInstance.fetchJSON(url:url!, httpMethod: "GET", params: parameters as! [String : Any] ) { (status, data) in
            print(data)
            do {
                let jsonResponse = try JSONDecoder().decode(Selected_category.self, from: data)
                //  self.modelData = jsonResponse
                //  print(jsonResponse)
                //print("bitty")
                self.modelData2 = jsonResponse
                print(self.modelData2?.data)
                
                DispatchQueue.main.async {
                   
                    self.food_collectionView.reloadData()
                }
            
            }
            catch{
                print(error)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.food_collectionView
        {
             return modelData2?.data.count == nil ? 0: (modelData2?.data.count)!
        }
        if collectionView == self.collectionView
        {
            return modelData?.data.count == nil ? 0: (modelData?.data.count)!
            
        }
        
        return modelData1?.data.count == nil ? 0: (modelData1?.data.count)!
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.food_collectionView
        {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "foodOffer", for: indexPath) as! foodOfferCollectionViewCell
            cell.food_price.text = modelData2?.data[indexPath.row].price
            cell.food_description.attributedText = modelData2?.data[indexPath.row].description.convertHtmlToAttributedStringWithCSS(font: UIFont(name: "Arial", size: 11), csscolor: "black", lineheight: 1 )
            cell.title.text = modelData2?.data[indexPath.row].title
            if(modelData2?.data[indexPath.row].image != nil){
                cell.food_image.image = UIImage(url: URL(string: "https://mobileapp.chickinguae.com/images/cakes/" + (modelData2?.data[indexPath.row].image)!))
                       }
            cell.layer.cornerRadius = 8
            return cell
            
        }
        if collectionView == self.collectionView
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodMenu", for: indexPath) as! FoodMenuCollectionViewCell
            cell.layer.cornerRadius = 8
            cell.tag = indexPath.item
            if selectedIndex == nil && indexPath.row == 0 {
                cell.backgroundColor = UIColor(rgb: 0xFF8B0000)
            } else if indexPath == selectedIndex {
               cell.backgroundColor = UIColor(rgb: 0xFF8B0000)
           }
            cell.horizontal_list.text = modelData?.data[indexPath.row].title
            return cell
        }
        if collectionView == self.vertical_collectionView
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "verticalCollection", for: indexPath) as! verticalCollectionViewCell
            cell.price.text = modelData1?.data[indexPath.row].price
            cell.title.text = modelData1?.data[indexPath.row].title
            if(modelData1?.data[indexPath.row].image != nil){
                cell.food_image.image = UIImage(url: URL(string: "https://mobileapp.chickinguae.com/images/cakes/" + (modelData1?.data[indexPath.row].image)!))
            }
            cell.layer.cornerRadius = 8
            cell.tag = indexPath.row
   
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.food_collectionView
        {
            return CGSize(width: self.food_collectionView.frame.width - 10, height: 240)
//            return CGSize(width: 381, height: 240)
        }
        if collectionView == self.collectionView
        {
            return CGSize(width: 129, height: 50)
        }
//        return CGSize(width:  200, height: 229)
        return CGSize(width: self.vertical_collectionView.frame.width/2 - 10, height: 230)

    }
       
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView
        {

            selectedIndex = indexPath
            collectionView.reloadData()
            self.fetch_listCakesByCategory(id: (modelData?.data[indexPath.row].id)!)
            
        }
        if collectionView == vertical_collectionView
        {
            vertical_collectionView.reloadData()
             let storyBoard : UIStoryboard = UIStoryboard(name: "Chicking", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "detailed") as! selectedDataViewController
            nextViewController.food_title = (self.modelData1?.data[indexPath.row].title)!
            nextViewController.food_description = (self.modelData1?.data[indexPath.row].description)!
            nextViewController.food_image = (self.modelData1?.data[indexPath.row].image)!
            nextViewController.price = (self.modelData1?.data[indexPath.row].price)!
            self.navigationController?.show(nextViewController, sender: self)
        }
        if collectionView == food_collectionView
        {
            food_collectionView.reloadData()
          let storyBoard : UIStoryboard = UIStoryboard(name: "Chicking", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "detailed") as! selectedDataViewController
            nextViewController.food_title = (self.modelData1?.data[indexPath.row].title)!
            nextViewController.food_description = (self.modelData1?.data[indexPath.row].description)!
            nextViewController.food_image = (self.modelData1?.data[indexPath.row].image)!
            nextViewController.price = (self.modelData1?.data[indexPath.row].price)!
            self.navigationController?.show(nextViewController, sender: self)
        }
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
extension UIImage {
    convenience init?(url: URL?)
    {
        guard let url = url else {return nil}
        do {
            let data = try Data(contentsOf: url)
            self.init(data: data)
        }
        catch
        {
            print("Cannot load image from url: \(url) with error:\(error)")
            return nil
        }
    }
}
extension String {
    private var convertHtmlToNSAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else {
            return nil
        }
        do {
            return try NSAttributedString(data: data,options: [.documentType: NSAttributedString.DocumentType.html,.characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        }
        catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    public func convertHtmlToAttributedStringWithCSS(font: UIFont? , csscolor: String , lineheight: Int) -> NSAttributedString? {
        guard let font = font else {
            return convertHtmlToNSAttributedString
        }
        let modifiedString = "<style>body{font-family: '\(font.fontName)'; font-size:\(font.pointSize)px; color: \(csscolor); line-height: \(lineheight)px; }</style>\(self)";
        guard let data = modifiedString.data(using: .utf8) else {
            return nil
        }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        }
        catch {
            print(error)
            return nil
        }
    }
}
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
