//
//  FilesView.swift
//  MusicTestApp
//
//  파일 탭 뷰
//

import SwiftUI

struct FilesView: View {
    var body: some View {
        ContentUnavailableView {
            Label("파일 없음", systemImage: "folder")
        } description: {
            Text("음악 파일을 가져오면 여기에 표시됩니다.")
        } actions: {
            Button(action: {}) {
                Label("파일 가져오기", systemImage: "square.and.arrow.down")
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    NavigationStack {
        FilesView()
            .navigationTitle("파일")
    }
}
