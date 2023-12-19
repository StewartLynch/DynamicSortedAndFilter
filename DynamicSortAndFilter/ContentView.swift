//
// Created for DynamicSortAndFilter
// by  Stewart Lynch on 2023-12-18
//
// Follow me on Mastodon: @StewartLynch@iosdev.space
// Follow me on Threads: @StewartLynch (https://www.threads.net)
// Follow me on X: https://x.com/StewartLynch
// Subscribe on YouTube: https://youTube.com/@StewartLynch
// Buy me a ko-fi:  https://ko-fi.com/StewartLynch



import SwiftUI
import SwiftData

enum SortOption: String, Identifiable, CaseIterable {
    case title, author
    var id: String {
        self.rawValue
    }
}

struct ContentView: View {
    @State private var sortOption: SortOption = .author
    @State private var filterText = ""
    @Environment(\.modelContext) private var context
    var body: some View {
        NavigationStack {
            VStack {
                Picker("", selection: $sortOption) {
                    ForEach(SortOption.allCases) { option in
                        Text(option.rawValue).tag(option)
                    }
                }
                .pickerStyle(.segmented)
                BookListView(sortOption: sortOption, filterText: filterText)
                    .searchable(text: $filterText)
            }
            .navigationTitle("Books")
        }
    }
}

struct BookListView: View {
    @Query private var books: [Book]
    init(sortOption: SortOption, filterText: String) {
        let predicate = #Predicate<Book> { book in
            book.title.localizedStandardContains(filterText)
            || book.author.localizedStandardContains(filterText)
            || filterText.isEmpty
        }
        switch sortOption {
            case .title:
            _books = Query(filter: predicate, sort: \.title)
            case .author:
            _books = Query(filter: predicate, sort: \.author)
        }

    }
    var body: some View {
        List {
            ForEach(books) { book in
                VStack(alignment: .leading) {
                    Text(book.title)
                    Text(book.author)
                }
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    ContentView()
        .modelContainer(Book.preview) 
}
