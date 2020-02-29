//
//  FeedViewController.swift
//  JodelChallenge
//
//  Created by Dmitry on 27/06/2019.
//  Copyright © 2019 Jodel. All rights reserved.
//

import UIKit

class FeedViewController : UICollectionViewController {
    
    var photos: [Photo] = []
    
    var screenWidth = UIScreen.main.bounds.width
    
    var screenHeight = UIScreen.main.bounds.width
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let color = UIColor(red: 242.0/255.0, green: 157.0/255.0, blue: 58.0/255.0, alpha: 1.0)
        UITabBar.appearance().tintColor = color
        fetchPhotos()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedCell", for: indexPath) as! FeedCell
        cell.configure(with: photos[indexPath.row])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedCell", for: indexPath) as! FeedCell
    }
}

//CELL UI CONFIGURATION/DESIGN
extension FeedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screenWidth, height: 150);
    }
}


extension FeedViewController {
    func fetchPhotos() {
        FlickrApi().fetchPhotosWithCompletion { (photosFetched, error) in
            if error == nil {
                DispatchQueue.main.async(execute: {
                    ProgressHUD.showSuccess("Photos loaded")
                    self.photos = photosFetched!
                    self.collectionView?.reloadData()
                })
            } else {
                ProgressHUD.showError("\(error!.localizedDescription)")
            }
        }
    }
}
