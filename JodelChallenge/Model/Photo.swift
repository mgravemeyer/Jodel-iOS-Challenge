//
//  Photo.swift
//  JodelChallenge
//
//  Created by Maximilian Gravemeyer on 28.02.20.
//  Copyright © 2020 Jodel. All rights reserved.
//

import Foundation

struct Photo {
    let title : String
    let photoURL : URL
}

class FlickrApi {
    
//    var photos = [Photo]()
    
//    func addPhoto(title:String, url:URL) {
//        photos.append(Photo(title: title, photoURL: url))
//    }

    
    func fetchPhotosWithCompletion(isFirstTime: Bool, items: Int, completion: @escaping([Photo]?, Error?) -> ()) {
        print("API CALL")
        if isFirstTime {
            ProgressHUD.show()
        }
        var photos: [Photo] = []
        let fk = FlickrKit.shared()
//        fk.initialize(withAPIKey: "92111faaf0ac50706da05a1df2e85d82", sharedSecret: "89ded1035d7ceb3a")
        fk.initialize(withAPIKey: "d98d5fc25542cc53878b288a16b8ac04", sharedSecret: "9b3ac820a2337018")
        let interesting = FKFlickrInterestingnessGetList()
        interesting.per_page = "10"
        interesting.page = "1"
        print(interesting)
        fk.call(interesting) { (response, error) -> Void in
            if let response = response, let photoArray = fk.photoArray(fromResponse: response) {
                print("Response is here")
                print(response)
                for photoDictionary in photoArray {
                    print(photoDictionary)
                    //TODO: Avoid Force Unwrap
                    photos.append(Photo(
                        title: photoDictionary["title"] as! String,
                        photoURL: fk.photoURL(for: FKPhotoSize.medium800, fromPhotoDictionary: photoDictionary)))
                }
                completion(photos, nil)
            } else if error != nil {
                completion(nil, error)
            }
        }
    }
}
