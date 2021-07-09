//
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import CoreData

public final class CoreDataFeedStore: FeedStore {
	private static let modelName = "FeedStore"
	private static let model = NSManagedObjectModel(name: modelName, in: Bundle(for: CoreDataFeedStore.self))

	private let container: NSPersistentContainer
	private let context: NSManagedObjectContext

	struct ModelNotFound: Error {
		let modelName: String
	}

	public init(storeURL: URL) throws {
		guard let model = CoreDataFeedStore.model else {
			throw ModelNotFound(modelName: CoreDataFeedStore.modelName)
		}

		container = try NSPersistentContainer.load(
			name: CoreDataFeedStore.modelName,
			model: model,
			url: storeURL
		)
		context = container.newBackgroundContext()
	}

	public func retrieve(completion: @escaping RetrievalCompletion) {
		context.perform {
			let request = NSFetchRequest<FeedCache>(entityName: "FeedCache")
			do {
				guard let cache = try request.execute().first,
				      let images = cache.feedImages?.array as? [MOFeedImage] else {
					return completion(.empty)
				}

				if images.isEmpty {
					return completion(.empty)
				}
				completion(.found(feed: images.map({ $0.feedImage() }),
				                  timestamp: cache.timeStamp))
			} catch {
				completion(.failure(error))
			}
		}
	}

	public func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
		let currentContext = context
		currentContext.perform { [weak self] in
			guard let self = self else { return }
			let moImages = feed.map { image in
				return MOFeedImage.create(contex: self.context,
				                          timeStamp: timestamp,
				                          id: image.id,
				                          description: image.description,
				                          location: image.location,
				                          url: image.url)
			}
			let cache = self.getCache()
			cache.timeStamp = timestamp
			if let imagesSet = cache.feedImages {
				cache.removeFromFeedImages(imagesSet)
			}
			cache.addToFeedImages(NSOrderedSet(array: moImages))
			do {
				try currentContext.save()
				completion(nil)
			} catch {
				currentContext.rollback()
				completion(error)
			}
		}
	}

	public func deleteCachedFeed(completion: @escaping DeletionCompletion) {
		fatalError("Must be implemented")
	}
}

private extension CoreDataFeedStore {
	func getCache() -> FeedCache {
		let request = NSFetchRequest<FeedCache>(entityName: "FeedCache")
		var feedCache: FeedCache?
		context.performAndWait {
			if let cache = (try? request.execute())?.first {
				feedCache = cache
				return
			}
			feedCache = FeedCache(context: context)
		}
		return feedCache!
	}
}
