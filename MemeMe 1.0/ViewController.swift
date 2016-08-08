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
    @IBOutlet weak var btnShare: UIBarButtonItem!
    @IBOutlet weak var txtFieldTop: UITextField!
    @IBOutlet weak var txtFieldBtm: UITextField!
    @IBOutlet weak var viewImage: UIImageView!

    override func viewDidLoad() {
        btnCamera.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        btnShare.enabled = false
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
    
    @IBAction func shareMeme(){
        //storing original bounds
        let boundOrigImage = viewImage.bounds
        let boundOrigTopTxt = txtFieldTop.bounds
        let boundOrigBtmTxt = txtFieldBtm.bounds
        
        //initializing and setting up bounds for meme capture
        viewImage.bounds = CGRect(x: 0.0, y: 0.0, width: viewImage.image!.size.width, height: viewImage.image!.size.height)
        txtFieldTop.bounds = CGRect(x: 0.0, y: 0.0, width: viewImage.image!.size.width, height: txtFieldTop.bounds.height)
        txtFieldBtm.bounds = CGRect(x: 0.0, y: viewImage.image!.size.height - txtFieldBtm.bounds.height, width: viewImage.image!.size.width, height: txtFieldBtm.bounds.height)
        
        //creating memed image
        UIGraphicsBeginImageContextWithOptions(viewImage.bounds.size, false, 1.0)
        viewImage.drawViewHierarchyInRect(viewImage.bounds, afterScreenUpdates: true)
        txtFieldTop.drawViewHierarchyInRect(txtFieldTop.bounds, afterScreenUpdates: true)
        txtFieldBtm.drawViewHierarchyInRect(txtFieldBtm.bounds, afterScreenUpdates: true)
        
        //creating and saving mememed image to variable
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //restoring original bounds
        viewImage.bounds = boundOrigImage
        txtFieldTop.bounds = boundOrigTopTxt
        txtFieldBtm.bounds = boundOrigBtmTxt
        
        //presenting activity view controller
        let activityView = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        self.presentViewController(activityView, animated: true, completion: nil)
        
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        viewImage.image = image
        dismissViewControllerAnimated(true, completion: nil)
        btnShare.enabled = true
        //makes sure textfields are visually accessible
        self.view.sendSubviewToBack(viewImage)
    }

}

