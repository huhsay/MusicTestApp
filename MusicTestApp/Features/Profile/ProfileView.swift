//
//  ProfileView.swift
//  MusicTestApp
//
//  내 정보 탭 뷰
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        ContentUnavailableView {
            Label("프로필 없음", systemImage: "person.crop.circle")
        } description: {
            Text("계정에 로그인하면 내 정보를 확인할 수 있습니다.")
        } actions: {
            Button(action: {}) {
                Label("로그인", systemImage: "arrow.right.circle")
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    NavigationStack {
        ProfileView()
            .navigationTitle("내 정보")
    }
}
