//
//  FlickrAPIController.swift
//  JodelChallenge
//
//  Created by Maximilian Gravemeyer on 03.03.20.
//  Copyright © 2020 Jodel. All rights reserved.
//

import Foundation

class FlickrAPIFetchController {
    
    private let flickrAPIKey    = "92111faaf0ac50706da05a1df2e85d82"
    private let flickrSharedSecret   = "89ded1035d7ceb3a"
    private let searchRangeKM   = 10

    func fetchPhotosWithCompletion(isFirstTime: Bool, isScrollDown: Bool, items: Int, completion: @escaping([Photo]?, Error?) -> ()) {
        
        let flickrAPIKey    = "92111faaf0ac50706da05a1df2e85d82"
        let flickrSharedSecret   = "89ded1035d7ceb3a"
        
        let fk = FlickrKit.shared()
        fk.initialize(withAPIKey: "\(flickrAPIKey)", sharedSecret: "\(flickrSharedSecret)")
        let interesting = FKFlickrInterestingnessGetList()
        interesting.per_page = "\(items)"
        interesting.page = "1"
        
        //LOAD LOADING INDICATOR WHEN APP STARTS FOR THE FIRST TIME
        if isFirstTime {
            ProgressHUD.show()
        }
        
        fk.call(interesting) { (response, error) -> Void in
            if let response = response, let photoArray = fk.photoArray(fromResponse: response) {
                var photos: [Photo] = []
                for photoDictionary in photoArray {
                    print(photoDictionary)
                    photos.append(Photo(
                        title: photoDictionary["title"] as! String,
                        url: fk.photoURL(for: FKPhotoSize.small240, fromPhotoDictionary: photoDictionary)))
                }
                //SHOW NOT SUCCESS WHEN USER SCROLLS DOWN
                if !isScrollDown {
                    ProgressHUD.showSuccess("Photos loaded")
                }
                completion(photos, nil)
            } else if error != nil {
                ProgressHUD.showError("\(error!.localizedDescription)")
                completion(nil, error)
            }
        }
    }
}
