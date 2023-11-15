//
//  Track.swift
//  Music
//
//  Created by Rasmus Krämer on 06.09.23.
//

import Foundation

public class Track: Item {
    public let album: ReducedAlbum
    public let artists: [ReducedArtist]
    
    public let lufs: Float?
    public let index: Index
    public let playCount: Int
    public let releaseDate: Date?
    
    public init(id: String, name: String, sortName: String?, cover: Cover? = nil, favorite: Bool, album: ReducedAlbum, artists: [ReducedArtist], lufs: Float?, index: Index, playCount: Int, releaseDate: Date?) {
        self.album = album
        self.artists = artists
        self.lufs = lufs
        self.index = index
        self.playCount = playCount
        self.releaseDate = releaseDate
        
        super.init(id: id, name: name, sortName: sortName, cover: cover, favorite: favorite)
    }
    
    override func checkOfflineStatus() {
        Task.detached { [self] in
            self._offline = await OfflineManager.shared.getTrackOfflineStatus(trackId: id)
        }
    }
    override func addObserver() -> [NSObjectProtocol] {
        [NotificationCenter.default.addObserver(forName: OfflineManager.trackDownloadStatusChanged, object: nil, queue: Item.operationQueue) { [weak self] notification in
            if notification.object as? String == self?.id {
                self?.checkOfflineStatus()
            }
        }]
    }
}

// MARK: Helper

extension Track {
    public typealias Lyrics = [Double: String?]
    
    public struct ReducedAlbum {
        public let id: String
        public let name: String?
        public let artists: [ReducedArtist]
    }
    
    public struct Index: Comparable, Codable {
        public let index: Int
        public let disk: Int
        
        public static func < (lhs: Index, rhs: Index) -> Bool {
            if lhs.disk == rhs.disk {
                return lhs.index < rhs.index
            } else {
                return lhs.disk < rhs.disk
            }
        }
    }
}