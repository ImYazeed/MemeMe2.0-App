//
//  MemeCollectionViewController.swift
//  MemeMe2.0-App
//
//  Created by Yazeed ALZahrani on 1/28/19.
//  Copyright © 2019 Yazeedo. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var memes:[Meme]! {
        let sharedApp = UIApplication.shared
        let appDelegate = sharedApp.delegate as! AppDelegate
        return appDelegate.memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Calculate the Cell Size
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MemeCollectionViewCell
        cell.configure(meme: memes[(indexPath as NSIndexPath).row])
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Grab the memePreviwerVC from Storyboard
        let memePreviwerVC = self.storyboard!.instantiateViewController(withIdentifier: "memePreviewer") as! MemePreviewer
        
        //Populate view controller with data from the selected item
        memePreviwerVC.meme = memes[(indexPath as NSIndexPath).row]
        
        // Present the view controller using navigation
        navigationController!.pushViewController(memePreviwerVC, animated: true)
    }
    
    // MARK: ACTIONS
    
    @IBAction func addNewMeme(_ sender: Any) {
        
        guard let navController = storyboard?.instantiateViewController(withIdentifier: "newMemeNav") as? UINavigationController  else {return}
        present(navController, animated: true, completion: nil)
    }
    
}
