//
//  NetworkConstants.swift
//  Workday
//
//  Created by Nathan Smith on 12/6/22.
//

import Foundation

class NetworkConstants {
    static let urlStringRoot = "https://images-api.nasa.gov/"
    static let urlStringSearch = "search?q="
    static let urlStringImageType = "&media_type=image"
    static let urlStringPageNum = "&page="

    static func getUrlString(withSearchText text: String, pageNumber: String) -> String {
        return urlStringRoot + urlStringSearch + text + urlStringImageType + urlStringPageNum + pageNumber
    }
}
