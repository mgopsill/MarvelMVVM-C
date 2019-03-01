//
//  ImageCache.swift
//  MarvelMVVM-C
//
//  Created by DevPair21 on 26/02/2019.
//  Copyright © 2019 Mike Gopsill. All rights reserved.
//

import UIKit

protocol ImageCacher {
    func cache(_ image: UIImage, for key: Foundation.URL)
    func loadImage(for key: Foundation.URL) -> UIImage?
}

class ImageCache: ImageCacher {
    
    private init() { }

    static let shared: ImageCacher = ImageCache()
    
    private let imageCache = NSCache<AnyObject, AnyObject>()
  
    func cache(_ image: UIImage, for key: Foundation.URL) {
        let imageToCache = image as AnyObject
        let key = key as AnyObject
        imageCache.setObject(imageToCache, forKey: key)
    }
    
    func loadImage(for key: Foundation.URL) -> UIImage? {
        return imageCache.object(forKey: key as AnyObject) as? UIImage
    }
}
