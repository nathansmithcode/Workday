//
//  NasaData.swift
//  Workday
//
//  Created by Nathan Smith on 12/6/22.
//

import Foundation

struct NasaData: Codable {
    
    var collection: Collection
    
    struct Collection: Codable {
        var version: String
        var items: [Item]
        var metadata: MetaData
    }
    
    struct MetaData: Codable {
        var total_hits: Int
    }
    
    struct Item: Codable {
        var href: String
        var data: [Data]
        var links: [Link]
        
        struct Data: Codable {
            var description: String
            var title: String
            var location: String?
            var nasa_id: String
            var date_created: String
        }
        
        struct Link: Codable {
            var href: String
        }
    }

    
}

