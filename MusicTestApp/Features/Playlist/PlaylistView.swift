//
//  PlaylistView.swift
//  MusicTestApp
//
//  플레이리스트 탭 뷰
//

import SwiftUI

struct PlaylistView: View {
    var body: some View {
        ContentUnavailableView {
            Label("플레이리스트 없음", systemImage: "music.note.tv")
        } description: {
            Text("플레이리스트를 만들어 음악을 구성해 보세요.")
        } actions: {
            Button(action: {}) {
                Label("새 플레이리스트", systemImage: "plus")
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    NavigationStack {
        PlaylistView()
            .navigationTitle("플레이리스트")
    }
}
