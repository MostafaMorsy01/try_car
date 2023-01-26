//
//  PostsModel.swift
//  try_car
//
//  Created by admin on 26/01/2023.
//

import Foundation

// MARK: - PostsModelElement
struct PostsModelElement: Codable,Identifiable {
    let userID, id: Int?
    let title, body: String?

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}

typealias PostsModel = [PostsModelElement]
