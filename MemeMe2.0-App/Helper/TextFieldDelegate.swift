//
//  TextFieldDelegate.swift
//  MemeMe2.0-App
//
//  Created by Yazeedo on 13/01/2019.
//  Copyright © 2019 Yazeedo. All rights reserved.
//

import UIKit

class TextFieldDelegate: NSObject,UITextFieldDelegate {
    
    let defaultTopText = "TOP"
    let defaultBottomText = "BOTTOM"
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if ((textField.tag == 0 && textField.text == defaultTopText) || (textField.tag == 1 && textField.text == defaultBottomText)) {
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

