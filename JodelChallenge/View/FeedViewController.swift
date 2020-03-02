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
    var refreshControl = UIRefreshControl()
    
    var isFirstTime = true
    
    let jodelChallengeColor = UIColor(red: 246.0/255.0, green: 188.0/255.0, blue: 65.0/255.0, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPhotos(itemNumber: 20)
        loadRefreshControl()
        loadColors()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //LOAD NEW IMAGES WHEN ON BOTTOM
        let lastItem = photos.count-1
        if indexPath.row == lastItem {
            fetchPhotos(itemNumber: lastItem + 10)
            DispatchQueue.main.async(execute: {
                self.collectionView!.refreshControl!.endRefreshing()
            })
        }
        // ---_____--__-_-_-__-_-_-_-_-___-__------
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedCell", for: indexPath) as! FeedCell
        cell.configure(with: photos[indexPath.row])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedCell", for: indexPath) as! FeedCell
    }
    
    @objc func refresh(sender:AnyObject) {
        self.collectionView!.refreshControl!.beginRefreshing()
        fetchPhotos(itemNumber: 10)
    }
}

//CELL UI CONFIGURATION/DESIGN
extension FeedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 150);
    }
}

extension FeedViewController {
    func fetchPhotos(itemNumber: Int) {
        FlickrApi().fetchPhotosWithCompletion(isFirstTime: self.isFirstTime, items: itemNumber) { (photosFetched, error) in
            if error == nil {
                DispatchQueue.main.async(execute: {
                    ProgressHUD.showSuccess("Photos loaded")
                    self.photos = photosFetched!
                    self.collectionView.reloadData()
                })
            } else {
                ProgressHUD.showError("\(error!.localizedDescription)")
                self.collectionView!.refreshControl!.endRefreshing()
            }
            self.isFirstTime = false
            DispatchQueue.main.async(execute: {
                self.collectionView!.refreshControl!.endRefreshing()
            })
        }
    }
}

extension FeedViewController {
    func loadRefreshControl() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl.tintColor = .white
        self.collectionView!.alwaysBounceVertical = true
        self.refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        collectionView.refreshControl = refreshControl // iOS 10+
        self.collectionView!.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(self.refresh(sender:)), for: UIControl.Event.valueChanged)
    }
}

extension FeedViewController {
    func loadColors() {
        UITabBar.appearance().tintColor = jodelChallengeColor
        refreshControl.backgroundColor = jodelChallengeColor
    }
}
