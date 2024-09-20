import SwiftUI
import SwiftData
import PhotosUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @State private var selectedImage: UIImage?

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        VStack {
                            if let imageData = item.imageData, let uiImage = UIImage(data: imageData) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFit()  // Make sure the image maintains its aspect ratio
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)  // Fill the screen
                                    .ignoresSafeArea()  // Ensure the image takes the entire screen space
                            }
                            Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                        }
                    } label: {
                        HStack {
                            if let imageData = item.imageData, let uiImage = UIImage(data: imageData) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                            }
                            Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: { selectImage() }) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
                
                ToolbarItem {
                                   NavigationLink(destination: DetailScreen()) {
                                       Label("New Screen", systemImage: "star")
                                   }
                               }
            }
        } detail: {
            Text("Select an item")
        }
        .photosPicker(isPresented: $isImagePickerPresented, selection: $selectedImageItem)
        .onChange(of: selectedImageItem) { oldValue, newValue in
            if let newItem = newValue {
                loadImage(from: newItem)
            }
        }
    }

    @State private var isImagePickerPresented = false
    @State private var selectedImageItem: PhotosPickerItem?

    private func addItem(imageData: Data?) {
        withAnimation {
            let newItem = Item(timestamp: Date(), imageData: imageData)
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

    private func selectImage() {
        isImagePickerPresented = true
    }

    private func loadImage(from item: PhotosPickerItem) {
        item.loadTransferable(type: Data.self) { result in
            switch result {
            case .success(let data):
                if let data = data {
                    addItem(imageData: data)
                }
            case .failure(let error):
                print("Error loading image: \(error)")
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
