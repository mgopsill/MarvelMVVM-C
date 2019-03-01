//
//  CharacterResponseModel.swift
//  MarvelMVVM-C
//
//  Created by Mike Gopsill on 23/01/2019.
//  Copyright © 2019 Mike Gopsill. All rights reserved.
//

import Foundation

struct CharacterResponseModel: Codable {
    let data: DataClass
}

struct DataClass: Codable {
    let characters: [MarvelCharacter]
    
    enum CodingKeys: String, CodingKey {
        case characters = "results"
    }
}

struct MarvelCharacter: Codable {
    let name, description: String
    let thumbnail: Thumbnail
    let urls: [URL]
}

struct Thumbnail: Codable {
    let path: String
    let thumbnailExtension: Extension
    
    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

enum Extension: String, Codable {
    case jpg = "jpg"
}

struct URL: Codable {
    let type: URLType
    let url: String
}

enum URLType: String, Codable {
    case comiclink = "comiclink"
    case detail = "detail"
    case wiki = "wiki"
}

extension MarvelCharacter {
    var imageURL: Foundation.URL? {
        let urlString = String("\(thumbnail.path).\(thumbnail.thumbnailExtension.rawValue)")
        return Foundation.URL(string: urlString)
    }
    
    var descriptionURL: Foundation.URL? {
        let descriptionURL = urls.filter { $0.type == .detail }
        guard let urlString = descriptionURL.first?.url else { return nil }
        return Foundation.URL(string: urlString)
    }
}
