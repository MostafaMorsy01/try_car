//
//  PostCommentView.swift
//  try_car
//
//  Created by admin on 26/01/2023.
//

import SwiftUI

struct PostCommentView: View {
    @StateObject var commentsVM = ViewModelComment()
    @Environment(\.managedObjectContext) var viewContext
//    @FetchRequest(entity: Posts.entity(), sortDescriptors: []) var myObjects: FetchedResults<Posts>
    @Binding var postId: Int?
    @Binding var title: String?
    @Binding var body1: String?
//    @Binding var isFav: Bool?
    
    
        private func addItem() {
            withAnimation {
                let newItem = Posts(context: viewContext)
                newItem.favourite = true
    
                do {
                    try viewContext.save()
                } catch {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.localizedDescription)")
                }
            }
        }
    
    var body: some View {
        ZStack{
            VStack{
                
                HStack{
                    


                    Spacer()
                    VStack{
                        Text(title ?? "")
                        Text(body1 ?? "")
                    }
                }
               
               
                Spacer()
                List {
                    ForEach(0..<(self.commentsVM.publishedPostModel?.count ?? 0), id: \.self) { item in
                        NavigationLink {
//                            PostCommentView(postId: $postId, title: $title, body1: $body1)
                        } label: {
                            VStack{
                                Text(commentsVM.publishedPostModel?[item].name ?? "name")
                                Text(commentsVM.publishedPostModel?[item].email ?? "email")
                                Text(commentsVM.publishedPostModel?[item].body ?? "body")
                            }
                        }
                    }
                    
                }
                
            }
            .onAppear(perform: {
                commentsVM.postId = postId
                
                commentsVM.startFetchHomeData()
               
                
            })
            ActivityIndicatorView(isPresented: $commentsVM.isLoading)
            // Alert with no internet connection
                .alert(isPresented: $commentsVM.isAlert, content: {
                    Alert(title: Text(commentsVM.message), message: nil, dismissButton: Alert.Button.default(Text("OK"), action: {
                        commentsVM.isAlert = false
                    }))
                })
        }
    }
}


