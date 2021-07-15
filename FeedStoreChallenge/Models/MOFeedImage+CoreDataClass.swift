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
	                   id: UUID,
	                   description: String?,
	                   location: String?,
	                   url: URL) -> MOFeedImage {
		let image = MOFeedImage(context: contex)
		image.id = id
		image.imageDescription = description
		image.location = location
		image.url = url
		return image
	}
}
