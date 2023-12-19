//
// Created for DynamicSortAndFilter
// by  Stewart Lynch on 2023-12-18
//
// Follow me on Mastodon: @StewartLynch@iosdev.space
// Follow me on Threads: @StewartLynch (https://www.threads.net)
// Follow me on X: https://x.com/StewartLynch
// Subscribe on YouTube: https://youTube.com/@StewartLynch
// Buy me a ko-fi:  https://ko-fi.com/StewartLynch


import Foundation
import SwiftData

@Model
class Book: Identifiable {
    init(title: String, author: String) {
        self.title = title
        self.author = author
    }
    var title: String
    var author: String
}


struct BookSeed: Codable {
    let title: String
    let author: String
}

extension Book {
    @MainActor
    static var preview: ModelContainer {
        do {
            let container = try ModelContainer(for: Book.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
            let seedBooks = Bundle.main.decode([BookSeed].self, from: "Seed.json")
            for book in seedBooks {
                let newBook = Book(title: book.title, author: book.author)
                container.mainContext.insert(newBook)
            }
            return container
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
