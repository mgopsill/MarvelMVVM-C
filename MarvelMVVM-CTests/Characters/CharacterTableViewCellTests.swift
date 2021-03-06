//
//  CharacterTableViewCellTests.swift
//  MarvelMVVM-CTests
//
//  Created by DevPair21 on 22/02/2019.
//  Copyright © 2019 Mike Gopsill. All rights reserved.
//

import XCTest

@testable import MarvelMVVM_C

class CharacterTableViewCellTests: XCTestCase {
    
    var subject: CharacterTableViewCell!
    var mockCharacter: MarvelCharacter!
    
    override func setUp() {
        subject = CharacterTableViewCell(style: .default, reuseIdentifier: "test")
        
        let data = CharacterServiceTests.mockData
        let mockResponseModel = CharacterResponseModel.characterReponseModel(for: data)
        mockCharacter = mockResponseModel.data.characters[0]
    }
    
    override func tearDown() {
        subject = nil
    }
    
    func test_CellUpdatedWithResult_UpdatesName() {
        subject.update(with: mockCharacter)
        XCTAssertEqual(subject.title.text, mockCharacter.name)
    }
    
    func test_CellUpdatedWithResult_FetchesImage() {
        let mockImageService = MockImageService()
        subject.update(with: mockCharacter, imageService: mockImageService)
        XCTAssertTrue(mockImageService.fetchImageCalled)
    }
    
    func test_CellUpdatedWithResult_ImageFetched_UpdatesImageView() {
        let mockImageService = MockImageService()
        subject.update(with: mockCharacter, imageService: mockImageService)
        wait(for: [mockImageService.expectation], timeout: 0.5)
        XCTAssertNotNil(subject.characterImageView.image)
    }
}

class MockImageService: ImageService {
    
    var image: UIImage = UIImage(data: CharacterImageServiceTests.mockImageData)!
    var error: Error = TestError.test
    var expectation: XCTestExpectation = XCTestExpectation(description: #function)
    var fetchImageCalled: Bool = false
    
    func fetchImage(request: URLRequest, completion: @escaping ImageServiceCompletion) {
        fetchImageCalled = true
        completion(image, error)
        expectation.fulfill()
    }
}
