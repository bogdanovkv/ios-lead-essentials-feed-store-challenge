//
//  MOFeedImage+CoreDataProperties.swift
//  FeedStoreChallenge
//
//  Created by Константин Богданов on 07.07.2021.
//  Copyright © 2021 Essential Developer. All rights reserved.
//
//

import Foundation
import CoreData

extension MOFeedImage {
	@NSManaged var imageDescription: String?
	@NSManaged var id: UUID
	@NSManaged var location: String?
	@NSManaged var url: URL
}

extension MOFeedImage {
	func feedImage() -> LocalFeedImage {
		return .init(id: id,
		             description: imageDescription,
		             location: location,
		             url: url)
	}
}
