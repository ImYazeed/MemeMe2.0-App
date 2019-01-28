//
//  ViewController.swift
//  MemeMe2.0-App
//
//  Created by Yazeedo on 13/01/2019.
//  Copyright © 2019 Yazeedo. All rights reserved.
//


import UIKit

class MemeEditorViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    // enum variable to handle the Cancel Action to detrmine weather dismiss the VC or delete the image
    
    enum CancelModeEnum {
       case fromFirstLunch , fromSavedMemes
    }
   
    // Outlet
    @IBOutlet weak var originalImage: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var importButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var toolBar: UIToolbar!
    
    // Helpers
    let textField_Delegate = TextFieldDelegate()
    
    //cancel Mode
    var cancelMode: CancelModeEnum = CancelModeEnum.fromFirstLunch
    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth: -3
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBarItems()
        configureTextFields(textField: topTextField)
        configureTextFields(textField: bottomTextField)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    
    // MARK: ACTIONS
    
    @IBAction func pickAnImageAlbum(_ sender: Any) {
        createImagePickerView(withSourceType: .photoLibrary)
    }
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        createImagePickerView(withSourceType: .camera)
    }
    
    @IBAction func shareMeme(_ sender: Any) {
        let memedImage = generateMemedImage()
        let activityViewVC = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        
        activityViewVC.completionWithItemsHandler = { (activityType, completed, returnedItems, activityError) -> () in
            if completed {
                self.save()
                self.dismiss(animated: true, completion: nil)
            }
        }
        
        present(activityViewVC, animated: true, completion: nil)
        
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        if originalImage.image == nil {
            dismiss(animated: true, completion: nil)
        }
        else{
        originalImage.image = nil
        configureNavigationBarItems()
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        }
    }
    
    // MARK: imagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            originalImage.image = image
            configureNavigationBarItems()
            imagePickerControllerDidCancel(picker)
            
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func createImagePickerView(withSourceType sourceType:UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: Element Configuration
    
    func configureNavigationBarItems() {
        importButton.isEnabled = (originalImage.image != nil)
        //cancelButton.isEnabled = (originalImage.image != nil)
    }
    
    func configureBars(_ isHidden: Bool) {
        navigationController?.navigationBar.isHidden = isHidden
        toolBar.isHidden = isHidden
    }
    
    func configureTextFields(textField: UITextField){
        textField.delegate = textField_Delegate
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
    }
    
    // MARK: Meme image
    
    func generateMemedImage() -> UIImage {
        
        // Hide NavBar and ToolBar
        configureBars(true)
        
        // Render view to an image
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawHierarchy(in: view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // reShow NavBar and ToolBar
        configureBars(false)
        
        return memedImage
    }
    
    func save() {
        // Create the meme
        let memedImage:UIImage = generateMemedImage()
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: originalImage.image!, memedImage: memedImage)
        
        // Add it to the memmes Array on the app delegate
        (UIApplication.shared.delegate as! AppDelegate).memes.append(meme)
        
    }
    
    // MARK: KEYBOARD MOVMENT
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        
        if bottomTextField.isEditing && view.frame.origin.y == 0 {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
        
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    
}


