//
//  ViewController.swift
//  MemeMe 1.0
//
//  Created by Jaemoon Park on 8/8/16.
//  Copyright © 2016 Jaemoon Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
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
    
    var shiftUp = false

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
        txtFieldTop.delegate = self
        txtFieldBtm.delegate = self
        self.subscribeToKeyboardNotification()
        
        //
        let select = UITapGestureRecognizer(target: self, action: "defocusShift")
        self.view.addGestureRecognizer(select)
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func defocusShift(){
        self.view.endEditing(true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //clears the default text
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField.text == "TOP" || textField.text == "BOTTOM"{
            textField.text = ""
        }
    }
    
    //dismiss keyboard when return is tapped
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
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
        
        //removing constraints so textfield can scale properly
        self.view.removeConstraint(cnstrTopTxtTop)
        self.view.removeConstraint(cnstrTopTxtLeft)
        self.view.removeConstraint(cnstrTopTxtRight)
        
        self.view.removeConstraint(cnstrBtmTxtBtm)
        self.view.removeConstraint(cnstrBtmTxtLeft)
        self.view.removeConstraint(cnstrBtmTxtRight)
        
        
        //storing original bounds
        let boundOrigImage = viewImage.bounds
        let boundOrigTopTxt = txtFieldTop.bounds
        let boundOrigBtmTxt = txtFieldBtm.bounds
        
        
        
        
        //initializing and setting up bounds for meme capture
        viewImage.bounds = CGRect(x: 0.0, y: 0.0, width: viewImage.image!.size.width, height: viewImage.image!.size.height)
        txtFieldTop.bounds = CGRect(x: 0.0, y: 0.0, width: viewImage.image!.size.width, height: txtFieldTop.bounds.height)
        txtFieldBtm.bounds = CGRect(x: 0.0, y: viewImage.image!.size.height - (viewImage.image!.size.height * 0.1157), width: viewImage.image!.size.width, height: txtFieldBtm.bounds.height)
        txtFieldBtm.minimumFontSize = viewImage.image!.size.height * 0.1157

        
        txtFieldTop.font = UIFont.init(name: "HelveticaNeue-Bold", size: viewImage.image!.size.height * 0.1157)
        txtFieldBtm.font = UIFont.init(name: "HelveticaNeue-Bold", size: viewImage.image!.size.height * 0.1157)
        
        txtFieldTop.textAlignment = NSTextAlignment.Center
        txtFieldBtm.textAlignment = NSTextAlignment.Center
        
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
        
        //restoring original text alignment
        txtFieldTop.textAlignment = NSTextAlignment.Center
        txtFieldBtm.textAlignment = NSTextAlignment.Center
        
        NSLayoutConstraint.activateConstraints([cnstrTopTxtTop, cnstrTopTxtLeft, cnstrTopTxtRight, cnstrBtmTxtBtm, cnstrBtmTxtLeft, cnstrBtmTxtRight])
        
        

        
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
    
    func subscribeToKeyboardNotification(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "showKeyboard:", name: UIKeyboardWillShowNotification, object: nil)
    }
    
    func showKeyboard(notification: NSNotification){
        if(!shiftUp){
            self.view.frame.origin.y -= getKeyboardHeight(notification)
            shiftUp = true
        }
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat{
        print("pie2.0")
        let userInfo = notification.userInfo
        let keyboardInfo = userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue
        return keyboardInfo.CGRectValue().height
    }
    
    
    

}

