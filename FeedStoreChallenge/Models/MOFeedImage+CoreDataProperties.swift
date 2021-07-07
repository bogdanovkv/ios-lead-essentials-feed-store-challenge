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

	@NSManaged public var id: UUID?
	@NSManaged public var feedDescription: String?
	@NSManaged public var location: String?
	@NSManaged public var url: String?
}

extension MOFeedImage: Identifiable {}
