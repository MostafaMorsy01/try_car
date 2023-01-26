//
//  PostsView.swift
//  try_car
//
//  Created by admin on 26/01/2023.
//

import SwiftUI

struct PostsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject var postsVM = ViewModelPost()
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Posts.id, ascending: true)],
//        animation: .default)
    @FetchRequest(entity: Posts.entity(),   sortDescriptors: [NSSortDescriptor(keyPath: \Posts.id, ascending: true)],animation: .default) var posts: FetchedResults<Posts>
    
//    private var posts: FetchedResults<Posts>
    @State var isConnected: Bool = true
    @State var postId:Int?
    @State var title:String?
    @State var body1:String?
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
                    if postsVM.isConnected {
                        List {
                            ForEach(0..<(self.postsVM.publishedPostModel?.count ?? 0), id: \.self) { item in
                                NavigationLink {
                                    PostCommentView(postId: $postId, title: $title, body1: $body1).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
                                } label: {
                                    VStack{
                                        Text(postsVM.publishedPostModel?[item].title ?? "title")
                                        Text(postsVM.publishedPostModel?[item].body ?? "body")
                                    }.onAppear(perform: {
                                        postId = postsVM.publishedPostModel?[item].id ?? 0
                                        title = postsVM.publishedPostModel?[item].title ?? ""
                                        body1 = postsVM.publishedPostModel?[item].body ?? ""
                                    })
                                }
                            }
                            
                        }
                    } else {
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
            .onAppear(perform: {
                
                postsVM.startFetchHomeData()
                if self.postsVM.publishedPostModel != nil{
                    
                    
                    for item in self.postsVM.publishedPostModel! {
                        let newItem = Posts(context: viewContext)
                        
                        
                        
                        
                        newItem.title = item.title
                        newItem.body = item.body
                        print("all list")
                        print(posts)
                        
                        
                        do {
                            try viewContext.save()
                        } catch {
                            print("Error saving data",error.localizedDescription)
                        }
                        
                    }
                    
                    
                    
                    
                }
                
            })
            ActivityIndicatorView(isPresented: $postsVM.isLoading)
            // Alert with no internet connection
                .alert(isPresented: $postsVM.isAlert, content: {
                    Alert(title: Text(postsVM.message), message: nil, dismissButton: Alert.Button.default(Text("OK"), action: {
                        postsVM.isAlert = false
                    }))
                })
        }
    }
}

struct PostsView_Previews: PreviewProvider {
    static var previews: some View {
        PostsView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
