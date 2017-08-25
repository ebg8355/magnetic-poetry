//
//  UIView+takeSnapshot.swift
//  DatPoet
//
//  Created by student on 10/16/16.
//  Copyright © 2016 Erik Gerharter. All rights reserved.
//

import UIKit

extension UIView
{
    func takeSnapshot() -> UIImage?
    {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
