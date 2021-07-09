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
	@nonobjc public class func fetchRequest() -> NSFetchRequest<FeedCache> {
		return NSFetchRequest<FeedCache>(entityName: "FeedCache")
	}

	@NSManaged public var timeStamp: Date
	@NSManaged public var feedImages: NSOrderedSet?
}

// MARK: Generated accessors for feedImages
extension FeedCache {
	@objc(insertObject:inFeedImagesAtIndex:)
	@NSManaged public func insertIntoFeedImages(_ value: MOFeedImage, at idx: Int)

	@objc(removeObjectFromFeedImagesAtIndex:)
	@NSManaged public func removeFromFeedImages(at idx: Int)

	@objc(insertFeedImages:atIndexes:)
	@NSManaged public func insertIntoFeedImages(_ values: [MOFeedImage], at indexes: NSIndexSet)

	@objc(removeFeedImagesAtIndexes:)
	@NSManaged public func removeFromFeedImages(at indexes: NSIndexSet)

	@objc(replaceObjectInFeedImagesAtIndex:withObject:)
	@NSManaged public func replaceFeedImages(at idx: Int, with value: MOFeedImage)

	@objc(replaceFeedImagesAtIndexes:withFeedImages:)
	@NSManaged public func replaceFeedImages(at indexes: NSIndexSet, with values: [MOFeedImage])

	@objc(addFeedImagesObject:)
	@NSManaged public func addToFeedImages(_ value: MOFeedImage)

	@objc(removeFeedImagesObject:)
	@NSManaged public func removeFromFeedImages(_ value: MOFeedImage)

	@objc(addFeedImages:)
	@NSManaged public func addToFeedImages(_ values: NSOrderedSet)

	@objc(removeFeedImages:)
	@NSManaged public func removeFromFeedImages(_ values: NSOrderedSet)
}

extension FeedCache: Identifiable {}
