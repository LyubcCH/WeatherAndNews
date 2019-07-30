//
//  News.swift
//  TheNewsApp
//
//  Created by Lyub Chibukhchian on 7/24/19.
//  Copyright © 2019 Lyub Chibukhchian. All rights reserved.
//

import Foundation


struct  MediaMetadataDetails: Decodable {
    let url: String
//    let format: String
//    let height: Int
//    let width: Int
}



struct MediaObject: Decodable {
//    let type: String
//    let subtype: String
//    let caption: String?
//    let copyright: String
//    let approved_for_syndication: Int
    let mediaMetadata: [MediaMetadataDetails]
    private enum CodingKeys: String, CodingKey {
        //case type, subtype, caption, copyright, approved_for_syndication
        case mediaMetadata = "media-metadata"
    }
    
}

struct Results: Decodable {
        let url: String
//      let adx_keywords: String
//      let column: String?
//      let section: String
//      let byline: String
//      let type: String
      let title: String
//      let abstract: String
      let published_date: String
//      let source: String
//      let id: Int
//      let asset_id: Int
//      let views: Int
//      let des_facet: [String]
//      let org_facet: [String]
//      let per_facet: [String]
//      let geo_facet: [String]
      let media: [MediaObject]
//      let uri: String
}

struct News: Decodable {
    let results: [Results]
//    let status: String
//    let copyright: String
//    let num_results: Int
}


