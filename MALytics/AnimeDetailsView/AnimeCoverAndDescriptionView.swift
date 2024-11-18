//
//  AnimeCoverAndDescriptionView.swift
//  MALytics
//
//  Created by Cem Caylak on 17.11.24.
//

import SwiftUI

struct AnimeCoverAndDescriptionView: View {
    
    let title: String
    let imageUrl: String
    let rating: Double
    let episodes: Int
    let mediaType: String
    let year: String
    let description: String

    
    @State private var isDescriptionExpanded = false
    
    var body: some View {
        HStack (alignment: .top, spacing: 10) {
            ZStack(alignment: .topTrailing) {
                AsyncImageView(imageUrl: imageUrl)
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity, alignment: .leading)
                .cornerRadius(12)
            }
            .overlay(alignment: .topTrailing) {
                HStack {
                    Text("\(rating.formatted())")
                        .font(.title3)
                        .bold()
                        .foregroundStyle(.white)
                    
                    Image(systemName: "star.fill")
                        .foregroundStyle(.white)
                }
                .padding(4)
                .background(Material.ultraThin)
                .cornerRadius(12)
            }
            .overlay(alignment: .bottomTrailing) {
                Text("\(episodes) \(episodes==1 ? "episode" : "episodes")")
                    .bold()
                    .font(.title3)
                    .padding(4)
                    .foregroundStyle(.white)
                    .background(Material.ultraThin)
                    .cornerRadius(12)
                
            }
            .cornerRadius(12)
            .frame(maxWidth: .infinity)
            
            VStack (alignment: .leading) {
                HStack {
                    Text("\(mediaType.capitalized), \(year.prefix(4))")
                }
                .font(.subheadline)
                .padding(.bottom, 3)
                
                .bold()
                Text(description)
                    .lineLimit(10)
                    .font(.subheadline)
                    .truncationMode(.tail)
                Button(isDescriptionExpanded ? "Collapse" : "Expand") {
                    isDescriptionExpanded.toggle()
                }
                .font(.caption)
                .sheet(isPresented: $isDescriptionExpanded) {
                    ScrollView {
                        LazyVStack(alignment: .leading) {
                            Text(title)
                                .font(.headline)
                                .padding(.bottom)
                            Text(description)
                                .font(.subheadline)
                            
                        }
                    }
                    .padding()
                    .scrollBounceBehavior(.basedOnSize)
                
                }
            }
        }
    }
}

#Preview {
    AnimeCoverAndDescriptionView(title: "Tokyo Ghoul", imageUrl: "https://cdn.myanimelist.net/images/anime/9/74398l.jpg", rating: 10.0, episodes: 10, mediaType: "TV", year: "2024", description: """
One year after the events at the Sanctuary, Subaru Natsuki trains hard to better face future challenges. The peaceful days come to an end when Emilia receives an invitation to a meeting in the Watergate City of Priestella from none other than Anastasia Hoshin, one of her rivals in the royal selection. Considering the meeting's significance and the potential dangers Emilia could face, Subaru and his friends accompany her.

However, as Subaru reconnects with old associates and companions in Priestella, new formidable foes emerge. Driven by fanatical motivations and engaging in ruthless methods to achieve their ambitions, the new enemy targets Emilia and threaten the very existence of the city. Rallying his allies, Subaru must give his all once more to stop their and nefarious goals from becoming a concrete reality.

[Written by MAL Rewrite]
"""
)
}
