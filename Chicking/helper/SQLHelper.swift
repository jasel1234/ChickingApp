//
//  SQLHelper.swift
//  Chicking
//
//  Created by Nagaraj R on 16/05/20.
//  Copyright © 2020 Nagaraj R. All rights reserved.
//

import UIKit
import SystemConfiguration
class SQLHelper
{
    static let sharedInstance = SQLHelper()    // fetch json
    func fetchJSON(url: String, httpMethod: String, params:[String:Any] , completionHandler:@escaping (_ status:String,_ data :Data) -> Void){
        if httpMethod == "GET" {
            let baseUrl: String = "https://mobileapp.chickinguae.com/index.php/api/"
            guard let url = URL(string: baseUrl + url) else { return }
            print(url)
            let session = URLSession.shared
            session.dataTask(with: url) { (data, response, error) in
                if let response = response {
                    print(response)
                }
                guard let data = data,
                    error == nil else {
                        return
                        
                }
                completionHandler("succes",data)
            }.resume()
        }
    }
}
