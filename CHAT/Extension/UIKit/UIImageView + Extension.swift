//
//  UIImageView + Extension.swift
//  CHAT
//
//  Created by Никита Егоров on 23.11.2020.
//

import UIKit

extension UIImageView {
    
    convenience init(image: UIImage?, contentMode: UIView.ContentMode) {
        self.init()
        self.image = image
        self.contentMode = contentMode
    }
}
