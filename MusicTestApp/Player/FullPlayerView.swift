//
//  FullPlayerView.swift
//  MusicTestApp
//
//  풀스크린 플레이어 — 다음 타임 개발용 Placeholder
//

import SwiftUI

struct FullPlayerView: View {
    @Environment(\.dismiss) private var dismiss
    private let player = MusicPlayerManager.shared

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color(.systemBackground)
                .ignoresSafeArea()

            VStack(spacing: 24) {
                Spacer()

                Image(systemName: "music.note.tv.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .foregroundStyle(.secondary)

                VStack(spacing: 8) {
                    Text(player.currentItem?.title ?? "재생 중인 곡 없음")
                        .font(.title2.bold())
                    Text(player.currentItem?.artist ?? "")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                Text("풀스크린 플레이어는 다음 버전에서 개발됩니다.")
                    .font(.footnote)
                    .foregroundStyle(.tertiary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)

                Spacer()
            }

            // 닫기 버튼
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.down.circle.fill")
                    .font(.title)
                    .foregroundStyle(.secondary)
                    .padding()
            }
        }
    }
}

#Preview {
    FullPlayerView()
}
