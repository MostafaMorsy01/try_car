//
//  ActivityIndicatorView.swift
//  El Rass
//
//  Created by admin on 16/08/2022.
//

import SwiftUI

struct ActivityIndicatorView: View {
    @Binding var isPresented:Bool?
    @State var loadingTitle : LoadingType?
     var body: some View {
         
        if isPresented ?? false{
            ZStack {
                ZStack{
   
                        ProgressView {
//                            Text(selecttype(yourType: loadingTitle ?? .none ) ?? "").font(.system(size: 10)).foregroundColor(.white)
//                                .font(.title2)
                        }
                        .frame(width: 120, height: 120)
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                        .scaleEffect(1.5 , anchor: .center)
                        .background(Color.black.opacity(0.55)).cornerRadius(20)
                    }
                    .background(Color.gray.opacity(0.1).blur(radius: 20))
                .edgesIgnoringSafeArea(.all)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity) // 1
//                .accentColor(Color.black)
                .background(Color.black.opacity(0.1))

            }
                   
    }
}

enum LoadingType {
    case loading, uploading, none
}
func selecttype(yourType: LoadingType) -> String? {
    switch yourType {
    case .loading:
        return "Loading..."
    case .uploading:
        return "Uploading..."
    case .none:
        return ""
    }
}
