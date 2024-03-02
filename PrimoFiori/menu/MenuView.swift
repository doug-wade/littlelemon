//
//  MenuView.swift
//  PrimoFiori
//
//  Created by Doug Wade on 2/29/24.
//

import SwiftUI
import CoreData

struct MenuView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @State private var searchText = ""
    @State private var showAlert = false
    @State private var menuItems: [MenuItem] = []
    
    func buildPredicate() -> NSPredicate {
        if searchText == "" {
            return NSPredicate(value: true)
        }
        return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
    }
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [
            NSSortDescriptor(
                key: "title",
                ascending: true,
                selector: #selector(NSString.localizedCompare(_:))
            )
        ]
    }
    
    func getMenuData() {
        PersistenceController.shared.clear()
        let urlString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        let urlSession = URLSession.shared
        
        let task = urlSession.dataTask(with: request) { data, response, error in
            if let unwrapped = data {
                let fullMenu = try? JSONDecoder().decode(
                    MenuList.self,
                    from: unwrapped
                )
                menuItems = fullMenu?.menu ?? []
            } else {
                menuItems = []
            }
            
            
            for menuItem in menuItems {
                let dish = Dish(context: viewContext)
                dish.price = menuItem.price
                dish.image = menuItem.image
                dish.title = menuItem.title
            }
            
            try? viewContext.save()
        }
        
        task.resume()
    }

    var body: some View {
        NavigationView {
            VStack {
                Text("Primo Fiori")
                Text("Location")
                Text("A short description?")
                FetchedObjects(
                    predicate: buildPredicate(),
                    sortDescriptors: buildSortDescriptors()) {
                        (dishes: [Dish]) in
                        List {
                            ForEach(dishes, id:\.self) { dish in
                                DisplayDish(dish)
                                    .onTapGesture {
                                        showAlert.toggle()
                                    }
                            }
                        }
                        .searchable(text: $searchText,
                                    prompt: "search...")
                    }
            }
            .onAppear() {
                getMenuData()
            }
        }
    }
}

#Preview {
    MenuView()
}
