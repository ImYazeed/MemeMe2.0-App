//
//  MemeTableViewController.swift
//  MemeMe2.0-App
//
//  Created by Yazeed ALZahrani on 1/28/19.
//  Copyright © 2019 Yazeedo. All rights reserved.
//

import UIKit

class MemeTableViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    
    @IBAction func addNewMeme(_ sender: Any) {
        
        guard let navController = storyboard?.instantiateViewController(withIdentifier: "newMemeNav") as? UINavigationController  else {return}
        guard let memeEditor = navController.topViewController as? MemeEditorViewController else{return}
        memeEditor.cancelMode = .fromSavedMemes
        present(navController, animated: true, completion: nil)
    }
}
