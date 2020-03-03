//
//  Photo.swift
//  JodelChallenge
//
//  Created by Maximilian Gravemeyer on 28.02.20.
//  Copyright © 2020 Jodel. All rights reserved.
//

import Foundation
    
    struct Photo {
        private var title: String
        private var url: URL
        
        init(title: String, url: URL) {
            self.title = title
            self.url = url
        }
        
        func getURL() -> URL {
            return self.url
        }
        
        func getTitle() -> String {
            return self.title
        }
}
