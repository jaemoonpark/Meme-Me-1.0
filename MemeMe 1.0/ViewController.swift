//
//  ViewController.swift
//  MemeMe 1.0
//
//  Created by Jaemoon Park on 8/8/16.
//  Copyright © 2016 Jaemoon Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var btnCamera: UIBarButtonItem!
    @IBOutlet weak var btnAlbum: UIBarButtonItem!
    @IBOutlet weak var viewImage: UIImageView!

    override func viewDidLoad() {
        btnCamera.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pickCamera(){
        let controllerCamera = UIImagePickerController()
        controllerCamera.sourceType = UIImagePickerControllerSourceType.Camera
        controllerCamera.delegate = self
        self.presentViewController(controllerCamera, animated: true, completion: nil)
    }
    
    @IBAction func pickAlbum(){
        let controllerAlbum = UIImagePickerController()
        controllerAlbum.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        controllerAlbum.delegate = self
        self.presentViewController(controllerAlbum, animated: true, completion: nil)
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        viewImage.image = image
        dismissViewControllerAnimated(true, completion: nil)
    }

}

