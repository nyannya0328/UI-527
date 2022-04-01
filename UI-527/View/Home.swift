//
//  Home.swift
//  UI-527
//
//  Created by nyannyan0328 on 2022/04/01.
//

import SwiftUI

struct Home: View {
    @State var posts : [Post] = []
    @State var currentIndex : Int = 0
    
    @State var currentTitle : String = "Slide Now"
    
    @Namespace var animation
    var body: some View {
        VStack{
            
            
            VStack(alignment: .leading, spacing: 14) {
                
                Button {
                    
                } label: {
                    Label {
                        
                        Text("My Wishes")
                            .font(.callout)
                        
                    } icon: {
                        
                        Image(systemName: "chevron.left")
                            .font(.title)
                    }
                    
                }
                .foregroundColor(.primary)

                Text("My Wishes")
                    .font(.largeTitle.weight(.black))

            }
            .frame(maxWidth:.infinity,alignment: .leading)
            
            
            TopBar()
                .padding(.top,20)
            
            
            SnapCrouselView(index: $currentIndex, items: posts) { post in
                
                
                GeometryReader{proxy in
                    
                    let size = proxy.size
                    
                    Image(post.postImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width)
                        .cornerRadius(15)
                    
                    
                }
            }
            .padding(.vertical,50)
            
            
            
            CustomIndicator()
            
            
            
        }
        .padding()
        .frame(maxHeight: .infinity,alignment: .top)
        .onAppear {
            
            for index in 1...7{
                
                posts.append(Post(postImage: "Movie\(index)"))
            }
        }
    }
    @ViewBuilder
    func TopBar()->some View{
        
        HStack(spacing:20){
            
            ForEach(["Slide Now","List"],id:\.self){title in
                
                Button {
                    withAnimation{
                        
                        currentTitle = title
                    }
                } label: {
                    Text(title)
                        .font(.title.weight(.light))
                        .foregroundColor(.white)
                        .frame(maxWidth:.infinity)
                        .padding(.vertical,10)
                        .background{
                            
                            
                            if currentTitle == title{
                                
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.black.opacity(0.5))
                                    .matchedGeometryEffect(id: "TAB", in: animation)
                                   
                                    
                            }
                            
                            
                        }
                        .cornerRadius(10)
                }

                
            }
        }
        .background(.gray)
        
        
    }
    
    @ViewBuilder
    func CustomIndicator()->some View{
        
        
        HStack(spacing:20){
            
            ForEach(posts.indices,id:\.self){post in
                
                Circle()
                    .fill(currentIndex == post ? .orange : .black)
                    .frame(width: 20, height: 20)
                    .scaleEffect(currentIndex == post ? 1.5 : 1)
                    .animation(.easeInOut, value: currentIndex)
            }
        }
        
        
    }
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
