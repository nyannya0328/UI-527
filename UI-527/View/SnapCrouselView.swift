//
//  SnapCrouselView.swift
//  UI-527
//
//  Created by nyannyan0328 on 2022/04/01.
//

import SwiftUI

struct SnapCrouselView<Content : View,T : Identifiable>: View {
    
    var content : (T) -> Content
    var list : [T]
    var spacing : CGFloat
    var trailginSpace : CGFloat
    @Binding var index : Int
    
    
    init(spacing : CGFloat = 15,trailginSpace : CGFloat = 100,index : Binding<Int>,items : [T],@ViewBuilder content : @escaping(T) -> Content) {
        
        self.spacing = spacing
        self.trailginSpace = trailginSpace
        self._index = index
        self.list = items
        self.content = content
    }
    
    @GestureState var offset : CGFloat = 0
    @State var currentIndex : Int = 0
    
    
    var body: some View {
        GeometryReader{proxy in
            
            let width = proxy.size.width - (trailginSpace - spacing)
            
            let adustMentWidth = (trailginSpace / 2) - spacing
            HStack(spacing:spacing){
                
                ForEach(list){item in
                    
                    content(item)
                        .frame(width: proxy.size.width - trailginSpace)
                }
            }
            .padding(.horizontal,spacing)
            .offset(x: (CGFloat(currentIndex) * -width) + (currentIndex != 0 ? adustMentWidth : 0) + offset)
            .gesture(
            
                DragGesture().updating($offset, body: { value, out, _ in
                    out = value.translation.width
                })
                .onEnded({ value in
                    
                    let offsetX = value.translation.width
                    let progress = -offsetX / width
                    let roundIndex = progress.rounded()
                    
                    currentIndex = max( min(currentIndex + Int(roundIndex), list.count - 1), 0)
                    
                   currentIndex = index
                    
                    
                })
                .onChanged({ value in
                    
                    
                    
                    let offsetX = value.translation.width
                    let progress = -offsetX / width
                    let roundIndex = progress.rounded()
                    
                    index = max( min(currentIndex + Int(roundIndex), list.count - 1), 0)
                    
                 
                })
            
            )
            
        }
        .animation(.spring(), value: offset == 0)
    }
}

struct SnapCrouselView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
