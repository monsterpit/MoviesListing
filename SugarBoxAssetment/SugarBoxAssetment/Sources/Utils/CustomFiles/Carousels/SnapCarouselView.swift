//
//  SnapCarouselView.swift
//  SugarBoxAssetment
//
//  Created by Vikas Salian on 06/12/23.
//

import SwiftUI

struct SnapCarouselView<Content: View,T: Identifiable>: View {
    var content: (T) -> Content
    var list: [T]
    
    var spacing: CGFloat
    var trailingSpace: CGFloat
    
    @Binding var index: Int
    //Offset
    @GestureState var offSet: CGFloat = 0
    @State var currentIndex = 0
    @State var showIndicator = false
    @State private var carouselHeight: CGFloat = 0
    @State private var totalHeight = CGFloat(0)
    @State private var indicatorSelectedColor: Color
    @State private var indicatorUnSelectedColor: Color
    
    var body: some View {
        VStack{
            GeometryReader{ proxy in
                //Setting correct width for carousel
                //One Sided Snap Carousel
                let width = (proxy.size.width - (trailingSpace - spacing))
                
                let adjustmentWidth = (trailingSpace / 2) - spacing
                HStack(spacing: spacing){
                    
                    ForEach(list){item in
                        
                        content(item)
                            .frame(width: proxy.size.width - trailingSpace <= 0 ? 0 : proxy.size.width - trailingSpace)
                    }
                }
                //Spacing will be horizontal padding ....
                .padding(.horizontal,spacing)
                //Setting only for last element so we can have 2 elements on last
                .offset(x: (CGFloat(currentIndex) * -width) + ( currentIndex == list.count - 1 ? adjustmentWidth : 0) + offSet)
                .gesture(
                    DragGesture()
                        .updating($offSet, body: { value, out, _ in
                            out = value.translation.width
                        })
                        .onEnded({ value in
                            //Updating Current Index ...
                            let offsetX = value.translation.width
                            
                            //we are going to convert the translation into progress (0-1)
                            //and round the value based on the progress increasing or decreasing the currentIndex
                            
                            let progress = -offsetX / width
                            
                            let roundIndex = progress.rounded()
                            
                            //setting currentIndex
                            currentIndex = max(min(currentIndex + Int(roundIndex),list.count - 1),0)
                            
                        })
                        .onChanged({ value in
                            
                            let offsetX = value.translation.width
                            
                            let progress = -offsetX / width
                            
                            let roundIndex = progress.rounded()
                            
                            //Setting Index
                            index = max(min(currentIndex + Int(roundIndex),list.count - 1),0)
                        })
                    
                )
                //Animating when offset = 0
                .animation(.easeOut,value: offSet == 0)
            }
            .frame(height: carouselHeight)
            
            if showIndicator{
                HStack(spacing: 10){
                    ForEach(list.indices,id: \.self){index in
                        Circle()
                            .fill(currentIndex == index ? indicatorSelectedColor : indicatorUnSelectedColor)
                            .frame(width: 5,height: 5) //Info Indicator size
                            .scaleEffect(currentIndex == index ? 1.4 : 1)
                            .animation(.spring(), value: currentIndex == index)
                    }
                }
                .padding(.vertical,5)
            }
            
        }
        
    }
    
    init(spacing: CGFloat = 15,
         trailingSpace: CGFloat = 100,
         index: Binding<Int>,
         items: [T],
         showIndicator: Bool = false,
         carouselHeight: CGFloat = 200,
         indicatorSelectedColor: Color = .colorSecondary,
         indicatorUnSelectedColor: Color = .colorOnPrimary,
         @ViewBuilder content: @escaping (T) -> Content) {
        self.list = items
        self.spacing = spacing
        self.trailingSpace = trailingSpace
        self.showIndicator = showIndicator
        self.carouselHeight = carouselHeight
        self.indicatorSelectedColor = indicatorSelectedColor
        self.indicatorUnSelectedColor = indicatorUnSelectedColor
        self._index = index
        self.content = content
    }
}

#Preview {
    let posts = [Post(postImage: "placeHolder"),Post(postImage: "placeHolder"),Post(postImage: "placeHolder"),Post(postImage: "placeHolder"),Post(postImage: "placeHolder")]
    return VStack{
        SnapCarouselView(index: .constant(0), items: posts,showIndicator: true){ post in
            GeometryReader{ proxy in
                Image(post.postImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: proxy.size.width )
                    .cornerRadius(12)
            }
        }
    }
    
    
}

struct Post: Identifiable{
    var id = UUID()
    var postImage: String
}

