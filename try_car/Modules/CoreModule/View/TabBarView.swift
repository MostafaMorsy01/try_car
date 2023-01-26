//
//  TabBarView.swift
//  try_car
//
//  Created by admin on 26/01/2023.
//

import SwiftUI

struct TabBarView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var selection = 0
    var body: some View {
        TabView(selection: $selection){
            PostsView()
                .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
                .tabItem {
                    Image(systemName: "square.and.pencil")
                    Text("Post")
                }
                .tag(0)
            FavouriteView()
                .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
                .tabItem {
                    Image(systemName: "heart.circle")
                    Text("Favourite")
                }
                .tag(1)
            
        }
        .accentColor(.purple)
        .edgesIgnoringSafeArea(.top)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
