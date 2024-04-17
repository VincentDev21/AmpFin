//
//  PlaylistsList.swift
//  iOS
//
//  Created by Rasmus Krämer on 01.01.24.
//

import SwiftUI
import AFBase

struct PlaylistsList: View {
    let playlists: [Playlist]
    
    var body: some View {
        ForEach(playlists) { playlist in
            NavigationLink(destination: PlaylistView(playlist: playlist)) {
                PlaylistListRow(playlist: playlist)
            }
            .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 0))
        }
    }
}

#Preview {
    NavigationStack {
        List {
            PlaylistsList(playlists: [
                Playlist.fixture,
                Playlist.fixture,
                Playlist.fixture,
                Playlist.fixture,
                Playlist.fixture,
                Playlist.fixture,
                Playlist.fixture,
            ])
        }
    }
}
