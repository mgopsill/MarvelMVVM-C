//
//  ImageService.swift
//  MarvelMVVM-C
//
//  Created by Mike Gopsill on 25/02/2019.
//  Copyright © 2019 Mike Gopsill. All rights reserved.
//

import UIKit

typealias ImageServiceCompletion = (_ image: UIImage?, _ error: Error?) -> Void

protocol ImageService {
    func fetchImage(request: URLRequest, completion: @escaping ImageServiceCompletion)
}
