//
//  FeedCache+CoreDataProperties.swift
//  FeedStoreChallenge
//
//  Created by Константин Богданов on 09.07.2021.
//  Copyright © 2021 Essential Developer. All rights reserved.
//
//

import Foundation
import CoreData

extension FeedCache {
	@nonobjc class func fetchRequest() -> NSFetchRequest<FeedCache> {
		return NSFetchRequest<FeedCache>(entityName: "FeedCache")
	}

	@NSManaged var timeStamp: Date
	@NSManaged var feedImages: NSOrderedSet
}

// MARK: Generated accessors for feedImages
extension FeedCache {
	@objc(insertObject:inFeedImagesAtIndex:)
	@NSManaged func insertIntoFeedImages(_ value: MOFeedImage, at idx: Int)

	@objc(removeObjectFromFeedImagesAtIndex:)
	@NSManaged func removeFromFeedImages(at idx: Int)

	@objc(insertFeedImages:atIndexes:)
	@NSManaged func insertIntoFeedImages(_ values: [MOFeedImage], at indexes: NSIndexSet)

	@objc(removeFeedImagesAtIndexes:)
	@NSManaged func removeFromFeedImages(at indexes: NSIndexSet)

	@objc(replaceObjectInFeedImagesAtIndex:withObject:)
	@NSManaged func replaceFeedImages(at idx: Int, with value: MOFeedImage)

	@objc(replaceFeedImagesAtIndexes:withFeedImages:)
	@NSManaged func replaceFeedImages(at indexes: NSIndexSet, with values: [MOFeedImage])

	@objc(addFeedImagesObject:)
	@NSManaged func addToFeedImages(_ value: MOFeedImage)

	@objc(removeFeedImagesObject:)
	@NSManaged func removeFromFeedImages(_ value: MOFeedImage)

	@objc(addFeedImages:)
	@NSManaged func addToFeedImages(_ values: NSOrderedSet)

	@objc(removeFeedImages:)
	@NSManaged func removeFromFeedImages(_ values: NSOrderedSet)
}

extension FeedCache: Identifiable {}
