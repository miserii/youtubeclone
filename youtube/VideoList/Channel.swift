//
//  ChannelModel.swift
//  youtube
//
//  Created by OsakaMiseri on 2021/04/16.
//

import Foundation

class Channel: Decodable {

    let items: [ChannelItem]

}

class ChannelItem: Decodable {

    let snippet: ChannelSnippet

}

class ChannelSnippet: Decodable {

    let thumbnails: Thumbnail

}
