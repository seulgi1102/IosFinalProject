//
//  image.swift
//  MasterDetail
//
//  Created by SeulgiKim on 2024/06/19.
//

import Foundation

import UIKit

extension UIImage{
    func resized(to size: CGSize) -> UIImage{
        return UIGraphicsImageRenderer(size: size).image{ _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
