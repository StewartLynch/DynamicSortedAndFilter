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

@main
struct DynamicSortAndFilterApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Book.self)
                .onAppear {
                    print(URL.applicationSupportDirectory.path(percentEncoded: false))
                }
                
        }
    }
}
