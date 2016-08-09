//
//  MemeModel.swift
//  MemeMe 1.0
//
//  Created by Jaemoon Park on 8/9/16.
//  Copyright © 2016 Jaemoon Park. All rights reserved.
//

import Foundation
import UIKit
struct MyMeme{
    var txtTop: String
    var txtBtm: String
    var imageOrig: UIImage
    var imageFinal: UIImage
    
    init(txtTop: String, txtBtm: String, imageOrig: UIImage, imageFinal:UIImage){
        self.txtTop = txtTop
        self.txtBtm = txtBtm
        self.imageOrig = imageOrig
        self.imageFinal = imageFinal
    }
    
}
