//
//  UIButton + Extension.swift
//  CHAT
//
//  Created by Никита Егоров on 23.11.2020.
//

import Foundation
import UIKit

extension UIButton {
    convenience init(title: String,
                     titleColor: UIColor,
                     font: UIFont? = .avenir20(),
                     backgroundColor: UIColor,
                     isShadow: Bool = false,
                     cornerRadius: CGFloat = 4) {
        self.init(type: .system)
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        self.titleLabel?.font = font
        
        self.layer.cornerRadius = cornerRadius
        
        if isShadow {
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowRadius = 4
            self.layer.shadowOpacity = 0.2
            self.layer.shadowOffset = CGSize(width: 0, height: 4)
        }
        
    }
}
