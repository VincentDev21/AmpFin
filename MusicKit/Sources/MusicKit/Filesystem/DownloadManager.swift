//
//  DownloadManager.swift
//  Music
//
//  Created by Rasmus Krämer on 08.09.23.
//

import Foundation
import OSLog

public class DownloadManager: NSObject {
    private(set) var documentsURL: URL!
    private(set) var urlSession: URLSession!
    
    let logger = Logger(subsystem: "io.rfk.music", category: "Download")
    
    override private init() {
        super.init()
        
        let config = URLSessionConfiguration.background(withIdentifier: "\(Bundle.main.bundleIdentifier!).background")
        config.isDiscretionary = false
        config.sessionSendsLaunchEvents = true
        
        urlSession = URLSession(configuration: config, delegate: self, delegateQueue: OperationQueue())
        documentsURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        
        createDirectories()
    }
    
    func createDirectories() {
        try! FileManager.default.createDirectory(at: documentsURL.appending(path: "covers"), withIntermediateDirectories: true)
        try! FileManager.default.createDirectory(at: documentsURL.appending(path: "tracks"), withIntermediateDirectories: true)
    }
}

// MARK: Singleton

extension DownloadManager {
    public static let shared = DownloadManager()
}