//
//  MemeTableViewController.swift
//  MemeMe2.0-App
//
//  Created by Yazeed ALZahrani on 1/28/19.
//  Copyright © 2019 Yazeedo. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {
    
    var memes:[Meme]! {
        let sharedApp = UIApplication.shared
        let appDelegate = sharedApp.delegate as! AppDelegate
        return appDelegate.memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MemeTableViewCell
        cell.configure(meme: memes[(indexPath as NSIndexPath).row])
        return cell
        
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Grab the memePreviwerVC from Storyboard
        let memePreviwerVC = self.storyboard!.instantiateViewController(withIdentifier: "memePreviewer") as! MemePreviewer
        
        //Populate view controller with data from the selected item
        memePreviwerVC.meme = memes[(indexPath as NSIndexPath).row]
        
        // Present the view controller using navigation
        navigationController!.pushViewController(memePreviwerVC, animated: true)
        
    }
    
    @IBAction func addNewMeme(_ sender: Any) {
        
        guard let navController = storyboard?.instantiateViewController(withIdentifier: "newMemeNav") as? UINavigationController  else {return}
        guard let memeEditor = navController.topViewController as? MemeEditorViewController else{return}
        memeEditor.cancelMode = .fromSavedMemes
        present(navController, animated: true, completion: nil)
    }
}
