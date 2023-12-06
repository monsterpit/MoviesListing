//
//  Carousel2DView.swift
//  SugarBoxAssetment
//
//  Created by Vikas Salian on 06/12/23.
//

import SwiftUI

struct Carousel2DView: View {
    
    let title: String
    let imageURLs: [URL]
    var body: some View {
        
        VStack{
            HStack{
                Rectangle()
                    .fill(.colorSecondary)
                    .frame(width: 2,height: 25)
                    .cornerRadius(3.0)
                    .padding(.trailing,10)
                
                Text(title)
                    .font(.caption)
                
                    .foregroundStyle(.colorOnPrimary)
                Spacer()
            }
            ScrollView(.horizontal){
                HStack(spacing: 10){
                    ForEach(imageURLs){ imageURL in
                        AsyncImage(url: imageURL) { imagePhase in
                            if let image = imagePhase.image{
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .containerRelativeFrame(.horizontal){ width,size in
                                        width * 0.4
                                    }
                                    .frame(height: 110)
                                    .clipShape(RoundedRectangle(cornerRadius: 8, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
                            }else{
                                Image(.placeHolder)
                                    .resizable()
                                    .scaledToFill()
                                    .containerRelativeFrame(.horizontal){ width,size in
                                        width * 0.4
                                    }
                                    .frame(height: 110)
                                    .clipShape(RoundedRectangle(cornerRadius: 8, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
                            }
                            
                        }
                    }
                }
            }
            .scrollBounceBehavior(.basedOnSize)
            .scrollIndicators(.never)
        }.padding(.vertical)
    }
    
    init(title: String,imageURLs: [URL]){
        self.title = title
        self.imageURLs = imageURLs
    }
}

#Preview {
    Carousel2DView(title: "Movie", imageURLs: [URL(string: "https://static01.sboxdc.com/images/zee5/17ccdeea-d733-4615-9f90-67d2c1523b0b/resources/0-6-1160_34836872/list/270x152/1170x658withlog19714492472b01906419fb42fd808f9547fa4cb358.jpg")!])
        .background(.colorPrimary)
}

