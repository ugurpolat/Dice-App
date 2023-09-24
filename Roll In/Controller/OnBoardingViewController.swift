//
//  ViewController.swift
//  Roll In
//
//  Created by Ugur Polat on 16.09.2023.
//

import UIKit
import AVFoundation
import Combine

class OnBoardingViewController: UIViewController {
    
    @IBOutlet weak var darkView: UIView!
    @IBOutlet weak var getStartedButton: UIButton!
    
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?
    private let notificationCenter = NotificationCenter.default
    private var appEventSubscribers = [AnyCancellable]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        observeAppEvents()
        setupPlayerIfNeeded()
        restartVideo()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        removeAppEventsSubscribers()
        removePlayer()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerLayer?.frame = view.bounds
    }
    private func setupViews() {
        getStartedButton.layer.cornerRadius = getStartedButton.frame.height / 2
        getStartedButton.layer.masksToBounds = true
        //darkView.backgroundColor = UIColor.init(white: 0.1, alpha: 0.1)
        darkView.backgroundColor = .clear
    }
    
    private func buildPlayer() -> AVPlayer? {
        
        guard let filePath = Bundle.main.path(forResource: "bg_video", ofType: "mp4") else { return nil}
        let url : URL
        if #available(iOS 16.0, *) {
            url = URL(filePath: filePath)
        } else {
            url = URL(fileURLWithPath: filePath)
        }
        let player = AVPlayer(url: url)
        player.actionAtItemEnd = .none
        player.isMuted = true
        
        return player
    }
    
    private func buildPlayerLayer() -> AVPlayerLayer? {
        let layer = AVPlayerLayer(player: player)
        layer.videoGravity = .resizeAspectFill
        
        return layer
    }
    
    private func removePlayer() {
        player?.pause()
        player = nil
        
        playerLayer?.removeFromSuperlayer()
        playerLayer = nil
    }
    
    private func playVideo() {
        player?.play()
        if #available(iOS 16.0, *) {
            player?.defaultRate = Float(1.5)
        } else {
            player?.rate = 1.5
        }
        
    }
    
    private func restartVideo() {
        player?.seek(to: .zero)
        playVideo()
    }
    
    private func pauseVideo() {
        player?.pause()
    }
    
    private func observeAppEvents() {
        notificationCenter.publisher(for: .AVPlayerItemDidPlayToEndTime).sink { [weak self] _ in
            self?.restartVideo()
        }.store(in: &appEventSubscribers)
        
        notificationCenter.publisher(for: UIApplication.willResignActiveNotification).sink { [weak self] _ in
            self?.pauseVideo()
        }.store(in: &appEventSubscribers)
        
        notificationCenter.publisher(for: UIApplication.didBecomeActiveNotification).sink { [weak self] _ in
            self?.playVideo()
        }.store(in: &appEventSubscribers)
        
    }
    
    private func removeAppEventsSubscribers() {
        appEventSubscribers.forEach { subscriber in
            subscriber.cancel()
        }
    }
    
    private func setupPlayerIfNeeded() {
        player = buildPlayer()
        playerLayer = buildPlayerLayer()
        
        if let layer = self.playerLayer, view.layer.sublayers?.contains(layer) == false {
                view.layer.insertSublayer(layer, at: 0)
            }
    }
 
    
}


