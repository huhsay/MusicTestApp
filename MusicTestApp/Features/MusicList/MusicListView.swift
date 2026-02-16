//
//  MusicListView.swift
//  MusicTestApp
//
//  음악 리스트 탭 뷰
//

import SwiftUI

struct MusicListView: View {
    var body: some View {
        ContentUnavailableView {
            Label("음악 없음", systemImage: "music.note.list")
        } description: {
            Text("음악을 추가하면 여기에 표시됩니다.")
        } actions: {
            Button(action: {}) {
                Label("음악 추가", systemImage: "plus")
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    NavigationStack {
        MusicListView()
            .navigationTitle("음악 리스트")
    }
}
