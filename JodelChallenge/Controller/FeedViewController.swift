//
//  FeedViewController.swift
//  JodelChallenge
//
//  Created by Dmitry on 27/06/2019.
//  Copyright © 2019 Jodel. All rights reserved.
//

import UIKit

class FeedViewController : UICollectionViewController {
    
    private var photos: [Photo] = []
    private var refreshControl = UIRefreshControl()
    private var isFirstTime = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startLoad()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //LOAD NEW IMAGES WHEN ON BOTTOM
        let lastItem = photos.count-1
        
        if indexPath.row == lastItem {
            fetchPhotos(itemNumber: lastItem + 10, isScrollDown: true)
            DispatchQueue.main.async(execute: {
                self.collectionView!.refreshControl!.endRefreshing()
            })
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedCell", for: indexPath) as! FeedCell
        cell.configure(with: photos[indexPath.row])
        return cell
    }
    
    @objc func refresh(sender:AnyObject) {
        self.collectionView!.refreshControl!.beginRefreshing()
        fetchPhotos(itemNumber: 10, isScrollDown: false)
    }
}

extension FeedViewController {
    func startLoad() {
        loadRefreshControl()
        loadColors()
        fetchPhotos(itemNumber: 20, isScrollDown: false)
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
    func fetchPhotos(itemNumber: Int, isScrollDown: Bool) {
        
        FlickrAPIFetchController().fetchPhotosWithCompletion(isFirstTime: self.isFirstTime, isScrollDown: isScrollDown, items: itemNumber) { (photosFetched, error) in
            if error == nil {
                DispatchQueue.main.async(execute: {
                    self.photos = photosFetched!
                    self.collectionView.reloadData()
                })
            } else {
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
        let jodelChallengeColor = UIColor(red: 246.0/255.0, green: 188.0/255.0, blue: 65.0/255.0, alpha: 1.0)
        UITabBar.appearance().tintColor = jodelChallengeColor
        refreshControl.backgroundColor = jodelChallengeColor
    }
}
