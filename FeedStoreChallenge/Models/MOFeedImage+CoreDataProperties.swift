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
	@nonobjc public class func fetchRequest() -> NSFetchRequest<MOFeedImage> {
		return NSFetchRequest<MOFeedImage>(entityName: "MOFeedImage")
	}

	@NSManaged public var feedDescription: String?
	@NSManaged public var id: UUID
	@NSManaged public var location: String?
	@NSManaged public var url: URL
	@NSManaged public var timeStamp: Date
}

extension MOFeedImage: Identifiable {}

extension MOFeedImage {
	func feedImage() -> LocalFeedImage {
		return .init(id: id,
		             description: feedDescription,
		             location: location,
		             url: url)
	}
}
