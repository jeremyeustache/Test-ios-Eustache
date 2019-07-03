//
//  UIImageView+ImageFromServer.swift
//  Test-ios-Eustache
//
//  Created by jeremy eustache on 02/07/2019.
//  Copyright © 2019 jeremy eustache. All rights reserved.
//

import Foundation
import UIKit

//Extension to UIImageView to get an image from an URL
extension UIImageView {
    public func imageFromServer(urlString: String, placeholder : UIImage? = nil) {
        
        image = placeholder
        
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
                
            })
            
        }).resume()
    }
}

