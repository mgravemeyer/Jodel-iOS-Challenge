//
//  FlickrApi.swift
//  JodelChallenge
//
//  Created by Maximilian Gravemeyer on 27.02.20.
//  Copyright © 2020 Jodel. All rights reserved.
//

import Foundation

class FlickrApi {
    func fetchPhotosWithCompletion(completion: @escaping([Photo]?, Error?) -> ()) {
        var photos: [Photo] = []
        let fk = FlickrKit.shared()
        fk.initialize(withAPIKey: "92111faaf0ac50706da05a1df2e85d82", sharedSecret: "89ded1035d7ceb3a")
        
        let interesting = FKFlickrInterestingnessGetList()
        interesting.per_page = "10"
        interesting.page = "1"
        
        fk.call(interesting) { (response, error) -> Void in
            if let response = response, let photoArray = fk.photoArray(fromResponse: response) {
                for photoDictionary in photoArray {
                    //TODO: Avoid Force Unwrap
                    photos.append(Photo(
                        title: photoDictionary["title"]! as! String,
                        photoURL: fk.photoURL(for: FKPhotoSize.medium800, fromPhotoDictionary: photoDictionary)))
                }
                completion(photos, nil)
            } else if error != nil {
                completion(nil, error)
            }
        }
    }
}
