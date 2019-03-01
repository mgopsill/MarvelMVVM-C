//
//  ImageCacheTests.swift
//  MarvelMVVM-CTests
//
//  Created by Mike Gopsill on 26/02/2019.
//  Copyright © 2019 Mike Gopsill. All rights reserved.
//

import XCTest

@testable import MarvelMVVM_C

class ImageCacheTests: XCTestCase {

    var subject: ImageCacher!
    
    override func setUp() {
        subject = ImageCache.shared
    }

    override func tearDown() {
        subject = nil
    }

    func test_CachingImage_LoadingImage_Works() {
        let testImage = UIImage(data: CharacterImageServiceTests.mockImageData)!
        let testURL = URL(string: "test")!
        subject.cache(testImage, for: testURL)
        
        let cachedImage = subject.loadImage(for: testURL)
        
        XCTAssertEqual(testImage, cachedImage)
    }
}
