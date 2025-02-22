//
//  ContentView.swift
//  Test
//
//  Created by Erich Kumpunen on 4/10/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    var body: some View {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        ZStack {
                            Color.green
                            Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                                .setNavToolbar(leading: {
                                    Image(systemName: "chevron.left")
                                        .foregroundStyle(Color.green)
                                        .offset(x: -95)
                                }, trailing: { EmptyView() })
                        }
                    } label: {
                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .setFullNav(navTitle: "I am a title") {
                Image(systemName: "x.circle")
            } trailingView: {
                HStack {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                    .tint(.green)

                    EditButton()
                        .tint(.green)
                }
            }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
