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
			let request = NSFetchRequest<MOFeedImage>(entityName: "MOFeedImage")
			do {
				let result = try request.execute()
				let models = result.compactMap({ $0.feedImage() })
				if models.isEmpty {
					return completion(.empty)
				}
				completion(.found(feed: models, timestamp: result[0].timeStamp))
			} catch {
				completion(.failure(error))
			}
		}
	}
	
	public func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
		let currentContext = context
		currentContext.perform {
			feed.forEach { image in
				let _ = MOFeedImage.create(contex: self.context,
										   timeStamp: timestamp,
										   id: image.id,
										   description: image.description,
										   location: image.location,
										   url: image.url)
			}
			do {
				try currentContext.save()
				completion(nil)
			} catch {
				completion(error)
			}
		}
	}
	
	public func deleteCachedFeed(completion: @escaping DeletionCompletion) {
		fatalError("Must be implemented")
	}
}
