//
//  DisplayDish.swift
//  PrimoFiori
//
//  Created by Doug Wade on 3/1/24.
//

import SwiftUI

struct DisplayDish: View {
    @ObservedObject private var dish:Dish
    init(_ dish:Dish) {
        self.dish = dish
    }
    
    var body: some View {
        HStack{
            Text(dish.title ?? "")
                .padding([.top, .bottom], 7)

            Spacer()

            Text(dish.price ?? "")
                .monospaced()
                .font(.callout)
            
            Spacer()
            
            AsyncImage(url: URL(string: dish.image ?? "")) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 100, height: 100)
        }
        .contentShape(Rectangle())
    }
}

struct DisplayDish_Previews: PreviewProvider {
    static let context = PersistenceController.shared.container.viewContext
    let dish = Dish(context: context)
    static var previews: some View {
        DisplayDish(oneDish())
    }
    static func oneDish() -> Dish {
        let dish = Dish(context: context)
        dish.title = "Hummus"
        dish.price = "10"
        return dish
    }
}
