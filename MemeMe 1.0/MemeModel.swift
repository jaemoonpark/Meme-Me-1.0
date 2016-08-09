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
    var textTop: String
    var textBtm: String
    var imageOrig: UIImage
    var imageFinal: UIImage
    
    init(textTop: String, textBtm: String, imageOrig: UIImage, imageFinal:UIImage){
        self.textTop = textTop
        self.textBtm = textBtm
        self.imageOrig = imageOrig
        self.imageFinal = imageFinal
    }
    
}
