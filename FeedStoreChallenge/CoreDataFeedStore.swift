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
			let request: NSFetchRequest<FeedCache> = FeedCache.fetchRequest()
			do {
				guard let cache = try request.execute().first,
				      let images = cache.feedImages.array as? [MOFeedImage],
				      !images.isEmpty else {
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
				                          id: image.id,
				                          description: image.description,
				                          location: image.location,
				                          url: image.url)
			}
			let cache = self.getCache()
			cache.timeStamp = timestamp
			cache.removeFromFeedImages(cache.feedImages)
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
		let request: NSFetchRequest<FeedCache> = FeedCache.fetchRequest()
		let currentContext = context
		currentContext.performAndWait {
			do {
				let caches = try request.execute()
				caches.forEach({ currentContext.delete($0) })
				try context.save()
				completion(nil)
			} catch {
				currentContext.rollback()
				completion(error)
			}
		}
	}
}

private extension CoreDataFeedStore {
	func getCache() -> FeedCache {
		let request: NSFetchRequest<FeedCache> = FeedCache.fetchRequest()
		if let cache = (try? request.execute())?.first {
			return cache
		}
		return FeedCache(context: context)
	}
}
