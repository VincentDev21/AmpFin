//
//  NowPlayingBackground.swift
//  Multiplatform
//
//  Created by Rasmus Krämer on 09.04.24.
//

import Foundation
import SwiftUI
import UIKit
import FluidGradient
import AmpFinKit

extension NowPlaying {
    struct Background: View {
        let cover: Cover?
        let dragging: Bool
        
        @State private var imageColors = ImageColors()
        
        var body: some View {
            ZStack {
                if let cover {
                    Color.black
                    
                    ItemImage(cover: cover)
                        .id(cover.url)
                        .blur(radius: 100)
                        .frame(maxWidth: .infinity)
                    
                    FluidGradient(blobs: [imageColors.background, imageColors.detail, imageColors.primary, imageColors.secondary], speed: CGFloat.random(in: 0.2...0.4), blur: 0.8)
                        .ignoresSafeArea(edges: .all)
                } else {
                    Color.black
                    Color.gray.opacity(0.8)
                }
            }
            .allowsHitTesting(false)
            .overlay(.black.opacity(0.25))
            #if !os(visionOS)
            .clipShape(.rect(cornerRadius: dragging ? UIScreen.main.displayCornerRadius : 0))
            #endif
            .task(id: cover?.url) {
                await imageColors.update(cover: cover)
            }
        }
    }
}