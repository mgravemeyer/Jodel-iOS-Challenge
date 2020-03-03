//
//  Photo.swift
//  JodelChallenge
//
//  Created by Maximilian Gravemeyer on 28.02.20.
//  Copyright © 2020 Jodel. All rights reserved.
//

import Foundation
    
    struct Photo {
        private var title : String
        private var photoURL : URL
        
        init(title: String, photoURL: URL) {
            self.title = title
            self.photoURL = photoURL
        }
        
        func getPhotoURL() -> URL {
            return self.photoURL
        }
        
        func getTitle() -> String {
            return self.title
        }
}
