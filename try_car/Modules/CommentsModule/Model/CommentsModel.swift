//
//  CommentsModel.swift
//  try_car
//
//  Created by admin on 26/01/2023.
//

import Foundation

// MARK: - CommentsModelElement
struct CommentsModelElement: Codable {
    let postID, id: Int?
    let name, email, body: String?

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case id, name, email, body
    }
}

typealias CommentsModel = [CommentsModelElement]
