//
//  MusicPlayerManager.swift
//  MusicTestApp
//
//  AVFoundation 기반 재생 엔진 + 전역 상태 관리
//

import AVFoundation
import SwiftUI
import Observation

// MARK: - 음악 아이템 모델

struct MusicItem: Identifiable, Equatable {
    let id: UUID
    let title: String
    let artist: String
    let url: URL

    init(id: UUID = UUID(), title: String, artist: String, url: URL) {
        self.id = id
        self.title = title
        self.artist = artist
        self.url = url
    }
}

// MARK: - 플레이어 매니저

@Observable
final class MusicPlayerManager {

    // MARK: 공유 인스턴스
    static let shared = MusicPlayerManager()

    // MARK: 재생 상태
    var currentItem: MusicItem? = nil
    var isPlaying: Bool = false
    var currentTime: TimeInterval = 0
    var duration: TimeInterval = 0
    var queue: [MusicItem] = []
    var currentIndex: Int = 0

    // MARK: 미니 플레이어 표시 여부
    var isMiniPlayerVisible: Bool = false

    // MARK: Private
    private var player: AVPlayer?
    private var timeObserver: Any?

    private init() {}

    // MARK: - 재생 제어

    /// 새 곡 재생
    func play(item: MusicItem, in queue: [MusicItem] = []) {
        self.queue = queue.isEmpty ? [item] : queue
        self.currentIndex = self.queue.firstIndex(of: item) ?? 0
        load(item: item)
        player?.play()
        isPlaying = true
        isMiniPlayerVisible = true
    }

    /// 재생 / 일시정지 토글
    func togglePlayPause() {
        guard player != nil else { return }
        if isPlaying {
            player?.pause()
        } else {
            player?.play()
        }
        isPlaying.toggle()
    }

    /// 이전 곡
    func playPrevious() {
        guard !queue.isEmpty else { return }
        currentIndex = max(currentIndex - 1, 0)
        load(item: queue[currentIndex])
        player?.play()
        isPlaying = true
    }

    /// 다음 곡
    func playNext() {
        guard !queue.isEmpty else { return }
        currentIndex = min(currentIndex + 1, queue.count - 1)
        load(item: queue[currentIndex])
        player?.play()
        isPlaying = true
    }

    /// n초 탐색 (양수: 앞으로, 음수: 뒤로)
    func seek(by seconds: TimeInterval) {
        let target = max(0, min(currentTime + seconds, duration))
        let time = CMTime(seconds: target, preferredTimescale: 600)
        player?.seek(to: time)
        currentTime = target
    }

    /// 특정 위치로 탐색
    func seek(to time: TimeInterval) {
        let clamped = max(0, min(time, duration))
        let cmTime = CMTime(seconds: clamped, preferredTimescale: 600)
        player?.seek(to: cmTime)
        currentTime = clamped
    }

    // MARK: - Private

    private func load(item: MusicItem) {
        removeTimeObserver()
        currentItem = item

        let playerItem = AVPlayerItem(url: item.url)
        player = AVPlayer(playerItem: playerItem)

        // 재생 시간 옵저버
        timeObserver = player?.addPeriodicTimeObserver(
            forInterval: CMTime(seconds: 0.5, preferredTimescale: 600),
            queue: .main
        ) { [weak self] time in
            self?.currentTime = time.seconds
            if let duration = self?.player?.currentItem?.duration.seconds,
               duration.isFinite {
                self?.duration = duration
            }
        }

        // 곡 종료 시 다음 곡
        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: playerItem,
            queue: .main
        ) { [weak self] _ in
            self?.playNext()
        }
    }

    private func removeTimeObserver() {
        if let observer = timeObserver {
            player?.removeTimeObserver(observer)
            timeObserver = nil
        }
    }
}
