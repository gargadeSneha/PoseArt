//
//  PoseArtModel.swift
//  GirlsPoses
//
//  Created by TryCatch Classes on 04/01/23.
//

import Foundation

// MARK: - PoseArtModel (category API)
struct CategoryModel: Codable {
    let id, catName: String
    let catImage: String

    enum CodingKeys: String, CodingKey {
        case id
        case catName = "cat_name"
        case catImage = "cat_image"
    }
}

typealias Category = [CategoryModel]



// MARK: - WelcomeElement (Tags API)
struct TagsModel: Codable {
    let id, tagName: String

    enum CodingKeys: String, CodingKey {
        case id
        case tagName = "tag_name"
    }
}

typealias Tags = [TagsModel]




// MARK: - WelcomeElement (Recent
struct RecentModel: Codable {
    let postID: String
    let postImage: String
    let tagName: String

    enum CodingKeys: String, CodingKey {
        case postID = "post_id"
        case postImage = "post_image"
        case tagName = "tag_name"
    }
}

typealias Recent = [RecentModel]


// MARK: - Welcome (Tags and post by category) (popular)
struct PopularModel: Codable {
    let posts: [Post]
    let tags: [Tag]
}

// MARK: - Post
struct Post: Codable {
    let id: String
    let postImage: String

    enum CodingKeys: String, CodingKey {
        case id
        case postImage = "post_image"
    }
}

// MARK: - Tag
struct Tag: Codable {
    let id, tagName: String

    enum CodingKeys: String, CodingKey {
        case id
        case tagName = "tag_name"
    }
}




// MARK: - Recent post by tags and catergory
struct TagsWithPose: Codable {
    let id: String
    let postImage: String

    enum CodingKeys: String, CodingKey {
        case id
        case postImage = "post_image"
    }
}

typealias Welcome = [TagsWithPose]

/*// MARK: - Single post
struct singlePost: Codable {
    let id: String
    let postImage: String

    enum CodingKeys: String, CodingKey {
        case id
        case postImage = "post_image"
    }
}
typealias PostImg = [singlePost]*/
