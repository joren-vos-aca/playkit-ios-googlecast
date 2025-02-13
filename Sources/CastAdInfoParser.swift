// ===================================================================================================
// Copyright (C) 2017 Kaltura Inc.
//
// Licensed under the AGPLv3 license, unless a different license for a 
// particular library is specified in the applicable library path.
//
// You may obtain a copy of the License at
// https://www.gnu.org/licenses/agpl-3.0.html
// ===================================================================================================

import UIKit
import GoogleCast

/**
 CastAdInfoParser
 
 This class can be used to handle advertisement UI while casting while using google components.
 There is 2 options to use this class :
 1. set 
 
 */
@objc public class CastAdInfoParser: NSObject, GCKRemoteMediaClientAdInfoParserDelegate {
    
    
    @objc public static let shared = CastAdInfoParser()
    
    /**
     return A boolean flag indicating whether your receiver is currently playing an ad ot not
     */
    @objc public func remoteMediaClient(_ client: GCKRemoteMediaClient, shouldSetPlayingAdIn mediaStatus: GCKMediaStatus) -> Bool {
        
        guard let customData = mediaStatus.customData as? [String: Any], let adsInfo = customData["adsInfo"] as? [String: Any] else {
            return false
        }
        let metadata = AdsMetadata(dict: adsInfo)
        
        return metadata.isPlayingAd
    }
    
    /**
     A list of playback positions at which the ads occur.
     */
    @objc public func remoteMediaClient(_ client: GCKRemoteMediaClient, shouldSetAdBreaksIn mediaStatus: GCKMediaStatus) -> [GCKAdBreakInfo]? {
        
        guard let customData = mediaStatus.customData as? [String: Any], let adsInfo = customData["adsInfo"] as? [String: Any] else {
            return nil
        }
        
        let metadata = AdsMetadata(dict: adsInfo)
        let adsBreakInfo = metadata.adsBreakInfo ?? []
        
        let adsBreakInfoArray = adsBreakInfo.map { (position) -> GCKAdBreakInfo in
            let builder = GCKAdBreakInfoBuilder(adBreakID: "", adBreakClipIds: nil)
            builder.playbackPosition = TimeInterval(position)
            let adBreakInfo = builder.build()
            return adBreakInfo
        }
        
        return adsBreakInfoArray
    }
}



/**
  An object which represent the Ads info 
  The receiver is sending this data by the mediaStatus's customData
 */
private class AdsMetadata: NSObject {
    
    public let adsBreakInfo: [Int]?
    public let isPlayingAd: Bool
    
    public init(dict:[String:Any]) {
        
        if let isPlaying = dict["isPlayingAd"] as? Bool {
            self.isPlayingAd = isPlaying
        } else {
            self.isPlayingAd = false
        }
        
        if let adBreaksInfo = dict["adsBreakInfo"] as? [NSNumber] {
            self.adsBreakInfo = adBreaksInfo.map({ (number:NSNumber) -> Int in
                return number.intValue
            })
        } else {
            self.adsBreakInfo  = nil
        }
    }
}
