//
//  PostsView.swift
//  try_car
//
//  Created by admin on 26/01/2023.
//

import SwiftUI

struct FavouriteView: View {
    @Environment(\.managedObjectContext) private var viewContext


    @FetchRequest(entity: Posts.entity(),   sortDescriptors: [NSSortDescriptor(keyPath: \Posts.id, ascending: true)], predicate: NSPredicate(format: "favourite == true"),animation: .default) var posts: FetchedResults<Posts>
    

    private func updatePost(_ post: Posts){
        post.favourite = !post.favourite
        
        do {
            try viewContext.save()
        } catch{
            print(error.localizedDescription)
        }
    }
    
    var body: some View {
        ZStack{
            VStack{
                NavigationView {
                        List {
                            ForEach(posts, id: \.self) { item in
                                NavigationLink {
                                    VStack{
                                        VStack{
                                            Image(systemName: item.favourite ? "heart.fill" : "heart")
                                                .foregroundColor(.red)
                                                .onTapGesture(perform: {
                                                    updatePost(item)
                                                })
                                            Spacer()
                                                .frame(height: 50)
                                            Text(item.title ?? "title")
                                            Text(item.body ?? "body")
                                            
                                        }
                                        .padding(20)
                                        
                                       
                                    }
                                } label: {
                                    VStack{
                                        HStack{
                                            
                                            
                                            Text(item.title ?? "title")
                                                .lineLimit(1)
                                            Text(item.body ?? "body")
                                                .lineLimit(2)
                                            Spacer()
                                            Image(systemName: item.favourite ? "heart.fill" : "heart")
                                                .foregroundColor(.red)
                                                .onTapGesture(perform: {
                                                    updatePost(item)
                                                })
                                        }
                                        
                                       
                                    }
                                  
                                }
                            }
                            
                        }
                    
                    
                }
            }
         
            
        }
    }
}

struct FavouriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
