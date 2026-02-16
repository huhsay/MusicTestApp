//
//  MusicListView.swift
//  MusicTestApp
//
//  음악 리스트 탭 뷰 — 더미 데이터 + 미니 플레이어 연동
//

import SwiftUI

// MARK: - 더미 데이터

private extension MusicItem {
    static let dummies: [MusicItem] = [
        MusicItem(
            title: "Blinding Lights",
            artist: "The Weeknd",
            url: URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3")!
        ),
        MusicItem(
            title: "Shape of You",
            artist: "Ed Sheeran",
            url: URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3")!
        ),
        MusicItem(
            title: "Stay",
            artist: "The Kid LAROI",
            url: URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3")!
        ),
        MusicItem(
            title: "Levitating",
            artist: "Dua Lipa",
            url: URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3")!
        ),
        MusicItem(
            title: "Peaches",
            artist: "Justin Bieber",
            url: URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-5.mp3")!
        ),
        MusicItem(
            title: "Good 4 U",
            artist: "Olivia Rodrigo",
            url: URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-6.mp3")!
        ),
        MusicItem(
            title: "Montero",
            artist: "Lil Nas X",
            url: URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-7.mp3")!
        ),
        MusicItem(
            title: "Kiss Me More",
            artist: "Doja Cat",
            url: URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-8.mp3")!
        ),
    ]
}

// MARK: - MusicListView

struct MusicListView: View {
    private let player = MusicPlayerManager.shared
    private let tracks = MusicItem.dummies

    var body: some View {
        List(tracks) { item in
            MusicRowView(item: item, isPlaying: player.currentItem == item && player.isPlaying)
                .contentShape(Rectangle())
                .onTapGesture {
                    player.play(item: item, in: tracks)
                }
        }
        .listStyle(.plain)
    }
}

// MARK: - 음악 행 셀

private struct MusicRowView: View {
    let item: MusicItem
    let isPlaying: Bool

    var body: some View {
        HStack(spacing: 14) {
            // 앨범 아트 (더미 — SF Symbol)
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.accentColor.opacity(0.15))
                    .frame(width: 48, height: 48)
                Image(systemName: isPlaying ? "waveform" : "music.note")
                    .font(.title3)
                    .foregroundStyle(Color.accentColor)
                    .symbolEffect(.variableColor.iterative, isActive: isPlaying)
            }

            // 제목 / 아티스트
            VStack(alignment: .leading, spacing: 3) {
                Text(item.title)
                    .font(.subheadline.bold())
                    .foregroundStyle(isPlaying ? Color.accentColor : .primary)
                    .lineLimit(1)
                Text(item.artist)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }

            Spacer()

            // 재생 중 표시
            if isPlaying {
                Image(systemName: "speaker.wave.2.fill")
                    .font(.caption)
                    .foregroundStyle(Color.accentColor)
            }
        }
        .padding(.vertical, 4)
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        MusicListView()
            .navigationTitle("음악 리스트")
    }
}
