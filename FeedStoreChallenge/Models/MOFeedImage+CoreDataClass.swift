//
//  MOFeedImage+CoreDataClass.swift
//  FeedStoreChallenge
//
//  Created by Константин Богданов on 07.07.2021.
//  Copyright © 2021 Essential Developer. All rights reserved.
//
//

import Foundation
import CoreData

@objc(MOFeedImage)
public class MOFeedImage: NSManagedObject {
	static func create(contex: NSManagedObjectContext,
	                   timeStamp: Date,
	                   id: UUID,
	                   description: String?,
	                   location: String?,
	                   url: URL) -> MOFeedImage {
		let image = MOFeedImage(context: contex)
		image.timeStamp = timeStamp
		image.id = id
		image.feedDescription = description
		image.location = location
		image.url = url
		return image
	}
}
