//
//  JodelChallengeTests.swift
//  JodelChallengeTests
//
//  Created by Michal Ciurus on 21/09/2017.
//  Copyright © 2017 Jodel. All rights reserved.
//

import XCTest
@testable import JodelChallenge

class JodelChallengeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        print("Test finished")
        super.tearDown()
    }
    
    func testFlickrAPICall() {
        let expectation = XCTestExpectation.init(description: "Should return Array of Photo with 20 photos, requires internet connection")
        
    FlickrAPIFetchController().fetchPhotosWithCompletion(isFirstTime: true, isScrollDown: false, items: 20) { (photoArray, error) in
            
            if error != nil {
                XCTFail("Fail: \(error.debugDescription)")
            }
        
            if photoArray == nil {
                XCTFail("Photo Array is empty")
            }
        
            if photoArray!.count == 20 {
                expectation.fulfill()
            }
        
        }
    }
    
    func testPhotoModel() {
        
        let expectation = XCTestExpectation.init(description: "Should return a String and a URL from the Photo object through the methods .title() and .url()")
        
        let photoModel = Photo(title: "testTitle", url: URL(string: "url")!)
        
        XCTAssertEqual(photoModel.getTitle(), String("testTitle"))
        XCTAssertEqual(photoModel.getURL(), URL(string: "url"))
        
        expectation.fulfill()
    }
}
