//
//  photo.swift
//  Photo_Scavenger_Hunt
//
//  Created by Alex Rivas on 2/16/23.
//

import Foundation
import CoreLocation
import UIKit
class photohunttask{
    let title: String
    let desc:String
    var photo:UIImage?
    var photoloc:CLLocation?
    var taskcomplete:Bool{
        photo != nil
    }
    init(title: String, desc: String) {
        self.title = title
        self.desc = desc
    }
    func setphoto(image:UIImage,with loc:CLLocation){
        self.photo=image
        self.photoloc = loc
    }
}
extension photohunttask{
    static var phototask:[photohunttask]{
        return[
            photohunttask(title:"Go to a car muesum and take a photo", desc:"Go to a a car muesum and take a photo with yourself next to or in the cars "),
            photohunttask(title:"Go to a convention", desc:"Go to a convention and take a picture with someone")
        ]
    }
    
}
