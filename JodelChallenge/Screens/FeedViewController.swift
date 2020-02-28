//
//  FeedViewController.swift
//  JodelChallenge
//
//  Created by Dmitry on 27/06/2019.
//  Copyright © 2019 Jodel. All rights reserved.
//

import UIKit

class FeedViewController : UICollectionViewController {
    
    var photos : [Photo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FlickrApi().fetchPhotosWithCompletion { (photosFetched, error) in
            if error == nil {
                DispatchQueue.main.async(execute: {
                    self.photos = photosFetched!
                    self.collectionView?.reloadData()
                })
            } else {
                print(error)
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedCell", for: indexPath) as! FeedCell
        cell.configure(with: photos[indexPath.row].photoURL)
        return cell
    }
    
}
