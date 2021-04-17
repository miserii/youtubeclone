//
//  VideoModel.swift
//  youtube
//
//  Created by OsakaMiseri on 2021/04/13.
//

import Foundation

struct Video: Decodable {

    let kind: String
    let items: [Item]

}

struct Item: Decodable {

    var channel: Channel?
    let snippet: Snippet

}

struct Snippet: Decodable {

    let publishedAt: String
    let channelId: String
    let title: String
    let description: String
    let thumbnails: Thumbnail

}

struct Thumbnail: Decodable {

    let medium: ThumbnailInfo
    let high: ThumbnailInfo

}

struct ThumbnailInfo: Decodable {

    let url: String
    let width: Int?
    let height: Int?

}
