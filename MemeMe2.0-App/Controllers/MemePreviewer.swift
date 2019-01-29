//
//  MemePreviewer.swift
//  MemeMe2.0-App
//
//  Created by Yazeed ALZahrani on 1/28/19.
//  Copyright © 2019 Yazeedo. All rights reserved.
//

import UIKit

class MemePreviewer: UIViewController {
    
    @IBOutlet weak var memeImage: UIImageView!
    var meme: Meme!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let editButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(edit))
        navigationItem.rightBarButtonItem = editButton
        memeImage.image = meme.memedImage
    }
    
    @objc func edit() {
        guard let navController = storyboard?.instantiateViewController(withIdentifier: "newMemeNav") as? UINavigationController  else {return}
        guard let memeEditor = navController.topViewController as? MemeEditorViewController else{return}
        memeEditor.meme = meme
        present(navController, animated: true, completion: nil)
    }
   
}
