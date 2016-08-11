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
    
    @IBOutlet weak var cnstrTopTxtTop: NSLayoutConstraint!
    @IBOutlet weak var cnstrTopTxtLeft: NSLayoutConstraint!
    @IBOutlet weak var cnstrTopTxtRight: NSLayoutConstraint!
    
    @IBOutlet weak var cnstrBtmTxtBtm: NSLayoutConstraint!
    @IBOutlet weak var cnstrBtmTxtLeft: NSLayoutConstraint!
    @IBOutlet weak var cnstrBtmTxtRight: NSLayoutConstraint!

    let txtAttributes = [NSStrokeColorAttributeName: UIColor.blackColor(), NSStrokeWidthAttributeName: -4.0, NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont.init(name: "HelveticaNeue-Bold", size: 50.0)!]
    
    override func viewDidLoad() {
        btnCamera.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        btnShare.enabled = false
        txtFieldTop.defaultTextAttributes = txtAttributes
        txtFieldBtm.defaultTextAttributes = txtAttributes
        txtFieldTop.textAlignment = NSTextAlignment.Center
        txtFieldBtm.textAlignment = NSTextAlignment.Center
        txtFieldTop.adjustsFontSizeToFitWidth = true
        txtFieldBtm.adjustsFontSizeToFitWidth = true
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
        //resigning first repsonder so textfield does not unintentionally re-adjust
        txtFieldTop.resignFirstResponder()
        txtFieldBtm.resignFirstResponder()
        
        //storing original constraints
        let cnstrOrigTopTxtTop = cnstrTopTxtTop
        let cnstrOrigTopTxtLeft = cnstrTopTxtLeft
        let cnstrOrigTopTxtRight = cnstrTopTxtRight
        let cnstrOrigBtmTxtBtm = cnstrBtmTxtBtm
        let cnstrOrigBtmTxtLeft = cnstrBtmTxtLeft
        let cnstrOrigBtmTxtRight = cnstrBtmTxtRight
        
        print(cnstrOrigBtmTxtLeft)
        //removing constraints so textfield can scale properly
        self.view.removeConstraint(cnstrTopTxtTop)
        self.view.removeConstraint(cnstrTopTxtLeft)
        self.view.removeConstraint(cnstrTopTxtRight)
        
        self.view.removeConstraint(cnstrBtmTxtBtm)
        self.view.removeConstraint(cnstrBtmTxtLeft)
        self.view.removeConstraint(cnstrBtmTxtRight)
        
        print(cnstrOrigBtmTxtLeft)
        
        //storing original bounds
        let boundOrigImage = viewImage.bounds
        let boundOrigTopTxt = txtFieldTop.bounds
        let boundOrigBtmTxt = txtFieldBtm.bounds
        
        print(txtFieldBtm.bounds)
        
        
        
        //initializing and setting up bounds for meme capture
        viewImage.bounds = CGRect(x: 0.0, y: 0.0, width: viewImage.image!.size.width, height: viewImage.image!.size.height)
        txtFieldTop.bounds = CGRect(x: 0.0, y: 0.0, width: viewImage.image!.size.width, height: txtFieldTop.bounds.height)
        txtFieldBtm.bounds = CGRect(x: 0.0, y: viewImage.image!.size.height - (viewImage.image!.size.height * 0.1157), width: viewImage.image!.size.width, height: txtFieldBtm.bounds.height)
        
        print(txtFieldBtm.bounds)

  
        txtFieldTop.font = UIFont.init(name: "HelveticaNeue-Bold", size: viewImage.image!.size.height * 0.1157)
        txtFieldBtm.font = UIFont.init(name: "HelveticaNeue-Bold", size: viewImage.image!.size.height * 0.1157)
        
        
        
        //creating memed image
        UIGraphicsBeginImageContextWithOptions(viewImage.bounds.size, false, 1.0)
        viewImage.drawViewHierarchyInRect(viewImage.bounds, afterScreenUpdates: true)
        txtFieldTop.drawViewHierarchyInRect(txtFieldTop.bounds, afterScreenUpdates: true)
        txtFieldBtm.drawViewHierarchyInRect(txtFieldBtm.bounds, afterScreenUpdates: true)
        
        
        //test label
//        var tempLabelTop = UILabel.init()
//        tempLabelTop.adjustsFontSizeToFitWidth = true
//        tempLabelTop.text = txtFieldTop.text
//        tempLabelTop.bounds = CGRect(x: 0.0, y: 0.0, width: viewImage.image!.size.width, height: viewImage.image!.size.height * 0.1157)
//        tempLabelTop.font = UIFont.init(name: "HelveticaNeue-Bold", size: viewImage.image!.size.height * 0.1157)
//        tempLabelTop.drawViewHierarchyInRect(tempLabelTop.bounds, afterScreenUpdates: true)
        
        //creating and saving mememed image to variable
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
        
        
        //restoring original bounds
        viewImage.bounds = boundOrigImage
        txtFieldTop.bounds = boundOrigTopTxt
        txtFieldBtm.bounds = boundOrigBtmTxt
        
        //restoring original constraints
        cnstrTopTxtTop = cnstrOrigTopTxtTop
        cnstrTopTxtLeft = cnstrOrigTopTxtLeft
        cnstrTopTxtRight = cnstrOrigTopTxtRight
        cnstrBtmTxtBtm = cnstrOrigBtmTxtBtm
        cnstrBtmTxtLeft = cnstrOrigBtmTxtLeft
        cnstrBtmTxtRight = cnstrOrigBtmTxtRight
        
        
        //reactivating constraints
        txtFieldTop.defaultTextAttributes = txtAttributes
        txtFieldBtm.defaultTextAttributes = txtAttributes
        
        txtFieldTop.textAlignment = NSTextAlignment.Center
        txtFieldBtm.textAlignment = NSTextAlignment.Center
        
        NSLayoutConstraint.activateConstraints([cnstrTopTxtTop, cnstrTopTxtLeft, cnstrTopTxtRight, cnstrBtmTxtBtm, cnstrBtmTxtLeft, cnstrBtmTxtRight])
        
        
        
        
        print(txtFieldBtm.bounds)
        
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

