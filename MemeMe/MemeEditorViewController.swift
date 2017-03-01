//
//  MemeEditorViewController.swift
//  MemeMe
//
//  Created by Alp Eren Can on 16/08/15.
//  Copyright © 2015 Alp Eren Can. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    var meme: Meme?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextField(topTextField)
        setupTextField(bottomTextField)
        
        if meme != nil {
            self.topTextField.text = meme?.topText
            self.bottomTextField.text = meme?.bottomText
            self.imageView.image = meme?.originalImage
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
        
        shareButton.isEnabled = (imageView.image != nil) ? true : false
        
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        unsubscribeFromKeyboardNotifications()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    @IBAction func pickImageFromCamera(_ sender: AnyObject) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = UIImagePickerControllerSourceType.camera
        
        present(imagePickerController, animated: true, completion: nil)
    }

    @IBAction func pickImageFromAlbum(_ sender: AnyObject) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        present(imagePickerController, animated: true, completion: nil)
        
    }
    
    @IBAction func shareMeme(_ sender: AnyObject) {
        let memedImage = generateMemedImage()
        
        let activityController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        
        if (activityController.responds(to: #selector(getter: UIViewController.popoverPresentationController))) {
            activityController.popoverPresentationController?.barButtonItem = shareButton
        }
        
        present(activityController, animated: true, completion: nil)
        
        activityController.completionWithItemsHandler = {
            (activity, success, items, error) in
            self.save()
            self.dismissMemeEditor()
        }
    }
    
    @IBAction func cancelMeme(_ sender: UIBarButtonItem) {
        dismissMemeEditor()   
    }
    
    func dismissMemeEditor() {
        dismiss(animated: true, completion: nil)
    }
    
    func setupTextField(_ textField: UITextField) {
        textField.delegate = self
        
        let memeTextAttributes = [NSForegroundColorAttributeName: UIColor.white,
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeColorAttributeName: UIColor.black,
            NSStrokeWidthAttributeName: -3.0] as [String : Any]
        
        textField.defaultTextAttributes = memeTextAttributes
        
        textField.textAlignment = NSTextAlignment.center
    }
    
    func save() {
        
        if self.meme?.topText != topTextField.text ||
            self.meme?.bottomText != bottomTextField.text ||
            self.meme?.originalImage != imageView.image {
                
                let meme = Meme(topText: topTextField.text, bottomText: bottomTextField.text, originalImage: imageView.image, memedImage: generateMemedImage())
                
                (UIApplication.shared.delegate as! AppDelegate).memes.append(meme)
        }
        
    }
    
    func generateMemedImage() -> UIImage {
        
        topToolbar.isHidden = true
        bottomToolbar.isHidden = true
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        topToolbar.isHidden = false
        bottomToolbar.isHidden = false
        
        return memedImage!
    }
    
    func keyboardWillShow(_ notification: Notification) {
        // only shift if editing in bottomTextField
        if bottomTextField.isEditing {
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(_ notification: Notification) {
        // only shift back if editing in bottomTextField
        if bottomTextField.isEditing {
            view.frame.origin.y = 0
        }
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo;
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(MemeEditorViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(MemeEditorViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    // MARK: - UIImagePicker methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
            
            if picker.sourceType == UIImagePickerControllerSourceType.camera {
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            }
        }
        
        dismissImagePicker()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismissImagePicker()
    }
    
    func dismissImagePicker() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: UITextField methods
    
    var firstTimeEditingTop = true;
    var firstTimeEditingBottom = true;
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if (textField == topTextField && firstTimeEditingTop) {
            textField.text = ""
        }
        
        if (textField == bottomTextField && firstTimeEditingBottom) {
            textField.text = ""
        }
    
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField == topTextField && firstTimeEditingTop) {
            firstTimeEditingTop = false
        }
        
        if (textField == bottomTextField && firstTimeEditingBottom) {
            firstTimeEditingBottom = false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}

