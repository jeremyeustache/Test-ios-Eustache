//
//  UIImageView+SetRounded.swift
//  Test-ios-Eustache
//
//  Created by jeremy eustache on 03/07/2019.
//  Copyright © 2019 jeremy eustache. All rights reserved.
//

import Foundation
import UIKit


extension UIImageView {
    public func setRounded(){
        
        self.layer.cornerRadius = (self.frame.width)/2
        self.layer.masksToBounds = true
        
    }
}
