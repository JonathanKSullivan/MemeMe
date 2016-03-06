//
//  ViewController.swift
//  Meme Me
//
//  Created by Jonathan K Sullivan  on 1/26/16.
//  Copyright © 2016 Jonathan K Sullivan . All rights reserved.
//

import UIKit
struct Meme {
    var tText: String
    var bText: String
    var image: UIImage
    var memedImage: UIImage
}

class createMemeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet var topTextField: UITextField!
    @IBOutlet var bottomTextField: UITextField!
    @IBOutlet weak var photoAlbumButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.whiteColor(),
        NSForegroundColorAttributeName : UIColor.blackColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : -5.5
    ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        

        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        topTextField.textAlignment = NSTextAlignment.Center
        bottomTextField.textAlignment = NSTextAlignment.Center
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes
        topTextField.hidden = true
        bottomTextField.hidden = true
        topTextField.userInteractionEnabled = true
        bottomTextField.userInteractionEnabled = true
        topTextField.adjustsFontSizeToFitWidth = false
        bottomTextField.adjustsFontSizeToFitWidth = false
        topTextField.delegate = self
        bottomTextField.delegate = self
        self.subscribeToKeyboardNotifications()
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.items?.first?.enabled = false
        self.tabBarController?.tabBar.items?.last?.enabled = false
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.items?.first?.enabled = true
        self.tabBarController?.tabBar.items?.last?.enabled = true
        self.unsubscribeFromKeyboardNotifications()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func openImagePicker(sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    @IBAction func pickAnImageFromCamera (sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        topTextField.hidden = false
        bottomTextField.hidden = false
        photoAlbumButton.hidden = true
        cameraButton.hidden = true
        shareButton.hidden = false
        saveButton.hidden = true
        
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    @IBAction func shareAction(sender: AnyObject) {
        let image: UIImage = generateMemedImage()
        let activityPicker = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        self.presentViewController(activityPicker, animated: true, completion:nil)
    }
    @IBAction func saveAction(sender: UIButton) {
        let image: UIImage = generateMemedImage()
        self.save(image)
    }

    func imagePickerControllerDidCancel(picker: UIImagePickerController){
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]){
            if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
                mainImageView.image = pickedImage
                topTextField.hidden = false
                bottomTextField.hidden = false
                photoAlbumButton.hidden = true
                cameraButton.hidden = true
                print(mainImageView.frame.height * 3 / 8)
                shareButton.hidden = false
                saveButton.hidden = false
            }
            dismissViewControllerAnimated(true, completion: nil)
    }
    func keyboardWillShow(notification: NSNotification) {
        self.view.frame.origin.y -= getKeyboardHeight(notification)*1/4
        print(getKeyboardHeight(notification))
    }
    func keyboardWillHide(notification: NSNotification) {
        if bottomTextField.isFirstResponder() {
            self.view.frame.origin.y = 0
        }
    }
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "keyboardWillShow", object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "keyboardWillHide", object: nil)
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    func save(memedImage: UIImage) {
        saveButton.hidden = true
        //Create the meme
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        let meme = Meme( tText: topTextField.text!, bText: bottomTextField.text!, image: mainImageView.image!, memedImage: memedImage)
        appDelegate.memes.append(meme)
        
        // Add it to the memes array in the Application Delegate
    }
    func generateMemedImage() -> UIImage{
        // Render view to an image
        let bool1 = shareButton.hidden
        let bool2 = saveButton.hidden
        shareButton.hidden = true
        saveButton.hidden = true
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        shareButton.hidden = bool1
        saveButton.hidden = bool2
        return memedImage
    }
}

